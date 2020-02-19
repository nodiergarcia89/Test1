SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_BL_Core_TimesheetReminderAll
Purpose
    Sends a blanket notification to all users to remind them to complete their timesheets
Behaviour
	
Parameters
	@pUserCode		- The Code of the user executing the procedure
	
Prerequisites
	
Return
    Nothing

*******************************************************************************************************
                                             Version History
*******************************************************************************************************
RE1 06/08/2012 - Created 

PR2 18/02/2014 - Amended

NF3 - 18/08/2014
	Mod, Check the "Email Notifications Active" System Config setting

MTA5 - 11/11/2015
																		------
	Fix, [TBP-234-29409] Incomplete time sheets for previous week. \ KCOM PH  | -----> If Resource Notification culture is empty then
	Fix, [TAW-590-70427] Timesheet Notification Tests						  | -----> set it from SystemParams 'NOTIFICATIONS-DEFAULT-CULTURE'
																		------
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_TimesheetReminderAll](
	@pUserCode AS NVARCHAR(20)
)
AS
BEGIN
	-- constants
	DECLARE @C_LinebreakToken NVARCHAR(5); SET @C_LinebreakToken = '<br/>';
	DECLARE @C_CarriageReturn NVARCHAR(1); SET @C_CarriageReturn = CHAR(13);
	DECLARE @C_NotificationsActive NVARCHAR(250); SET @C_NotificationsActive = N'NOTIFICATIONS-ACTIVE';
	DECLARE @C_NotificationEvent_TimesheetReminder INT; SET @C_NotificationEvent_TimesheetReminder = 2;
	DECLARE @C_NotificationType_Timesheet INT; SET @C_NotificationType_Timesheet = 5;
	DECLARE @C_NotificationStatus_Unread INT; SET @C_NotificationStatus_Unread = 0;
	DECLARE @C_DataToken_WeekStart NVARCHAR(20); SET @C_DataToken_WeekStart = N'<week start date>';
	DECLARE @C_NotificationSource_ScheduledJob INT; SET @C_NotificationSource_ScheduledJob = 1;

	DECLARE @C_NotificationsEmailActive NVARCHAR(30); SET @C_NotificationsEmailActive = N'NOTIFICATIONS-EMAIL-ACTIVE';
	DECLARE @C_NotificationsEmailSubjectPrefix NVARCHAR(50); SET @C_NotificationsEmailSubjectPrefix = N'NOTIFICATIONS-EMAIL-SUBJECT-PREFIX';

	DECLARE @C_DataToken_EmailLoginStart NVARCHAR(20); SET @C_DataToken_EmailLoginStart = '<email login>';
	DECLARE @C_DataToken_EmailLoginEnd NVARCHAR(20); SET @C_DataToken_EmailLoginEnd = '</email login>';
	DECLARE @C_DataToken_EmailLoginUrl NVARCHAR(20); SET @C_DataToken_EmailLoginUrl = N'<email login url>';
	DECLARE @C_EmailLoginUrl NVARCHAR(250); SET @C_EmailLoginUrl = N'NOTIFICATIONS-EMAIL-LOGIN-URL';

	-- variables
	DECLARE @NotificationsActive INTEGER;
	DECLARE @curRECode NVARCHAR(20);
	DECLARE @dtNow AS DateTime; SET @dtNow = GetDate();
	DECLARE @CurrentOADate FLOAT; SET @CurrentOADate = DATEDIFF(dd, CAST('18991230' AS DateTime), @dtNow);
	DECLARE @CurrentOADateTime FLOAT;
	DECLARE @dblCurrentOATime AS FLOAT
	DECLARE @NotificationText NVARCHAR(MAX);
	DECLARE @EmailNotificationText NVARCHAR(MAX);
	DECLARE @NotificationSubject NVARCHAR(250);
	DECLARE @WeekStartDate DATETIME; 
	DECLARE @WeekStartDateCultureSpecific NVARCHAR(30); 
	DECLARE @bow FLOAT;
	DECLARE @resetDateFirst INT; SET @resetDateFirst = @@DATEFIRST;
	DECLARE @OurDateFirst INT;
	DECLARE @ResEmail NVARCHAR(70);
	DECLARE @resCulture NVARCHAR(20)

	DECLARE @NotificationsEmailActive INTEGER;
	DECLARE @NotificationsEmailSubjectPrefix NVARCHAR(250);
	DECLARE @EmailLoginUrl NVARCHAR(250);

	DECLARE @intStartIndex INTEGER;
	DECLARE @intEndIndex INTEGER;
	DECLARE @intLength INTEGER;

	-- check notifications are active
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

		-- Get current Time
		SET @dblCurrentOATime = CONVERT(FLOAT, @dtNow)
		SET @dblCurrentOATime = @dblCurrentOATime - FLOOR(@dblCurrentOATime)

		-- Set current Date & Time
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
		SELECT @WeekStartDate = CONVERT(NVARCHAR(30),(GetDate() -(DATEPART(dw, GetDate())-1)), 107);

		-- reset the @@DATEFIRST value...this should get done after this sp has finished, but do it here just to be sure
		SET DATEFIRST @resetDateFirst;

		-- run through active resource/login records, that have a login group record with this notification
		-- event selected
		DECLARE curUsers CURSOR LOCAL FAST_FORWARD FOR
			SELECT DISTINCT u.RE_Code, r.RE_Email, ISNULL(r.CLC_Code,'') 
			FROM Users u
			INNER JOIN Res r ON (u.RE_Code = r.RE_Code)
			INNER JOIN LoginGroupNotificationDefs lgn ON (u.LG_Code = lgn.LG_Code)
			WHERE (u.RE_Code IS NOT NULL)
			AND (u.Active = -1)
			AND (r.Active = -1)
			AND (lgn.ND_Key = @C_NotificationEvent_TimesheetReminder)

		OPEN curUsers;

		FETCH NEXT FROM curUsers INTO @curRECode, @ResEmail, @resCulture;

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			-- reset any work variables
			SET @NotificationText = '';
			
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
					SELECT @WeekStartDateCultureSpecific = SUBSTRING(CONVERT(NVARCHAR(30),@WeekStartDate, 121),0,11)
				END
			
			-- get the notification text, based on the recipient resources culture
			IF (LEN(@resCulture) = 0)
			BEGIN
				-- default culture
				SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
				FROM NotificationDefinition 
				WHERE ND_Key = @C_NotificationEvent_TimesheetReminder;
			END
			ELSE
			BEGIN
				-- culture specific
				IF EXISTS(SELECT * FROM NotificationDefinitionCulture WHERE ND_Key = @C_NotificationEvent_TimesheetReminder AND CLC_Code = @resCulture)
				BEGIN
					SELECT @NotificationText = NDC_Text, @NotificationSubject = NDC_Subject 
						FROM NotificationDefinitionCulture 
						WHERE ND_Key = @C_NotificationEvent_TimesheetReminder AND CLC_Code = @resCulture;
				END
				ELSE
				BEGIN
					SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
						FROM NotificationDefinition 
						WHERE ND_Key = @C_NotificationEvent_TimesheetReminder;
				END
			END

			-- replace data tokens
			SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_DataToken_WeekStart, @WeekStartDateCultureSpecific);
			SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_WeekStart, @WeekStartDateCultureSpecific);

			-- Copy now for Email use
			SET @EmailNotificationText = @NotificationText

			-- Remove Email-specific sections
			SET @intStartIndex = CHARINDEX(@C_DataToken_EmailLoginStart, @NotificationText);
			SET @intEndIndex = CHARINDEX(@C_DataToken_EmailLoginEnd, @NotificationText) + LEN(@C_DataToken_EmailLoginEnd) - 1;
			SET @intLength = @intEndIndex - @intStartIndex + 1;
			SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');

			-- Create Notification in the application
			INSERT INTO Notifications (RE_Code, NTF_Date, NTF_Source, ND_Key, NTF_Type, NTF_Status, NTF_Text, NTF_Subject, NTF_ContextDate, US_CodeLastEdit, NTF_LastEditDate)
				VALUES (@curRECode, 
						@CurrentOADateTime,  
						@C_NotificationSource_ScheduledJob,			-- Scheduled
						@C_NotificationEvent_TimesheetReminder,		-- Event key (see NotificationDefinition table)
						@C_NotificationType_Timesheet,				-- Timesheet
						@C_NotificationStatus_Unread,				-- Unread
						@NotificationText,
						@NotificationSubject,
						CONVERT(FLOAT, DATEDIFF(dd, CAST('18991230' AS DateTime), @WeekStartDate)),
						@pUserCode,
						@CurrentOADateTime
						);

			-- Email the Notification (if options set)
			IF (@NotificationsEmailActive <> 0)
			BEGIN
				IF EXISTS(SELECT * FROM ResNotificationDefs WHERE RE_Code = @curRECode AND ND_Key = @C_NotificationEvent_TimesheetReminder)
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
			
			FETCH NEXT FROM curUsers INTO @curRECode, @ResEmail, @resCulture;
		END

		CLOSE curUsers;
		DEALLOCATE curUsers;

	END

END


GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_TimesheetReminderAll]
	TO [V6N14816rwZf]
GO
