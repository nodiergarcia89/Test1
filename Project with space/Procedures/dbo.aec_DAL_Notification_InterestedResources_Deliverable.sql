SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_DAL_Notification_InterestedResources_Deliverable
Purpose
    Sends a notification to all interested resources that a deliverable has been rescheduled
Behaviour
	
Parameters
	@pDeliverableKey	- The key of the deliverable to notify interested resources about
	@pNotificationID	- The notification ID of the notification to send
Prerequisites
	
Return
    Nothing

*******************************************************************************************************
                                             Version History
*******************************************************************************************************
PR1 21/05/2014 - Created 

PR2 28/07/2014 - Amended to work for Deliverable Complete and Deliverable Rescheduled

MTA5 - 11/11/2015
																		------
	Fix, [TBP-234-29409] Incomplete time sheets for previous week. \ KCOM PH  | -----> If Resource Notification culture is empty then
	Fix, [TAW-590-70427] Timesheet Notification Tests						  | -----> set it from SystemParams 'NOTIFICATIONS-DEFAULT-CULTURE'

*******************************************************************************************************/
CREATE PROCEDURE [aec_DAL_Notification_InterestedResources_Deliverable]
	-- Add the parameters for the stored procedure here	
	@pDeliverableKey AS INTEGER,	
	@pNotificationID AS INTEGER
AS
BEGIN	
	-- constants
	DECLARE @C_LinebreakToken NVARCHAR(5); SET @C_LinebreakToken = '<br/>';
	DECLARE @C_CarriageReturn NVARCHAR(1); SET @C_CarriageReturn = CHAR(13);
	DECLARE @C_NotificationsActive NVARCHAR(250); SET @C_NotificationsActive = N'NOTIFICATIONS-ACTIVE';	
	DECLARE @C_NotificationType_Planning INT; SET @C_NotificationType_Planning = 3;
	DECLARE @C_NotificationStatus_Unread INT; SET @C_NotificationStatus_Unread = 0;
	DECLARE @C_NotificationSource_ScheduledJob INT; SET @C_NotificationSource_ScheduledJob = 0;  --Not Scheduled, interactive

	DECLARE @C_NotificationsEmailActive NVARCHAR(30); SET @C_NotificationsEmailActive = N'NOTIFICATIONS-EMAIL-ACTIVE';
	DECLARE @C_NotificationsEmailSubjectPrefix NVARCHAR(50); SET @C_NotificationsEmailSubjectPrefix = N'NOTIFICATIONS-EMAIL-SUBJECT-PREFIX';

	-- Tokens to replace in the text
	DECLARE @C_DataToken_EmailLoginStart NVARCHAR(20); SET @C_DataToken_EmailLoginStart = '<email login>';
	DECLARE @C_DataToken_EmailLoginEnd NVARCHAR(20); SET @C_DataToken_EmailLoginEnd = '</email login>';
	DECLARE @C_DataToken_EmailLoginUrl NVARCHAR(20); SET @C_DataToken_EmailLoginUrl = N'<email login url>';
	DECLARE @C_EmailLoginUrl NVARCHAR(250); SET @C_EmailLoginUrl = N'NOTIFICATIONS-EMAIL-LOGIN-URL';
	DECLARE @C_DataToken_ProjectName NVARCHAR(250); SET @C_DataToken_ProjectName = '<project name>';
	DECLARE @C_DataToken_DeliverableName NVARCHAR(250); SET @C_DataToken_DeliverableName = '<milestone name>';
	DECLARE @C_ScreenLabel_Milestone NVARCHAR(50); SET @C_ScreenLabel_Milestone = '#LABEL-MILESTONE#'
	DECLARE @C_ScreenLabel_InterestedProject NVARCHAR(50); SET @C_ScreenLabel_InterestedProject = '#LABEL-INTERESTEDPROJECT#'
	
	-- Variables holding the value of the tokens
	DECLARE @ProjectDesc NVARCHAR(70);
	DECLARE @deliverableKey INTEGER;
	DECLARE @deliverableName NVARCHAR(70);		
	DECLARE @LABELMILESTONE NVARCHAR(50);
	DECLARE @LABELINTERESTEDPROJECT NVARCHAR(50);
		
	-- variables
	DECLARE @NotificationsActive INTEGER;
	DECLARE @dtNow AS DateTime; SET @dtNow = GetDate();
	DECLARE @CurrentOADate FLOAT; SET @CurrentOADate = DATEDIFF(dd, CAST('18991230' AS DateTime), @dtNow);
	DECLARE @CurrentOADateTime FLOAT;
	DECLARE @dblCurrentOATime AS FLOAT;
	DECLARE @NotificationText NVARCHAR(MAX);
	DECLARE @EmailNotificationText NVARCHAR(MAX);
	DECLARE @NotificationSubject NVARCHAR(250);
	DECLARE @intStartIndex INTEGER;
	DECLARE @intEndIndex INTEGER;
	DECLARE @intLength INTEGER;
	DECLARE @intOption INTEGER;

	DECLARE @ResCode NVARCHAR(20);
	DECLARE @ResEmail NVARCHAR(70);
	DECLARE @resCulture NVARCHAR(20);

	DECLARE @NotificationsEmailActive INTEGER;
	DECLARE @NotificationsEmailSubjectPrefix NVARCHAR(250);
	DECLARE @EmailLoginUrl NVARCHAR(250);	

	-- check notifications are active
	SELECT @NotificationsActive = CAST(ISNULL(SP_Number, 0) AS INTEGER)
	FROM SystemParams
	WHERE SP_Code = @C_NotificationsActive;

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
			WHERE SP_Code = @C_EmailLoginUrl;
		END

		-- Get current Time
		SET @dblCurrentOATime = CONVERT(FLOAT, @dtNow);
		SET @dblCurrentOATime = @dblCurrentOATime - FLOOR(@dblCurrentOATime);

		-- Set current Date & Time
		SET @CurrentOADateTime = @CurrentOADate + @dblCurrentOATime;

		DECLARE curResources CURSOR LOCAL FAST_FORWARD FOR
			SELECT DISTINCT r.RE_Code, r.RE_Email, ISNULL(r.CLC_Code,'') AS CLC_Code, p.PR_Desc, d.DV_Key, d.DV_Name
			FROM Deliverable d
			INNER JOIN Projects p ON (p.PR_Code = d.PR_Code)
			INNER JOIN InterestedPrjRes ipr ON (ipr.PR_Code = p.PR_Code)
			INNER JOIN Res r ON (r.RE_Code = ipr.RE_Code)
			INNER JOIN Users u on (r.RE_Code = u.RE_Code)
			INNER JOIN LoginGroupNotificationDefs lgn ON (u.LG_Code = lgn.LG_Code)
			WHERE d.DV_Key = @pDeliverableKey
			AND (lgn.ND_Key = @pNotificationID)
			AND (r.Active = -1)
			AND (u.Active = -1);
			
		OPEN curResources;
		
		FETCH NEXT FROM curResources INTO @ResCode, @ResEmail, @resCulture, @ProjectDesc, @deliverableKey, @deliverableName;

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

			IF (LEN(@resCulture) = 0)
			BEGIN
				-- default culture
				SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
				FROM NotificationDefinition 
				WHERE ND_Key = @pNotificationID;
				
				SELECT @LABELMILESTONE = SP_Value FROM SystemParams WHERE SP_Code = 'SL-MILESTONE'
				SELECT @LABELINTERESTEDPROJECT = SP_Value FROM SystemParams WHERE SP_Code = 'SL-INTERESTPROJECT'
			END
			ELSE
			BEGIN
				-- culture specific
				IF EXISTS(SELECT * FROM NotificationDefinitionCulture WHERE ND_Key = @pNotificationID AND CLC_Code = @resCulture)
				BEGIN
					SELECT @NotificationText = NDC_Text, @NotificationSubject = NDC_Subject 
						FROM NotificationDefinitionCulture 
						WHERE ND_Key = @pNotificationID AND CLC_Code = @resCulture;
					
					SELECT @LABELMILESTONE = SP_Value FROM SystemParams WHERE SP_Code = 'SL-MILESTONE.' + UPPER(@resCulture)
					SELECT @LABELINTERESTEDPROJECT = SP_Value FROM SystemParams WHERE SP_Code = 'SL-INTERESTPROJECT.' + UPPER(@resCulture)

					IF(LEN(@LABELMILESTONE) = 0)
						SELECT @LABELMILESTONE = SP_Value FROM SystemParams WHERE SP_Code = 'SL-MILESTONE'

					IF(LEN(@LABELINTERESTEDPROJECT) = 0)
						SELECT @LABELINTERESTEDPROJECT = SP_Value FROM SystemParams WHERE SP_Code = 'SL-INTERESTPROJECT'
				END
				ELSE
				BEGIN
					SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
						FROM NotificationDefinition 
						WHERE ND_Key = @pNotificationID;
						
					SELECT @LABELMILESTONE = SP_Value FROM SystemParams WHERE SP_Code = 'SL-MILESTONE'
					SELECT @LABELINTERESTEDPROJECT = SP_Value FROM SystemParams WHERE SP_Code = 'SL-INTERESTPROJECT'
				END
			END
			
			-- Data tokens												
			SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_ProjectName, @ProjectDesc);				
			SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_DeliverableName, @deliverableName);
															
			-- Screen Labels								
			SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_ScreenLabel_Milestone, @LABELMILESTONE)
			SELECT @NotificationText = REPLACE(@NotificationText, @C_ScreenLabel_Milestone, @LABELMILESTONE)
			
			SELECT @NotificationText = REPLACE(@NotificationText, @C_ScreenLabel_InterestedProject, @LABELINTERESTEDPROJECT)
						
			-- Copy now for Email use
			SET @EmailNotificationText = @NotificationText;

			-- Remove Email-specific sections, if email Tags exist
			SET @intStartIndex = CHARINDEX(@C_DataToken_EmailLoginStart, @NotificationText);
			IF (@intStartIndex > 0)
			BEGIN
				SET @intEndIndex = CHARINDEX(@C_DataToken_EmailLoginEnd, @NotificationText) + LEN(@C_DataToken_EmailLoginEnd) - 1;
				SET @intLength = @intEndIndex - @intStartIndex + 1;
				SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');
			END

			-- Create Notification in the application
			INSERT INTO Notifications (RE_Code, NTF_Date, NTF_Source, ND_Key, NTF_Type, NTF_Status, NTF_Text, NTF_Subject, NTF_ContextKey, NTF_ContextCode, NTF_ContextDate, US_CodeLastEdit, NTF_LastEditDate)
				VALUES (@ResCode, 
						@CurrentOADateTime,  
						@C_NotificationSource_ScheduledJob,			-- Scheduled
						@pNotificationID,							-- Event key (see NotificationDefinition table)
						@C_NotificationType_Planning,				-- Planning
						@C_NotificationStatus_Unread,				-- Unread
						@NotificationText,
						@NotificationSubject,
						@deliverableKey,
						'',
						CONVERT(FLOAT, DATEDIFF(dd, CAST('18991230' AS DateTime), @dtNow)),
						'SYSTEM',
						@CurrentOADateTime
						);
			-- Email the Notification (if options set)
			IF (@NotificationsEmailActive <> 0)
			BEGIN
				IF EXISTS(SELECT * FROM ResNotificationDefs WHERE RE_Code = @ResCode AND ND_Key = @pNotificationID)
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
							IF (@intEndIndex > 0)
							BEGIN
								SET @intEndIndex = CHARINDEX(@C_DataToken_EmailLoginEnd, @EmailNotificationText) + LEN(@C_DataToken_EmailLoginEnd) - 1;
								SET @intLength = @intEndIndex - @intStartIndex + 1;
								SET @EmailNotificationText = STUFF(@EmailNotificationText, @intStartIndex, @intLength, '');
							END
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

			FETCH NEXT FROM curResources INTO @ResCode, @ResEmail, @resCulture, @ProjectDesc, @deliverableKey, @deliverableName;
		END

		CLOSE curResources;
		DEALLOCATE curResources;

	END
END


GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Notification_InterestedResources_Deliverable]
	TO [V6N14816rwZf]
GO
