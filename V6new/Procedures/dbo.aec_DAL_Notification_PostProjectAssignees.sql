SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--MP8e

--GP9s
/******************************************************************************************************
	aec_BL_Notification_PostProjectAssignees
Purpose
    Sends a notification to all assigned resources on a project when a new post is created
    Only sends to those whose Notify flag is set for NotificationDefinition 11
Behaviour
	
Parameters
	@pPostKey		- The Key of the Post
	
Prerequisites
	
Return
    Nothing

*******************************************************************************************************
                                             Version History
*******************************************************************************************************
SV3 14/04/2014 - Created 
*******************************************************************************************************/
CREATE PROCEDURE [aec_DAL_Notification_PostProjectAssignees](
	@pPostKey AS INT
)
AS
BEGIN
	-- constants
	DECLARE @C_LinebreakToken NVARCHAR(5); SET @C_LinebreakToken = '<br/>';
	DECLARE @C_CarriageReturn NVARCHAR(1); SET @C_CarriageReturn = CHAR(13);
	DECLARE @C_NotificationsActive NVARCHAR(250); SET @C_NotificationsActive = N'NOTIFICATIONS-ACTIVE';
	DECLARE @C_NotificationEvent_NewPost INT; SET @C_NotificationEvent_NewPost = 11; --Notify me when a New Post is made Against a Project I am assigned to
	DECLARE @C_NotificationType_Post INT; SET @C_NotificationType_Post = 7;  --Notification type from NotificationTypeValues (NotificationBLEntities\Notification.vb)
	DECLARE @C_NotificationStatus_Unread INT; SET @C_NotificationStatus_Unread = 0;
	DECLARE @C_NotificationSource_ScheduledJob INT; SET @C_NotificationSource_ScheduledJob = 0;  --Not Scheduled, interactive

	DECLARE @C_NotificationsEmailActive NVARCHAR(30); SET @C_NotificationsEmailActive = N'NOTIFICATIONS-EMAIL-ACTIVE';
	DECLARE @C_NotificationsEmailSubjectPrefix NVARCHAR(50); SET @C_NotificationsEmailSubjectPrefix = N'NOTIFICATIONS-EMAIL-SUBJECT-PREFIX';

	DECLARE @C_DataToken_EmailLoginStart NVARCHAR(20); SET @C_DataToken_EmailLoginStart = '<email login>';
	DECLARE @C_DataToken_EmailLoginEnd NVARCHAR(20); SET @C_DataToken_EmailLoginEnd = '</email login>';
	DECLARE @C_DataToken_EmailLoginUrl NVARCHAR(20); SET @C_DataToken_EmailLoginUrl = N'<email login url>';
	DECLARE @C_EmailLoginUrl NVARCHAR(250); SET @C_EmailLoginUrl = N'NOTIFICATIONS-EMAIL-LOGIN-URL';
	DECLARE @C_DataToken_ProjectName NVARCHAR(250); SET @C_DataToken_ProjectName = '<project name>';
	DECLARE @C_DataToken_PostTextFull NVARCHAR(250); SET @C_DataToken_PostTextFull = '<post text full>';
	DECLARE @C_DataToken_PostTextShort NVARCHAR(250); SET @C_DataToken_PostTextShort = '<post text short>';
	DECLARE @C_DataToken_ResourceName NVARCHAR(250); SET @C_DataToken_ResourceName = '<resource name>';

	-- variables
	DECLARE @NotificationsActive INTEGER;
	DECLARE @dtNow AS DateTime; SET @dtNow = GetDate();
	DECLARE @CurrentOADate FLOAT; SET @CurrentOADate = DATEDIFF(dd, CAST('18991230' AS DATETIME), @dtNow);
	DECLARE @CurrentOADateTime FLOAT;
	DECLARE @dblCurrentOATime AS FLOAT;
	DECLARE @NotificationText NVARCHAR(MAX);
	DECLARE @EmailNotificationText NVARCHAR(MAX);
	DECLARE @NotificationSubject NVARCHAR(250);

	DECLARE @ResCode NVARCHAR(20);
	DECLARE @ResEmail NVARCHAR(70);
	DECLARE @resCulture NVARCHAR(20);	
	DECLARE @ProjectDesc NVARCHAR(70);
	DECLARE @postKey INTEGER;
	DECLARE @PostText NVARCHAR(MAX);
	DECLARE @postRes NVARCHAR(20);
	DECLARE @PostCreatorDesc NVARCHAR(255);
	
	DECLARE @NotificationsEmailActive INTEGER;
	DECLARE @NotificationsEmailSubjectPrefix NVARCHAR(250);
	DECLARE @EmailLoginUrl NVARCHAR(250);

	DECLARE @intStartIndex INTEGER;
	DECLARE @intEndIndex INTEGER;
	DECLARE @intLength INTEGER;
	DECLARE @intOption INTEGER;
	DECLARE @ScreenLabel NVARCHAR(20);
	DECLARE @ScreenLabelDB NVARCHAR(20);
	DECLARE @ScreenLabelOut NVARCHAR(250);

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

		--Set Post Creator Description
		SELECT @PostCreatorDesc = RE_Desc FROM Posts, Res WHERE Posts.RE_Code = Res.RE_Code AND PST_Key = @pPostKey

		-- Get the resources who have an ASSIGNMENT on a TASK on the PROJECT that was POSTed to
		--	Project for Project Name					Task for link to Assignments
		--	Assignments for relevant resources			Posts for posted record
		--  Res for resource email and link to user		User for Login Group
		--	Login Group for notifications
		DECLARE curResources CURSOR LOCAL FAST_FORWARD FOR
			SELECT DISTINCT r.RE_Code, r.RE_Email,ISNULL(r.CLC_Code,'') AS CLC_Code, p.PR_Desc, po.PST_Key, po.PST_Text, po.RE_Code
			FROM Assignment a
			INNER JOIN Task t ON (a.TA_Key = t.TA_Key)
			INNER JOIN Projects p ON (t.PR_Code = p.PR_Code)
			INNER JOIN Posts po ON (p.PR_Code = po.PR_Code)
			INNER JOIN Res r ON (a.RE_Code = r.RE_Code)
			INNER JOIN Users u ON (r.RE_Code = u.RE_Code)
		 	INNER JOIN LoginGroupNotificationDefs lgn ON (u.LG_Code = lgn.LG_Code)
		 	WHERE po.PST_Key = @pPostKey
		 	AND (lgn.ND_Key = @C_NotificationEvent_NewPost)
		 	AND (r.RE_Code IS NOT NULL)
		 	AND (r.Active = -1)
		 	AND (u.Active = -1);
			
		OPEN curResources;
		
		FETCH NEXT FROM curResources INTO @ResCode, @ResEmail, @resCulture, @ProjectDesc, @postKey, @PostText, @postRes;
		
		WHILE (@@FETCH_STATUS = 0)
		BEGIN								
			-- reset any work variables
			SET @NotificationText = '';
			
			IF (LEN(@resCulture) = 0)
			BEGIN
				-- default culture
				SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
				FROM NotificationDefinition 
				WHERE ND_Key = @C_NotificationEvent_NewPost;
			END
			ELSE
			BEGIN
				-- culture specific
				IF EXISTS(SELECT * FROM NotificationDefinitionCulture WHERE ND_Key = @C_NotificationEvent_NewPost AND CLC_Code = @resCulture)
				BEGIN
					SELECT @NotificationText = NDC_Text, @NotificationSubject = NDC_Subject 
						FROM NotificationDefinitionCulture 
						WHERE ND_Key = @C_NotificationEvent_NewPost AND CLC_Code = @resCulture;
				END
				ELSE
				BEGIN
					SELECT @NotificationText = ND_Text, @NotificationSubject = ND_Subject 
						FROM NotificationDefinition 
						WHERE ND_Key = @C_NotificationEvent_NewPost;
				END
			END
			
			-- replace data tokens
			SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_DataToken_ProjectName, @ProjectDesc);
			SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_ProjectName, @ProjectDesc);
			SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_DataToken_PostTextFull, @PostText);
			SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_PostTextFull, @PostText);
			SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_DataToken_ResourceName, @PostCreatorDesc);
			IF LEN(@PostText) < 21
			BEGIN
				SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_DataToken_PostTextShort, @PostText);
				SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_PostTextShort, @PostText);
			END
			ELSE
			BEGIN
				SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_DataToken_PostTextShort, LEFT(@PostText,17) + '...');
				SELECT @NotificationText = REPLACE(@NotificationText, @C_DataToken_PostTextShort, LEFT(@PostText,17) + '...');
			END
			-----------------------
			--Now the Screen Labels
			-----------------------
			SET @intOption = 1;
			SET @intStartIndex = CHARINDEX('#',@NotificationText) + 1;
			SET @intEndIndex = CHARINDEX('#',@NotificationText, @intStartIndex + 1) - 1;
			IF (@intStartIndex = 0)
			BEGIN
				SET @intStartIndex = CHARINDEX('#',@NotificationSubject) + 1;
				SET @intEndIndex = CHARINDEX('#',@NotificationSubject, @intStartIndex + 1) - 1;
				SET @intOption = 2;
			END
			 
			--Process each label
			WHILE (@intStartIndex > 1)
			BEGIN
				SET @intLength = @intEndIndex - @intStartIndex + 1;
				IF @intOption = 1
				BEGIN
					SET @ScreenLabel = SUBSTRING(@NotificationText, @intStartIndex, @intLength);
				END
				ELSE
				BEGIN
					SET @ScreenLabel = SUBSTRING(@NotificationSubject, @intStartIndex, @intLength);
				END
				-- Generic replacement of "LABEL-" with "SL-", the equivalent database SP_Code
				-- This will only work for future screen labels if the postfix always matches in both systems
				-- For Project, the only one currently, this is fine
				SET @ScreenLabelDB = REPLACE(@ScreenLabel, 'LABEL-', 'SL-');
				
				--Get the screen label in Culture
				SET @ScreenLabelOut = '';
				SELECT @ScreenLabelOut = SP_Value
					FROM SystemParams
					WHERE SP_Code = @ScreenLabelDB + '.' + UPPER(@resCulture);
				-- If not in culture, get default
				IF (LEN(@ScreenLabelOut)) = 0
				BEGIN
				SELECT @ScreenLabelOut = SP_Value
					FROM SystemParams
					WHERE SP_Code = @ScreenLabelDB;
				END
				
				-- If not found modify placeholder
				IF (@ScreenLabelOut = '')
				BEGIN
					SET @ScreenLabelOut = '!' + @ScreenLabel + '!';
				END
				
				SET @NotificationSubject = REPLACE(@NotificationSubject, '#' + @ScreenLabel + '#', @ScreenLabelOut);
				SET @NotificationText = REPLACE(@NotificationText, '#' + @ScreenLabel + '#', @ScreenLabelOut);
				
				--Next one
				IF (@intOption = 1)
				BEGIN
					SET @intStartIndex = CHARINDEX('#',@NotificationText) + 1;
					SET @intEndIndex = CHARINDEX('#',@NotificationText, @intStartIndex + 1) - 1;
				END
				ELSE
				BEGIN
					SET @intStartIndex = 1;
				END
				
				IF (@intStartIndex = 1)
				BEGIN
					SET @intStartIndex = CHARINDEX('#',@NotificationSubject) + 1;
					SET @intEndIndex = CHARINDEX('#',@NotificationSubject, @intStartIndex + 1) - 1;
					SET @intOption = 2;
				END
			END			
			
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
						@C_NotificationSource_ScheduledJob,		-- Scheduled
						@C_NotificationEvent_NewPost,			-- Event key (see NotificationDefinition table)
						@C_NotificationType_Post,				-- Post
						@C_NotificationStatus_Unread,			-- Unread
						@NotificationText,
						@NotificationSubject,
						@postKey,
						@postRes,
						CONVERT(FLOAT, DATEDIFF(dd, CAST('18991230' AS DATETIME), @dtNow)),
						'SYSTEM',
						@CurrentOADateTime
						);

			-- Email the Notification (if options set)
			IF (@NotificationsEmailActive <> 0)
			BEGIN
				IF EXISTS(SELECT * FROM ResNotificationDefs WHERE RE_Code = @ResCode AND ND_Key = @C_NotificationEvent_NewPost)
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
						
			FETCH NEXT FROM curResources INTO @ResCode, @ResEmail, @resCulture, @ProjectDesc, @postKey, @PostText, @postRes;
		END

		CLOSE curResources;
		DEALLOCATE curResources;

	END

END 

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Notification_PostProjectAssignees]
	TO [V6N14816rwZf]
GO
