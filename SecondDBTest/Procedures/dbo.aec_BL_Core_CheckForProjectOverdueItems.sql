SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
--TL2e

--MTA3s

CREATE PROCEDURE aec_BL_Core_CheckForProjectOverdueItems(
	@pUserCode AS NVARCHAR(20)
)
AS
BEGIN
	-- constants
	DECLARE @C_LinebreakToken NVARCHAR(5); SET @C_LinebreakToken = '<br/>';
	DECLARE @C_CarriageReturn NVARCHAR(1); SET @C_CarriageReturn = CHAR(13);
	DECLARE @C_NotificationsActive NVARCHAR(250); SET @C_NotificationsActive = N'NOTIFICATIONS-ACTIVE';
	DECLARE @C_NotificationEvent_ProjectOverdueItems INT; SET @C_NotificationEvent_ProjectOverdueItems = 7;
	DECLARE @C_NotificationType_All INT; SET @C_NotificationType_All = 0;
	DECLARE @C_NotificationStatus_Unread INT; SET @C_NotificationStatus_Unread = 0;
	DECLARE @C_NotificationSource_ScheduledJob INT; SET @C_NotificationSource_ScheduledJob = 1;

	DECLARE @C_NotificationsEmailActive NVARCHAR(30); SET @C_NotificationsEmailActive = N'NOTIFICATIONS-EMAIL-ACTIVE';
	DECLARE @C_NotificationsEmailSubjectPrefix NVARCHAR(50); SET @C_NotificationsEmailSubjectPrefix = N'NOTIFICATIONS-EMAIL-SUBJECT-PREFIX';

	DECLARE @C_TOKEN_ProjectSL NVARCHAR(20); SET @C_TOKEN_ProjectSL = '#LABEL-PROJECT#';
	DECLARE @C_TOKEN_RiskItemsSL NVARCHAR(20); SET @C_TOKEN_RiskItemsSL = '#LABEL-RISKITEMS#';
	DECLARE @C_TOKEN_IssueItemsSL NVARCHAR(20); SET @C_TOKEN_IssueItemsSL = '#LABEL-ISSUEITEMS#';
	DECLARE @C_TOKEN_ActionsSL NVARCHAR(20); SET @C_TOKEN_ActionsSL = '#LABEL-ACTIONS#';
	DECLARE @C_TOKEN_DeliverablesSL NVARCHAR(20); SET @C_TOKEN_DeliverablesSL = '#LABEL-MILESTONES#';

	DECLARE @C_TOKEN_ProjectName NVARCHAR(20); SET @C_TOKEN_ProjectName = '<project name>';
	DECLARE @C_TOKEN_ProjectCode NVARCHAR(20); SET @C_TOKEN_ProjectCode = '<project code>';

	DECLARE @C_TOKEN_RiskItemStart NVARCHAR(20); SET @C_TOKEN_RiskItemStart = '<riskitems>';
	DECLARE @C_TOKEN_RiskItemEnd NVARCHAR(20); SET @C_TOKEN_RiskItemEnd = '</riskitems>';
	DECLARE @C_TOKEN_RiskItemCount NVARCHAR(20); SET @C_TOKEN_RiskItemCount = '<riskitem count>';

	DECLARE @C_TOKEN_IssueItemStart NVARCHAR(20); SET @C_TOKEN_IssueItemStart = '<issueitems>';
	DECLARE @C_TOKEN_IssueItemEnd NVARCHAR(20); SET @C_TOKEN_IssueItemEnd = '</issueitems>';
	DECLARE @C_TOKEN_IssueItemCount NVARCHAR(20); SET @C_TOKEN_IssueItemCount = '<issueitem count>';

	DECLARE @C_TOKEN_ActionStart NVARCHAR(20); SET @C_TOKEN_ActionStart = '<actions>';
	DECLARE @C_TOKEN_ActionEnd NVARCHAR(20); SET @C_TOKEN_ActionEnd = '</actions>';
	DECLARE @C_TOKEN_ActionCount NVARCHAR(20); SET @C_TOKEN_ActionCount = '<action count>';

	DECLARE @C_TOKEN_DeliverableStart NVARCHAR(20); SET @C_TOKEN_DeliverableStart = '<deliverables>';
	DECLARE @C_TOKEN_DeliverableEnd NVARCHAR(20); SET @C_TOKEN_DeliverableEnd = '</deliverables>';
	DECLARE @C_TOKEN_DeliverableCount NVARCHAR(20); SET @C_TOKEN_DeliverableCount = '<deliverable count>';

	DECLARE @C_TOKEN_TaskStart NVARCHAR(20); SET @C_TOKEN_TaskStart = '<tasks>';
	DECLARE @C_TOKEN_TaskEnd NVARCHAR(20); SET @C_TOKEN_TaskEnd = '</tasks>';
	DECLARE @C_TOKEN_TaskCount NVARCHAR(20); SET @C_TOKEN_TaskCount = '<task count>';

	DECLARE @C_TOKEN_EmailLoginStart NVARCHAR(20); SET @C_TOKEN_EmailLoginStart = '<email login>';
	DECLARE @C_TOKEN_EmailLoginEnd NVARCHAR(20); SET @C_TOKEN_EmailLoginEnd = '</email login>';
	DECLARE @C_TOKEN_EmailLoginUrl NVARCHAR(20); SET @C_TOKEN_EmailLoginUrl = N'<email login url>';
	DECLARE @C_EmailLoginUrl NVARCHAR(250); SET @C_EmailLoginUrl = N'NOTIFICATIONS-EMAIL-LOGIN-URL';

	-- variables
	DECLARE @dtNow AS DateTime; SET @dtNow = GetDate();
	DECLARE @CurrentOADate FLOAT; SET @CurrentOADate = DATEDIFF(dd, CAST('18991230' AS DateTime), @dtNow);
	DECLARE @CurrentOADateTime FLOAT;
	DECLARE @dblCurrentOATime AS FLOAT
	DECLARE @NotificationsActive INTEGER;
	DECLARE @SL_Project NVARCHAR(250);
	DECLARE @SL_RiskItems NVARCHAR(250);
	DECLARE @SL_IssueItems NVARCHAR(250);
	DECLARE @SL_Actions NVARCHAR(250);
	DECLARE @SL_Deliverables NVARCHAR(250);
	DECLARE @DefinitionText NVARCHAR(MAX);
	DECLARE @NotificationText NVARCHAR(MAX);
	DECLARE @EmailNotificationText NVARCHAR(MAX);
	DECLARE @DefinitionSubject NVARCHAR(250);
	DECLARE @NotificationSubject NVARCHAR(250);
	DECLARE @curRECode NVARCHAR(20);
	DECLARE @curPRCode NVARCHAR(20);
	DECLARE @curPRDesc NVARCHAR(70);
	DECLARE @ResEmail NVARCHAR(70);
	DECLARE @resCulture NVARCHAR(20);

	DECLARE @NotificationsEmailActive INTEGER;
	DECLARE @NotificationsEmailSubjectPrefix NVARCHAR(250);
	DECLARE @EmailLoginUrl NVARCHAR(250);

	DECLARE @intRiskItemCount INTEGER;
	DECLARE @intIssueItemCount INTEGER;
	DECLARE @intActionCount INTEGER;
	DECLARE @intDeliverableCount INTEGER;
	DECLARE @intTaskCount INTEGER;

	DECLARE @intIndex INTEGER;
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

		-- get screen label values that will be used in the notification text
		SELECT @SL_Project = SP_Value FROM SystemParams WHERE SP_Code = 'SL-PROJECT';
		SELECT @SL_RiskItems = SP_Value FROM SystemParams WHERE SP_Code = 'SL-RISKITEMS';
		SELECT @SL_IssueItems = SP_Value FROM SystemParams WHERE SP_Code = 'SL-ISSUEITEMS';
		SELECT @SL_Actions = SP_Value FROM SystemParams WHERE SP_Code = 'SL-ACTIONS';
		SELECT @SL_Deliverables = SP_Value FROM SystemParams WHERE SP_Code = 'SL-MILESTONES';
		
		-- declare cursor to go through all active level 1 projects that have a project manager
		DECLARE curProjects CURSOR LOCAL FAST_FORWARD FOR
			SELECT DISTINCT p.PR_Code, ISNULL(p.PR_Desc,'') , r.RE_Code, r.RE_Email, ISNULL(r.CLC_Code,'')
			FROM Projects p
			INNER JOIN Res r ON (p.RE_CodeProjectManager = r.RE_Code)
			INNER JOIN Users u ON (r.RE_Code = u.RE_Code)
			INNER JOIN LoginGroupNotificationDefs lgn ON (u.LG_Code = lgn.LG_Code)
			WHERE (p.Active = -1)
			AND (p.PLV_Level = 1)
			AND (p.PR_IsTemplate = 0)
			AND (r.Active = -1)

		OPEN curProjects;

		FETCH NEXT FROM curProjects INTO @curPRCode, @curPRDesc, @curRECode, @ResEmail, @resCulture;

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			SET @DefinitionText = '';
			SET @NotificationText =  '';

			SET @DefinitionSubject = '';
			SET @NotificationSubject =  '';

			--if the resource notification culture is empty then grab the value from the SystemParams table..
			IF (LEN(@resCulture) = 0)
				BEGIN
					SELECT @resCulture = SP_Value
					FROM SystemParams
					WHERE SP_Code = 'NOTIFICATIONS-DEFAULT-CULTURE'
				END
				
			-- get notification definition text based on culture of recipient resource
			IF (LEN(@resCulture) = 0)
			BEGIN
				-- default culture
				SELECT @DefinitionText = ND_Text, @DefinitionSubject = ND_Subject
				FROM NotificationDefinition 
				WHERE ND_Key = @C_NotificationEvent_ProjectOverdueItems;
			END
			ELSE
			BEGIN
				-- culture specific
				IF EXISTS(SELECT * FROM NotificationDefinitionCulture WHERE ND_Key = @C_NotificationEvent_ProjectOverdueItems AND CLC_Code = @resCulture)
				BEGIN
					SELECT @DefinitionText = NDC_Text, @DefinitionSubject = NDC_Subject
						FROM NotificationDefinitionCulture 
						WHERE ND_Key = @C_NotificationEvent_ProjectOverdueItems AND CLC_Code = @resCulture;
				END
				ELSE
				BEGIN
					SELECT @DefinitionText = ND_Text, @DefinitionSubject = ND_Subject 
						FROM NotificationDefinition 
						WHERE ND_Key = @C_NotificationEvent_ProjectOverdueItems;
				END
			END

			-- replace data tokens
			SELECT @DefinitionSubject = REPLACE(@DefinitionSubject, @C_TOKEN_ProjectSL, @SL_Project);
			SELECT @DefinitionText = REPLACE(@DefinitionText, @C_TOKEN_ProjectSL, @SL_Project);
			SELECT @DefinitionText = REPLACE(@DefinitionText, @C_TOKEN_RiskItemsSL, @SL_RiskItems);
			SELECT @DefinitionText = REPLACE(@DefinitionText, @C_TOKEN_IssueItemsSL, @SL_IssueItems);
			SELECT @DefinitionText = REPLACE(@DefinitionText, @C_TOKEN_ActionsSL, @SL_Actions);
			SELECT @DefinitionText = REPLACE(@DefinitionText, @C_TOKEN_DeliverablesSL, @SL_Deliverables);

			-- Get counts of overdue items
			SELECT @intRiskItemCount = COUNT(RiskItem.RI_Key)
				FROM Risk 
				INNER JOIN RiskItem ON (RiskItem.RK_Code = Risk.RK_Code)
				WHERE (Risk.PR_Code = @curPRCode)
				AND (Risk.RK_Type = 1)						-- Risk
				AND (Risk.RK_Status = -1)					-- open
				AND (RiskItem.RI_Status = -1)				-- open
				AND (RiskItem.RI_DueDate < @CurrentOADate)	-- overdue 

			SELECT @intIssueItemCount = COUNT(RiskItem.RI_Key)
				FROM Risk 
				INNER JOIN RiskItem ON (RiskItem.RK_Code = Risk.RK_Code)
				WHERE (Risk.PR_Code = @curPRCode)
				AND (Risk.RK_Type = 2)						-- Issue
				AND (Risk.RK_Status = -1)					-- open
				AND (RiskItem.RI_Status = -1)				-- open
				AND (RiskItem.RI_DueDate < @CurrentOADate)	-- overdue 

			SELECT @intActionCount = COUNT(AN_Key)
				FROM Action
				WHERE (PR_Code = @curPRCode)
				AND (AN_Closed = 0)
				AND (AN_ToDo = -1)
				AND (AN_StartDate < @CurrentOADate)

			SELECT @intDeliverableCount = COUNT(DV_Key)
				FROM Deliverable
				WHERE (PR_Code = @curPRCode)
				AND (DV_Audit = 0)							-- not an audit record
				AND (DV_Status = 1)							-- confirmed
				AND (DV_DeliveryDate < @CurrentOADate)		-- overdue 

			SELECT @intTaskCount = COUNT(TA_Key) 
				FROM Task 
				WHERE (PR_Code = @curPRCode)
				AND (TA_Active = -1)						-- not deleted
				AND (TA_SystemFlag =0)					-- task based
				AND (TA_Status = 1)							-- confirmed
				AND (TA_Empty = 0)							-- not empty
				AND (TA_Summary = 0)						-- not summary
				AND (TA_EndDate < @CurrentOADate)			-- overdue 
				AND (ISNULL(TA_PercentComplete, 0) < 100)	-- incomplete

			IF ((@intRiskItemCount > 0) OR
				(@intIssueItemCount > 0) OR
				(@intActionCount > 0) OR
				(@intDeliverableCount > 0) OR
				(@intTaskCount > 0))
			BEGIN
				-- replace the project specific text for the notification
				SET  @NotificationText = @DefinitionText;
				SELECT @NotificationText = REPLACE(@NotificationText, @C_TOKEN_ProjectCode, @curPRCode);
				SELECT @NotificationText = REPLACE(@NotificationText, @C_TOKEN_ProjectName, @curPRDesc);

				SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_IssueItemCount, @intIssueItemCount);
				SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_ActionCount, @intActionCount);
				SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_DeliverableCount, @intDeliverableCount);

				SET  @NotificationSubject = @DefinitionSubject;
				SELECT @NotificationSubject = REPLACE(@NotificationSubject, @C_TOKEN_ProjectName, @curPRDesc);

				-- Risk Items
				IF (@intRiskItemCount > 0)
				BEGIN
					-- Remove tags
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_RiskItemStart, '');
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_RiskItemEnd, '');

					-- Insert count
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_RiskItemCount, @intRiskItemCount);
				END
				ELSE
				BEGIN
					-- Remove section
					SET @intStartIndex = CHARINDEX(@C_TOKEN_RiskItemStart, @NotificationText);
					SET @intEndIndex = CHARINDEX(@C_TOKEN_RiskItemEnd, @NotificationText) + LEN(@C_TOKEN_RiskItemEnd) - 1;
					SET @intLength = @intEndIndex - @intStartIndex + 1;
					SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');
				END

				-- Issue Items
				IF (@intIssueItemCount > 0)
				BEGIN
					-- Remove tags
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_IssueItemStart, '');
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_IssueItemEnd, '');

					-- Insert count
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_IssueItemCount, @intIssueItemCount);
				END
				ELSE
				BEGIN
					-- Remove section
					SET @intStartIndex = CHARINDEX(@C_TOKEN_IssueItemStart, @NotificationText);
					SET @intEndIndex = CHARINDEX(@C_TOKEN_IssueItemEnd, @NotificationText) + LEN(@C_TOKEN_IssueItemEnd) - 1;
					SET @intLength = @intEndIndex - @intStartIndex + 1;
					SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');
				END

				-- Actions
				IF (@intActionCount > 0)
				BEGIN
					-- Remove tags
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_ActionStart, '');
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_ActionEnd, '');

					-- Insert count
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_ActionCount, @intActionCount);
				END
				ELSE
				BEGIN
					-- Remove section
					SET @intStartIndex = CHARINDEX(@C_TOKEN_ActionStart, @NotificationText);
					SET @intEndIndex = CHARINDEX(@C_TOKEN_ActionEnd, @NotificationText) + LEN(@C_TOKEN_ActionEnd) - 1;
					SET @intLength = @intEndIndex - @intStartIndex + 1;
					SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');
				END

				-- Deliverables
				IF (@intDeliverableCount > 0)
				BEGIN
					-- Remove tags
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_DeliverableStart, '');
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_DeliverableEnd, '');

					-- Insert count
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_DeliverableCount, @intDeliverableCount);
				END
				ELSE
				BEGIN
					-- Remove section
					SET @intStartIndex = CHARINDEX(@C_TOKEN_DeliverableStart, @NotificationText);
					SET @intEndIndex = CHARINDEX(@C_TOKEN_DeliverableEnd, @NotificationText) + LEN(@C_TOKEN_DeliverableEnd) - 1;
					SET @intLength = @intEndIndex - @intStartIndex + 1;
					SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');
				END

				-- Tasks
				IF (@intTaskCount > 0)
				BEGIN
					-- Remove tags
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_TaskStart, '');
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_TaskEnd, '');

					-- Insert count
					SET @NotificationText = REPLACE(@NotificationText, @C_TOKEN_TaskCount, @intTaskCount);
				END
				ELSE
				BEGIN
					-- Remove section
					SET @intStartIndex = CHARINDEX(@C_TOKEN_TaskStart, @NotificationText);
					SET @intEndIndex = CHARINDEX(@C_TOKEN_TaskEnd, @NotificationText) + LEN(@C_TOKEN_TaskEnd) - 1;
					SET @intLength = @intEndIndex - @intStartIndex + 1;
					SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');
				END

				-- Copy now for Email use
				SET @EmailNotificationText = @NotificationText

				-- Remove Email-specific sections
				SET @intStartIndex = CHARINDEX(@C_TOKEN_EmailLoginStart, @NotificationText);
				SET @intEndIndex = CHARINDEX(@C_TOKEN_EmailLoginEnd, @NotificationText) + LEN(@C_TOKEN_EmailLoginEnd) - 1;
				SET @intLength = @intEndIndex - @intStartIndex + 1;
				SET @NotificationText = STUFF(@NotificationText, @intStartIndex, @intLength, '');

				-- Create Notification in the application
				INSERT INTO Notifications (RE_Code, NTF_Date, NTF_Source, ND_Key, NTF_Type, NTF_Status, NTF_Text, NTF_Subject, 
										   US_CodeLastEdit, NTF_LastEditDate, NTF_ContextCode)
					VALUES (@curRECode, 
							@CurrentOADateTime,  
							@C_NotificationSource_ScheduledJob,				-- Scheduled
							@C_NotificationEvent_ProjectOverdueItems,		-- Event key (see NotificationDefinition table)
							@C_NotificationType_All,						-- Type All
							@C_NotificationStatus_Unread,					-- Unread
							@NotificationText,
							@NotificationSubject,
							@pUserCode,
							@CurrentOADateTime,
							@curPRCode
							);

				-- Email the Notification (if options set)
				IF (@NotificationsEmailActive <> 0)
				BEGIN
					IF EXISTS(SELECT * FROM ResNotificationDefs WHERE RE_Code = @curRECode AND ND_Key = @C_NotificationEvent_ProjectOverdueItems)
					BEGIN
						-- Email the Notification
						IF (LEN(@ResEmail) > 0)
						BEGIN

							IF (LEN(@EmailLoginUrl) > 0)
							BEGIN
								-- Remove tags
								SET @EmailNotificationText = REPLACE(@EmailNotificationText , @C_TOKEN_EmailLoginStart, '');
								SET @EmailNotificationText = REPLACE(@EmailNotificationText , @C_TOKEN_EmailLoginEnd, '');

								-- Insert Url
								SELECT @EmailNotificationText = REPLACE(@EmailNotificationText, @C_TOKEN_EmailLoginUrl, @EmailLoginUrl);
							END
							ELSE
							BEGIN
								-- Remove section
								SET @intStartIndex = CHARINDEX(@C_TOKEN_EmailLoginStart, @EmailNotificationText);
								SET @intEndIndex = CHARINDEX(@C_TOKEN_EmailLoginEnd, @EmailNotificationText) + LEN(@C_TOKEN_EmailLoginEnd) - 1;
								SET @intLength = @intEndIndex - @intStartIndex + 1;
								SET @EmailNotificationText = STUFF(@EmailNotificationText, @intStartIndex, @intLength, '');
							END

							-- Apply Subject Prefix
							SET @NotificationSubject = @NotificationsEmailSubjectPrefix + @NotificationSubject;

							SET @EmailNotificationText = REPLACE(@EmailNotificationText, @C_LinebreakToken, @C_CarriageReturn);

							EXEC msdb.dbo.sp_send_dbmail 
												@recipients = @ResEmail, 
												@profile_name = 'KIP Notifications', 
												@body_format = 'TEXT', 
												@body = @EmailNotificationText, 
												@subject = @NotificationSubject;
						END
					END
				END
			END

			FETCH NEXT FROM curProjects INTO @curPRCode, @curPRDesc, @curRECode, @ResEmail, @resCulture;
		END

		CLOSE curProjects;
		DEALLOCATE curProjects;

	END

END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_CheckForProjectOverdueItems]
	TO [V6N14816rwZf]
GO
