SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


/******************************************************************************************************
	aec_BL_Core_TimesheetReminder_Unapproved
Purpose
    Email Line Managers/Project Managers if there are unapproved timesheets in the previous week for 
    their resources.	
    
    One email per Line Manager/Project Manager
Behaviour
	
Parameters
	@pUserCode		- The Code of the user executing the procedure
	@pType			- The Type of Notification (18 - Line Manager/19 - Project Manager)
	
Prerequisites
	
Return
    Nothing

*******************************************************************************************************
                                             Version History
*******************************************************************************************************
PR1 24/09/2014 - Created

NF2 23/06/2015 - Fix, Arithmetic Overflow error due to high number of hours

NF3 26/08/2015 - Fix, Re-instate Timesheet Date filter inadvertantly removed by NF2

PR4 08/10/2015 - Fix, [QEZ-444-56056] Missing/Incomplete Timesheet Reminder not selecting the correct dates

MTA5 - 11/11/2015
																		------
	Fix, [TBP-234-29409] Incomplete time sheets for previous week. \ KCOM PH  | -----> If Resource Notification culture is empty then
	Fix, [TAW-590-70427] Timesheet Notification Tests						  | -----> set it from SystemParams 'NOTIFICATIONS-DEFAULT-CULTURE'
																		------
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_TimesheetReminder_Unapproved](
	@pUserCode AS NVARCHAR(20),
	@pType AS INTEGER
)
AS
BEGIN
	-- Generic Constants
	DECLARE @C_LinebreakToken NVARCHAR(5); SET @C_LinebreakToken = '<br/>';
	DECLARE @C_CarriageReturn NVARCHAR(1); SET @C_CarriageReturn = CHAR(13);	
	DECLARE @C_NotificationStatus_Unread INT; SET @C_NotificationStatus_Unread = 0;	
	DECLARE @C_NotificationSource_ScheduledJob INT; SET @C_NotificationSource_ScheduledJob = 1;
	DECLARE @C_NotificationsActive NVARCHAR(250); SET @C_NotificationsActive = N'NOTIFICATIONS-ACTIVE';		
	DECLARE @C_NotificationsEmailActive NVARCHAR(30); SET @C_NotificationsEmailActive = N'NOTIFICATIONS-EMAIL-ACTIVE';
	DECLARE @C_NotificationsEmailSubjectPrefix NVARCHAR(50); SET @C_NotificationsEmailSubjectPrefix = N'NOTIFICATIONS-EMAIL-SUBJECT-PREFIX';
	DECLARE @C_DataToken_EmailLoginStart NVARCHAR(20); SET @C_DataToken_EmailLoginStart = '<email login>';
	DECLARE @C_DataToken_EmailLoginEnd NVARCHAR(20); SET @C_DataToken_EmailLoginEnd = '</email login>';
	DECLARE @C_DataToken_EmailLoginUrl NVARCHAR(20); SET @C_DataToken_EmailLoginUrl = N'<email login url>';
	DECLARE @C_EmailLoginUrl NVARCHAR(250); SET @C_EmailLoginUrl = N'NOTIFICATIONS-EMAIL-LOGIN-URL';
	
	-- Specific Constants
	DECLARE @C_NotificationType_Timesheet INT; SET @C_NotificationType_Timesheet = 5;
	DECLARE @C_NotificationEvent_UnnaprovedTimesheets_LM INT; SET @C_NotificationEvent_UnnaprovedTimesheets_LM = 18;
	DECLARE @C_NotificationEvent_UnnaprovedTimesheets_PR INT; SET @C_NotificationEvent_UnnaprovedTimesheets_PR = 19;
	DECLARE @C_DataToken_WeekStart NVARCHAR(20); SET @C_DataToken_WeekStart = N'<week start date>';			
	DECLARE @C_DataToken_ResourceList NVARCHAR(20); SET @C_DataToken_ResourceList = N'<ResourceList>';
	DECLARE @C_DataToken_LabelResources NVARCHAR(20); SET @C_DataToken_LabelResources = N'#LABEL-RESOURCES#';

	-- Generic Notification Variables
	DECLARE @NotificationsActive INTEGER;
	DECLARE @NotificationsEmailActive INTEGER;
	DECLARE @NotificationsEmailSubjectPrefix NVARCHAR(250);
	DECLARE @EmailLoginUrl NVARCHAR(250);	
	DECLARE @NotificationText NVARCHAR(MAX);
	DECLARE @NotificationSubject NVARCHAR(250);
	DECLARE @EmailNotificationText NVARCHAR(MAX);	
	DECLARE @intStartIndex INTEGER;
	DECLARE @intEndIndex INTEGER;
	DECLARE @intLength INTEGER;
	
	-- Specific Variables
	DECLARE @WeekStartDate DATETIME; 
	DECLARE @WeekStartDateCultureSpecific NVARCHAR(30); 
	DECLARE @bow FLOAT;
	DECLARE @OurDateFirst INT;	
	DECLARE @currentRECode NVARCHAR(20);			
	DECLARE @resCulture NVARCHAR(20);	
	DECLARE @ResEmail NVARCHAR(70);	
	DECLARE @SL_Resources NVARCHAR(50);
	DECLARE @SL_TimeUnit NVARCHAR(50);
	DECLARE @CurrentOADateTime FLOAT;
	DECLARE @dblCurrentOATime AS FLOAT;
	DECLARE @dtNow AS DateTime; SET @dtNow = GetDate();
	DECLARE @CurrentOADate FLOAT; SET @CurrentOADate = DATEDIFF(dd, CAST('18991230' AS DateTime), @dtNow);					
	DECLARE @resetDateFirst INT; SET @resetDateFirst = @@DATEFIRST;
	DECLARE @SubordinateName NVARCHAR(70);
	DECLARE @UnapprovedHours FLOAT;
	DECLARE @ResourceListText NVARCHAR(MAX);

	-- Check Notifications are Active
	SELECT @NotificationsActive = CAST(ISNULL(SP_Number, 0) AS INTEGER)
	FROM SystemParams
	WHERE SP_Code = @C_NotificationsActive

	IF (@NotificationsActive<>0)
	BEGIN
		-- Check Email Notifications are active
		SELECT @NotificationsEmailActive = CAST(ISNULL(SP_Number, 0) AS INTEGER)
		FROM SystemParams
		WHERE SP_Code = @C_NotificationsEmailActive;

		IF (@NotificationsEmailActive <> 0)
		BEGIN
			-- Get Email Subject Prefix
			SELECT @NotificationsEmailSubjectPrefix = ISNULL(SP_Value, '')
			FROM SystemParams
			WHERE SP_Code = @C_NotificationsEmailSubjectPrefix;

			-- Get Email Login Url
			SELECT @EmailLoginUrl = ISNULL(SP_Value, '')
			FROM SystemParams
			WHERE SP_Code = @C_EmailLoginUrl
		END

		---- Set current Date & Time
		SET @dblCurrentOATime = CONVERT(FLOAT, @dtNow)
		SET @dblCurrentOATime = @dblCurrentOATime - FLOOR(@dblCurrentOATime)		
		SET @CurrentOADateTime = @CurrentOADate + @dblCurrentOATime;
		
		-- calculate the start of week date, taking into account the week start setting in SystemConfig
		-- we have to set up the first day of week before starting
		SELECT @bow = SP_Number FROM SystemParams WHERE SP_Code = 'SYS-BOW';

		-- All values stored in SYS-BOW map to the .net DayOfWeek enumeration + 1
		-- therefore, values go from, 1=Sunday to 7=Saturday.
		-- We now need to set the correct DATEFIRST value in SQL to match the SystemConfig setting.
		-- This ensures we calculate the same start/end of the week as the user sees in Timesheet entry.
		SELECT @OurDateFirst = CASE CAST(@bow as SMALLINT)
				WHEN 1 THEN 7
				WHEN 2 THEN 1
				WHEN 3 THEN 2
				WHEN 4 THEN 3
				WHEN 5 THEN 4
				WHEN 6 THEN 5
				WHEN 7 THEN 6
			ELSE
				1
			END;

		SET DATEFIRST @OurDateFirst;
		SELECT @WeekStartDate = CONVERT(NVARCHAR(30),(GetDate() -(DATEPART(dw, GetDate())-1) - 7), 107);

		-- reset the @@DATEFIRST value...this should get done after this sp has finished, but do it here just to be sure
		SET DATEFIRST @resetDateFirst;					
						
		IF (@pType = @C_NotificationEvent_UnnaprovedTimesheets_LM)
		BEGIN
			-- Line Manager
			DECLARE curManagers CURSOR LOCAL FAST_FORWARD FOR									
				SELECT DISTINCT Approver.RE_Code, Approver.RE_Email, ISNULL(Approver.CLC_Code, '')
				FROM Res AS Approver
				LEFT OUTER JOIN Res AS Subordinate ON Subordinate.RE_LineManager = Approver.RE_Code
				INNER JOIN Timesht ON Timesht.RE_Code = Subordinate.RE_Code AND Timesht.TS_Date >= DATEDIFF(d,'30-DEC-1899',@WeekStartDate) AND Timesht.TS_Date < DATEDIFF(d,'30-DEC-1899',@WeekStartDate) + 7
				INNER JOIN Users ON Users.RE_Code = Approver.RE_Code
				INNER JOIN LoginGroupNotificationDefs ON LoginGroupNotificationDefs.LG_Code = Users.LG_Code
				WHERE Users.Active = -1
				AND Approver.Active = -1
				AND Subordinate.Active = -1
				AND LoginGroupNotificationDefs.ND_Key = @pType
				AND ISNULL(Timesht.TS_Approved,0) = 0
		END
		ELSE
		BEGIN
			-- Project Manager
			DECLARE curManagers CURSOR LOCAL FAST_FORWARD FOR									
				SELECT DISTINCT ProjectManager.RE_Code, ProjectManager.RE_Email, ISNULL(ProjectManager.CLC_Code, '')
				FROM Res AS ProjectManager
				INNER JOIN Users ON Users.RE_Code = ProjectManager.RE_Code
				INNER JOIN LoginGroupNotificationDefs ON LoginGroupNotificationDefs.LG_Code = Users.LG_Code
				INNER JOIN Projects ON Projects.RE_CodeProjectManager = ProjectManager.RE_Code
				INNER JOIN Timesht ON Timesht.PR_Code = Projects.PR_Code AND Timesht.TS_Date >= DATEDIFF(d,'30-DEC-1899',@WeekStartDate) AND Timesht.TS_Date < DATEDIFF(d,'30-DEC-1899',@WeekStartDate) + 7
				INNER JOIN Res AS Subordinate ON Subordinate.RE_Code = Timesht.RE_Code
				WHERE Users.Active = -1
				AND ProjectManager.Active = -1
				AND Subordinate.Active = -1
				AND Projects.Active = -1
				AND ISNULL(Timesht.TS_Approved,0) = 0
				AND LoginGroupNotificationDefs.ND_Key = 19
		END
		
		OPEN curManagers;
		
		FETCH NEXT FROM curManagers INTO @currentRECode, @ResEmail, @resCulture;

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			-- reset any work variables
			SET @NotificationText = '';
			SET @NotificationSubject = '';
			
			--if the resource notification culture is empty then grab the value from the SystemParams table..
			IF (LEN(@resCulture) = 0)
				BEGIN
					SELECT @resCulture = SP_Value
					FROM SystemParams
					WHERE SP_Code = 'NOTIFICATIONS-DEFAULT-CULTURE'
				END
				
			--set Week Start date to British\French\Spanish By Default
			SELECT @WeekStartDateCultureSpecific = CONVERT(NVARCHAR(30),@WeekStartDate, 103)
			
			IF UPPER(@resCulture) = 'EN-US' 
				BEGIN
					SELECT @WeekStartDateCultureSpecific = CONVERT(NVARCHAR(30),@WeekStartDate, 101)
				END
			
			IF UPPER(@resCulture) = 'PT' OR UPPER(@resCulture) = 'NL'
				BEGIN
					SELECT @WeekStartDateCultureSpecific = CONVERT(NVARCHAR(30),@WeekStartDate, 105)
				END
			
			IF UPPER(@resCulture) = 'DE' OR UPPER(@resCulture) = 'FI' OR UPPER(@resCulture) = 'RU' 
				BEGIN
					SELECT @WeekStartDateCultureSpecific = CONVERT(NVARCHAR(30),@WeekStartDate, 104)
				END
			
			IF UPPER(@resCulture) = 'SV' OR UPPER(@resCulture) = 'PL'
				BEGIN
					SELECT @WeekStartDateCultureSpecific = SUBSTRING(CONVERT(NVARCHAR(30),@WeekStartDate, 121), 0, 11)
				END
			
			-- Get the notification text, based on the recipient resources culture
			IF (LEN(@resCulture) = 0)
			BEGIN
				-- Default culture
				SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
				FROM NotificationDefinition 
				WHERE ND_Key = @pType;
			END
			ELSE
			BEGIN
				-- Culture specific
				IF EXISTS(SELECT * FROM NotificationDefinitionCulture WHERE ND_Key = @pType AND CLC_Code = @resCulture)
				BEGIN
					SELECT @NotificationText = NDC_Text, @NotificationSubject = NDC_Subject 
						FROM NotificationDefinitionCulture 
						WHERE ND_Key = @pType AND CLC_Code = @resCulture;
				END
				ELSE
				BEGIN
					SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
						FROM NotificationDefinition 
						WHERE ND_Key = @pType;
				END
			END

			-- Got the Main Text, now replace tokens			
			--<week start date>
			SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_DataToken_WeekStart, @WeekStartDateCultureSpecific);
			SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_WeekStart, @WeekStartDateCultureSpecific);
			
			--#LABEL-TIMEUNIT
			SET @SL_TimeUnit = ''
			SELECT @SL_TimeUnit = SP_Value FROM SystemParams WHERE SP_Code = 'SL-UNITTIMEP.' + UPPER(@resCulture)

			IF(LEN(@SL_TimeUnit) = 0)
				SELECT @SL_TimeUnit = SP_Value FROM SystemParams WHERE SP_Code = 'SL-UNITTIMEP'
							
			--#LABEL-RESOURCES#
			SET @SL_Resources = ''
			SELECT @SL_Resources = SP_Value FROM SystemParams WHERE SP_Code = 'SL-RESOURCES.' + UPPER(@resCulture)

			IF(LEN(@SL_Resources) = 0)
				SELECT @SL_Resources = SP_Value FROM SystemParams WHERE SP_Code = 'SL-RESOURCES'

			SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_LabelResources, @SL_Resources)					
			
			-- <ResourceList> This varies between type
			IF (@pType = @C_NotificationEvent_UnnaprovedTimesheets_LM)
			BEGIN		
				SET @ResourceListText = NULL;
											
				DECLARE curResources CURSOR LOCAL FAST_FORWARD FOR
					SELECT DISTINCT RE_Desc, ISNULL(SUM(Timesht.TS_Hours),0)
					FROM Res AS Subordinate
					INNER JOIN Timesht ON Timesht.RE_Code = Subordinate.RE_Code AND Timesht.TS_Date >= DATEDIFF(d,'30-DEC-1899',@WeekStartDate) AND Timesht.TS_Date < DATEDIFF(d,'30-DEC-1899',@WeekStartDate) + 7
					WHERE Subordinate.RE_LineManager = @currentRECode
					AND ISNULL(Timesht.TS_Approved,0) = 0
					GROUP BY RE_Desc
			
				OPEN curResources;
				FETCH NEXT FROM curResources INTO @SubordinateName,@UnapprovedHours;

				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					IF (@ResourceListText IS NULL)
					BEGIN
						SET @ResourceListText = @SubordinateName + ' - ' + CONVERT(NVARCHAR(20),@UnapprovedHours) + ' ' + @SL_TimeUnit;
					END
					ELSE
					BEGIN
						SET @ResourceListText = @ResourceListText + CHAR(13) + @SubordinateName + ' - ' + CONVERT(NVARCHAR(20),@UnapprovedHours) + ' ' + @SL_TimeUnit;
					END					
					FETCH NEXT FROM curResources INTO @SubordinateName,@UnapprovedHours;
				END

				CLOSE curResources;
				DEALLOCATE curResources;
				
				SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_ResourceList, @ResourceListText);											
			END	

			-- <ResourceList> This varies between type
			IF (@pType = @C_NotificationEvent_UnnaprovedTimesheets_PR)
			BEGIN					
				DECLARE @ProjectName NVARCHAR(70);
				
				SET @ResourceListText = NULL;				
						
				DECLARE curResources CURSOR LOCAL FAST_FORWARD FOR
					SELECT Projects.PR_Code + ' - ' + Projects.PR_Desc, Subordinate.RE_Desc, ISNULL(SUM(Timesht.TS_Hours), 0)
					FROM Projects
					INNER JOIN Timesht ON Timesht.PR_Code = Projects.PR_Code AND Timesht.TS_Date >= DATEDIFF(d,'30-DEC-1899',@WeekStartDate) AND Timesht.TS_Date < DATEDIFF(d,'30-DEC-1899',@WeekStartDate) + 7
					INNER JOIN Res AS Subordinate ON Subordinate.RE_Code = Timesht.RE_Code
					WHERE RE_CodeProjectManager = @currentRECode
					AND ISNULL(Timesht.TS_Approved,0) = 0
					GROUP BY Projects.PR_Code + ' - ' + Projects.PR_Desc, Subordinate.RE_Desc
					ORDER BY Projects.PR_Code + ' - ' + Projects.PR_Desc, RE_Desc
			
				OPEN curResources;
				FETCH NEXT FROM curResources INTO @ProjectName,@SubordinateName,@UnapprovedHours;

				DECLARE @LastProject NVARCHAR(70); SET @LastProject = '';
				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					IF (@ProjectName <> @LastProject)
					BEGIN
						IF (@ResourceListText IS NULL)
						BEGIN
							SET @ResourceListText = @ProjectName;
						END
						ELSE
						BEGIN
							SET @ResourceListText = @ResourceListText + CHAR(13) + CHAR(13) + @ProjectName;
						END							
					END										
					SET @ResourceListText = @ResourceListText + CHAR(13) + '    ' +  @SubordinateName + ' - ' + CONVERT(NVARCHAR(20),@UnapprovedHours) + ' ' + @SL_TimeUnit;
					
					SET @LastProject = @ProjectName
					FETCH NEXT FROM curResources INTO @ProjectName,@SubordinateName,@UnapprovedHours;
				END

				CLOSE curResources;
				DEALLOCATE curResources;
				
				SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_ResourceList, @ResourceListText);											
			END

			-- Copy now for Email use
			SET @EmailNotificationText = @NotificationText

			-- Remove Email-specific sections
			SET @intStartIndex = CHARINDEX(@C_DataToken_EmailLoginStart, @NotificationText);
			SET @intEndIndex = CHARINDEX(@C_DataToken_EmailLoginEnd, @NotificationText) + LEN(@C_DataToken_EmailLoginEnd) - 1;
			SET @intLength = @intEndIndex - @intStartIndex + 1;
			SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');

			-- Create Notification in the application
			INSERT INTO Notifications (RE_Code, NTF_Date, NTF_Source, ND_Key, NTF_Type, NTF_Status, NTF_Text, NTF_Subject, NTF_ContextCode, NTF_ContextDate, US_CodeLastEdit, NTF_LastEditDate)
				VALUES (@currentRECode, 
						@CurrentOADateTime,  
						@C_NotificationSource_ScheduledJob,	-- Scheduled
						@pType,								-- Event key (see NotificationDefinition table)
						@C_NotificationType_Timesheet,		-- Timesheet
						@C_NotificationStatus_Unread,		-- Unread
						@NotificationText,
						@NotificationSubject,
						@currentRECode,
						CONVERT(FLOAT, DATEDIFF(dd, CAST('18991230' AS DateTime), @WeekStartDate)),
						@pUserCode,
						@CurrentOADateTime
						);

			-- Email the Notification (if options set)
			IF (@NotificationsEmailActive <> 0)
			BEGIN
				IF EXISTS(SELECT * FROM ResNotificationDefs WHERE RE_Code = @currentRECode AND ND_Key = @pType)
				BEGIN
					-- Email the Notification
					IF (LEN(@ResEmail) > 0)
					BEGIN
						IF (LEN(@EmailLoginUrl) > 0)
						BEGIN
							-- Remove tags
							SET @EmailNotificationText = REPLACE(@EmailNotificationText , @C_DataToken_EmailLoginStart, '');
							SET @EmailNotificationText = REPLACE(@EmailNotificationText , @C_DataToken_EmailLoginEnd, '');

							-- Insert Url
							SELECT @EmailNotificationText = REPLACE(@EmailNotificationText, @C_DataToken_EmailLoginUrl, @EmailLoginUrl);
						END
						ELSE
						BEGIN
							-- Remove section
							SET @intStartIndex = CHARINDEX(@C_DataToken_EmailLoginStart, @EmailNotificationText);
							SET @intEndIndex = CHARINDEX(@C_DataToken_EmailLoginEnd, @EmailNotificationText) + LEN(@C_DataToken_EmailLoginEnd) - 1;
							SET @intLength = @intEndIndex - @intStartIndex + 1;
							SET @EmailNotificationText = STUFF(@EmailNotificationText, @intStartIndex, @intLength, '');
						END

						-- Apply Subject Prefix
						SET @NotificationSubject = @NotificationsEmailSubjectPrefix + @NotificationSubject;
						SET @EmailNotificationText = REPLACE(@EmailNotificationText, @C_LinebreakToken, @C_CarriageReturn);

						EXEC msdb.dbo.sp_send_dbmail @recipients = @ResEmail, 
											@profile_name = 'KIP Notifications', 
											@body_format = 'TEXT', 
											@body = @EmailNotificationText, 
											@subject = @NotificationSubject;
					END
				END
			END
			FETCH NEXT FROM curManagers INTO @currentRECode, @ResEmail, @resCulture;
		END

		CLOSE curManagers;
		DEALLOCATE curManagers;
	END
END 


GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_TimesheetReminder_Unapproved]
	TO [V6N14816rwZf]
GO
