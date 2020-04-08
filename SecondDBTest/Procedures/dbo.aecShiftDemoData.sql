SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--TL1e

--TL2s
CREATE PROCEDURE aecShiftDemoData
    @intNumberOfWeeks INTEGER,
    @dbName NVARCHAR(20),
	@strPassphrase NVARCHAR(20)
AS
    SET NOCOUNT ON;

	BEGIN TRY
		IF (@dbName <> db_name())
		BEGIN
			RAISERROR('Database name parameter value does not match the current database', 16, 1);
		END
		
		IF (@strPassphrase <> 'aecShiftData')
		BEGIN
			RAISERROR('You do not have permission to run this procedure', 16, 1);
		END

		----------------------------
		-- Validate PlanningPeriods
		----------------------------

		-- If we have split periods then the shift demo data cannot be performed
		IF ((SELECT COUNT(*) FROM PlanningPeriod WHERE PP_StartDate <> PP_WeekStart) > 0)
		BEGIN
			RAISERROR('Database contains split periods. Data can not be adjusted.', 16, 1);
		END
		
		-------------------
		-- Begin processing
		-------------------
		DECLARE @strSQL NVARCHAR(MAX)
		DECLARE @strError AS NVARCHAR(MAX);
		DECLARE @intSeverity AS INTEGER;

		DECLARE @intNumberOfDays AS INTEGER;
		SET @intNumberOfDays = @intNumberOfWeeks * 7;

		-- Get the Date of the first day of the current month
		DECLARE @intCurrentMonthDate AS INTEGER
		SET @intCurrentMonthDate = DATEDIFF(dd, CAST('18991230' AS DATETIME), GETDATE()) - (DAY(GETDATE()) - 1)

		-- Get the Start Date of the first Planning Period in the current month
		DECLARE @intCurrentMonthPPStartDate AS INTEGER

		SELECT @intCurrentMonthPPStartDate = MIN(PP_StartDate)
			FROM PlanningPeriod
			WHERE PP_Month = @intCurrentMonthDate

		--NF2s
		------------------------------
		-- Delete ProfileDemandDetails
		------------------------------
		SET @strSQL = N'DELETE FROM ProfileDemandDetail ' +
			'WHERE PP_StartDate IN ' +
			'(SELECT TOP ' + CAST(@intNumberOfWeeks AS NVARCHAR(10)) + 
			' PP_StartDate FROM PlanningPeriod ORDER BY PP_StartDate DESC)';

		EXECUTE(@strSQL);
		--NF2e

		-------------------------------------------------
		-- Check that the required Planning Periods exist
		-------------------------------------------------
		DECLARE @dblMaxPlanningPeriodStartDate AS FLOAT;
		DECLARE @dblMaxUsedPlanningPeriodStartDate AS FLOAT;
		DECLARE @dblAdditionalRequiredPlanningPeriods AS FLOAT;
		DECLARE @dblPlanningPeriodStartDate AS FLOAT;

		SELECT @dblMaxPlanningPeriodStartDate = MAX(PP_StartDate) FROM PlanningPeriod;

		SET @dblMaxUsedPlanningPeriodStartDate = 0;
		SET @dblAdditionalRequiredPlanningPeriods = 0;

		-- Check all tables that reference Planning Periods and find the highest
		-- Start Date that is currently in use
		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM BenefitActual;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM DepartmentExpenditureDetail;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM ProfileBenefitDetail;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM ProfileBudget;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM ProfileDemandDetail;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM ProfileExpenditureDetail;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM ProjectExpActuals;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		SELECT @dblPlanningPeriodStartDate = MAX(PP_StartDate) FROM ProjectTSActuals;

		IF (@dblPlanningPeriodStartDate > @dblMaxUsedPlanningPeriodStartDate)
			SET @dblMaxUsedPlanningPeriodStartDate = @dblPlanningPeriodStartDate;


		-- See how many additional Planning Periods we need
		SET @dblAdditionalRequiredPlanningPeriods = (@dblMaxUsedPlanningPeriodStartDate + @intNumberOfDays - @dblMaxPlanningPeriodStartDate) / 7;

		IF (@dblAdditionalRequiredPlanningPeriods > 0)
		BEGIN
			SET @strError = 'An additional ' + 
								CAST(@dblAdditionalRequiredPlanningPeriods AS NVARCHAR(20)) +
								' Planning Periods are required';
			RAISERROR(@strError, 16, 1)
		END

		--------------------
		-- Start Transaction
		--------------------
		BEGIN TRANSACTION

		----------
		-- Actions
		----------
		UPDATE Action SET 
			AN_StartDate = AN_StartDate + @intNumberOfDays,
			AN_EndDate = AN_EndDate + @intNumberOfDays,
			AN_RequiredDate = AN_RequiredDate + @intNumberOfDays,
			AN_EarliestStartDate = AN_EarliestStartDate + @intNumberOfDays,
			AN_LastEditDate = AN_LastEditDate + @intNumberOfDays,
			AN_LastEdit = dbo.aecFormatLastEdit(US_Code, AN_LastEditDate + @intNumberOfDays);

		-----------------
		-- Action Forward
		-----------------
		UPDATE ActionForward SET 
			ANF_Date = ANF_Date + @intNumberOfDays;

		--------------
		-- Assignments
		--------------
		UPDATE Assignment SET 
			AS_StartDate = AS_StartDate + @intNumberOfDays,
			AS_EndDate = AS_EndDate + @intNumberOfDays, 
			AS_CreatedDateTime = AS_CreatedDateTime + @intNumberOfDays, 
			AS_LastEditDate = AS_LastEditDate + @intNumberOfDays,
			AS_LastEdit = dbo.aecFormatLastEdit(US_Code, AS_LastEditDate + @intNumberOfDays);

		------------------
		-- Assignment Plan
		------------------
		UPDATE AssignmentPlan 
			SET 
			AP_Date = AP_Date + @intNumberOfDays,
			AP_LastEdit = AS_LastEdit
			FROM AssignmentPlan
			INNER JOIN Assignment ON Assignment.AS_Key = AssignmentPlan.AS_Key;

		------------------
		-- Benefit Actuals
		------------------
		UPDATE BenefitActual SET 
			BA_Date = BA_Date + @intNumberOfDays,
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays,
			BA_LastEditDate = BA_LastEditDate + @intNumberOfDays;

		--------------------
		-- Billing Contracts
		--------------------
		UPDATE BillingContract SET 
			BC_LastEditDate = BC_LastEditDate + @intNumberOfDays;

		-------------------------
		-- Billing Contract Lines
		-------------------------
		UPDATE BillingContractLine SET 
			BCL_CycleDate = BCL_CycleDate + @intNumberOfDays,
			BCL_LastBilledDate = BCL_LastBilledDate + @intNumberOfDays;

		---------------------------------
		-- Billing Contract Line Archives
		---------------------------------
		UPDATE BillingContractLineArchive SET 
			BCL_CycleDate = BCL_CycleDate + @intNumberOfDays;

		--------------------------------
		-- Billing Contract Line Details
		--------------------------------
		UPDATE BillingContractLineDetails SET 
			BCD_StartDate = BCD_StartDate + @intNumberOfDays,
			BCD_ExpiryDate = BCD_ExpiryDate + @intNumberOfDays;

		----------------------------------------
		-- Billing Contract Line Details Archive
		----------------------------------------
		UPDATE BillingContractLineDetailsArchive SET 
			BCD_StartDate = BCD_StartDate + @intNumberOfDays,
			BCD_ExpiryDate = BCD_ExpiryDate + @intNumberOfDays;

		-------------------
		-- Billing Invoices
		-------------------
		UPDATE BillingInvoice SET 
			BI_InvoiceDate = BI_InvoiceDate + @intNumberOfDays,
			BI_LastEditDate = BI_LastEditDate + @intNumberOfDays,
			BI_FilterFromDate = BI_FilterFromDate + @intNumberOfDays,
			BI_FilterToDate = BI_FilterToDate + @intNumberOfDays,
			BI_IssuedOn = BI_IssuedOn + @intNumberOfDays;

		------------------------
		-- Billing Invoice Lines
		------------------------
		UPDATE BillingInvoiceLine SET 
			BIL_LastEditDate = BIL_LastEditDate + @intNumberOfDays;

		----------------------------------------
		-- Billing Invoice Lines Expense Details
		----------------------------------------
		UPDATE BillingInvoiceLineExpDetail SET 
			BIED_Date = BIED_Date + @intNumberOfDays;

		------------------------------------------
		-- Billing Invoice Lines Timesheet Details
		------------------------------------------
		UPDATE BillingInvoiceLineTSDetail SET 
			BITD_Date = BITD_Date + @intNumberOfDays;

		----------
		-- Budgets
		----------
		UPDATE Budget SET 
			BU_FromDate = BU_FromDate + @intNumberOfDays,
			BU_ToDate = BU_ToDate + @intNumberOfDays,
			BU_LastEditDate = BU_LastEditDate + @intNumberOfDays,
			BU_LastEdit = dbo.aecFormatLastEdit(US_Code, BU_LastEditDate + @intNumberOfDays);

		---------
		-- Claims
		---------
		UPDATE Claims SET 
			CM_Date = CM_Date + @intNumberOfDays,
			CM_AcceptanceDate = CM_AcceptanceDate + @intNumberOfDays,
			CM_PaymentDate = CM_PaymentDate + @intNumberOfDays,
			CM_LastEditDate = CM_LastEditDate + @intNumberOfDays,
			CM_LastEdit = dbo.aecFormatLastEdit(US_Code, CM_LastEditDate + @intNumberOfDays),
			CM_ModifiedDate = CM_ModifiedDate + @intNumberOfDays;

		----------------
		-- Close Periods
		----------------
		UPDATE ClosePeriod SET 
			CP_FromDate = CP_FromDate + @intNumberOfDays,
			CP_ToDate = CP_ToDate + @intNumberOfDays,
			CP_LastEditDate = CP_LastEditDate + @intNumberOfDays,
			CP_LastEdit = dbo.aecFormatLastEdit(US_Code, CP_LastEditDate + @intNumberOfDays);

		---------------
		-- Deliverables
		---------------
		UPDATE Deliverable SET 
			DV_DeliveryDate = DV_DeliveryDate + @intNumberOfDays,
			DV_LastEditDate = DV_LastEditDate + @intNumberOfDays;

		--------------------
		-- Deliverable Audit
		--------------------
		UPDATE DeliverableAudit SET 
			DVU_DeliveryDate = DVU_DeliveryDate + @intNumberOfDays,
			DVU_DateTime = DVU_DateTime + @intNumberOfDays;

		---------------------------------
		-- Deliverable Audit Dependencies
		---------------------------------
		UPDATE DeliverableAuditDependencies SET 
			DAD_OriginalDate = DAD_OriginalDate + @intNumberOfDays,
			DAD_DVDeliveryDate = DAD_DVDeliveryDate + @intNumberOfDays;

		--------------------------------
		-- Department Expenditure Detail
		--------------------------------
		UPDATE DepartmentExpenditureDetail SET 
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays;

		---------------------
		-- Department Profile
		---------------------
		UPDATE DepartmentProfile SET 
			DPR_LastEditDate = DPR_LastEditDate + @intNumberOfDays;

		-----------
		-- Expenses
		-----------
		UPDATE Expense SET 
			EX_Date = EX_Date + @intNumberOfDays,
			EX_ApprovalDate = EX_ApprovalDate+ @intNumberOfDays,
			EX_LastEditDate = EX_LastEditDate + @intNumberOfDays,
			EX_LastEdit = dbo.aecFormatLastEdit(US_Code, EX_LastEditDate + @intNumberOfDays);

		----------------
		-- Notifications
		----------------
		UPDATE Notifications SET 
			NTF_Date = NTF_Date + @intNumberOfDays, 
			NTF_ContextDate = NTF_ContextDate + @intNumberOfDays, 
			NTF_LastEditDate = NTF_LastEditDate + @intNumberOfDays;

		----------------
		-- Post Comments
		----------------
		UPDATE PostComments SET 
			PCO_PostedDate = PCO_PostedDate + @intNumberOfDays, 
			PCO_LastEditDate = PCO_LastEditDate + @intNumberOfDays;

		--------
		-- Posts
		--------
		UPDATE Posts SET 
			PST_PostedDate = PST_PostedDate + @intNumberOfDays, 
			PST_LastEditDate = PST_LastEditDate + @intNumberOfDays;

		-----------
		-- Profiles
		-----------
		UPDATE Profile SET 
			PRF_LastEditDate = PRF_LastEditDate + @intNumberOfDays;

		------------------
		-- Profile Budgets
		------------------
		UPDATE ProfileBudget SET 
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays;

		-------------------------
		-- Profile Demand Details
		-------------------------
		UPDATE ProfileDemandDetail SET 
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays;

		------------------------------
		-- Profile Expenditure Details
		------------------------------
		UPDATE ProfileExpenditureDetail SET 
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays;

		--------------------------
		-- Profile Benefit Details
		--------------------------
		UPDATE ProfileBenefitDetail SET 
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays;

		------------------------
		-- Profile Benefit Lines
		------------------------
		UPDATE ProfileBenefitLine SET 
			PBL_TargetDate = PBL_TargetDate + @intNumberOfDays;

		--------------------------
		-- Project Actuals Updated
		--------------------------
		UPDATE ProjectActualsUpdated SET 
			PAU_LastUpdated = PAU_LastUpdated+ @intNumberOfDays;

		--------------------------
		-- Project Expense Actuals
		--------------------------
		UPDATE ProjectExpActuals SET 
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays;

		----------------------------
		-- Project Timesheet Actuals
		----------------------------
		UPDATE ProjectTSActuals SET 
			PP_StartDate = PP_StartDate + @intNumberOfDays,
			PP_EndDate = PP_EndDate + @intNumberOfDays;

		--------
		-- Risks
		--------
		UPDATE Risk SET 
			RK_IdentifiedDate = RK_IdentifiedDate + @intNumberOfDays,
			RK_ImpactDate = RK_ImpactDate + @intNumberOfDays,
			RK_LastEditDate = RK_LastEditDate + @intNumberOfDays;

		-------------
		-- Risk Items
		-------------
		UPDATE RiskItem SET 
			RI_DueDate = RI_DueDate + @intNumberOfDays,
			RI_LastEditDate = RI_LastEditDate + @intNumberOfDays;

		------------
		-- Scenarios
		------------
		UPDATE Scenario SET 
			SCN_LastEditDate = SCN_LastEditDate + @intNumberOfDays;

		--------
		-- Tasks
		--------
		UPDATE Task SET 
			TA_StartDate = TA_StartDate + @intNumberOfDays,
			TA_EndDate = TA_EndDate + @intNumberOfDays,
			TA_EstimateEndDate = TA_EstimateEndDate + @intNumberOfDays,
			TA_LastEditDate = TA_LastEditDate + @intNumberOfDays,
			TA_ConstraintDate = TA_ConstraintDate + @intNumberOfDays,
			TA_LastEdit = dbo.aecFormatLastEdit(US_Code, TA_LastEditDate + @intNumberOfDays)
			WHERE ISNULL(TA_Empty, 0) = 0;

		--PG4s
		---------------------
		-- ProjectPlanControl
		---------------------
		UPDATE ProjectPlanControl Set 
			PPC_PlanStartDate = PPC_PlanStartDate + @intNumberOfDays,
			PPC_CheckedOutOn = PPC_CheckedOutOn+ @intNumberOfDays
		--PG4e

		------------
		-- Timecards
		------------
		UPDATE Timecard SET 
			TC_Date = TC_Date + @intNumberOfDays;

		------------------------
		-- Timesheet Submissions
		------------------------
		UPDATE TimesheetSubmissions SET 
			TSS_WeekCommencing = TSS_WeekCommencing + @intNumberOfDays, 
			TSS_SubmissionDate = TSS_SubmissionDate + @intNumberOfDays, 
			TSS_AcceptanceDate = TSS_AcceptanceDate + @intNumberOfDays, 
			TSS_RejectionDate = TSS_RejectionDate + @intNumberOfDays, 
			TSS_UnlockDate = TSS_UnlockDate + @intNumberOfDays, 
			TSS_LastEditDate = TSS_LastEditDate + @intNumberOfDays;

		-------------
		-- Timesheets
		-------------
		UPDATE Timesht SET 
			TS_Date = TS_Date + @intNumberOfDays, 
			TS_ApprovalDate = TS_ApprovalDate + @intNumberOfDays, 
			TS_LastEditDate = TS_LastEditDate + @intNumberOfDays,
			TS_LastEdit = dbo.aecFormatLastEdit(US_Code, TS_LastEditDate + @intNumberOfDays);

		UPDATE TimeshtAudit SET 
			TS_Date = TS_Date + @intNumberOfDays, 
			TS_ApprovalDate = TS_ApprovalDate + @intNumberOfDays, 
			TS_LastEditDate = TS_LastEditDate + @intNumberOfDays,
			TS_LastEdit = dbo.aecFormatLastEdit(US_Code, TS_LastEditDate + @intNumberOfDays);

		------------------
		-- User Parameters
		------------------
		UPDATE UserParams SET 
			UP_Number = UP_Number + @intNumberOfDays,
			UP_Value = CAST(UP_Number + @intNumberOfDays AS NVARCHAR)
			WHERE UP_Code IN (

				-- My Work dashboard
				'DSH-MYWORK-MYPOSTS-FROM-DATE',
				'DSH-MYWORK-MYPOSTS-TO-DATE',

				-- Organisation dashboard
				-- Deliberately don't do these - see documentation
				--'DSH-ORGANISATION-HEADCOUNT-FROM-DATE',
				--'DSH-ORG-FINANCE-FROM-DATE',

				-- Project dashboard
				'DSH-PROJECT-APRVL-FROMDATE-PROJECT',
				'DSH-PROJECT-APRVL-TODATE-PROJECT',
				'DSH-PROJECT-DEL-FROM-DATE',
				'DSH-PROJECT-DEL-TO-DATE',
				-- Deliberately don't do these - see documentation
				'DSH-PROJECT-FINANCE-FROM-DATE',
				'DSH-PROJECT-RESOURCE-FROM-DATE',

				'DSH-PROJECT-POSTS-FROM-DATE',
				'DSH-PROJECT-POSTS-TO-DATE',

				'DSH-PROJECT-PR-ELEMENT1-FROMDATE-PROJECT',
				'DSH-PROJECT-PR-ELEMENT2-FROMDATE-PROJECT',
				'DSH-PROJECT-PR-ELEMENT3-FROMDATE-PROJECT',
				'DSH-PROJECT-PR-ELEMENT4-FROMDATE-PROJECT',
				'DSH-PROJECT-PR-ELEMENT1-TODATE-PROJECT',
				'DSH-PROJECT-PR-ELEMENT2-TODATE-PROJECT',
				'DSH-PROJECT-PR-ELEMENT3-TODATE-PROJECT',
				'DSH-PROJECT-PR-ELEMENT4-TODATE-PROJECT',

				-- Resource Capability dashboard
				'DSH-RESOURCE-CAPABILITY-FROMDATE',

				-- Scenario dashboard
				'DSH-SCENARIO-RESOURCE-FROMDATE',

				'DSH-SCENARIO-PR-ELEMENT1-FROMDATE-SCENARIO',
				'DSH-SCENARIO-PR-ELEMENT2-FROMDATE-SCENARIO',
				'DSH-SCENARIO-PR-ELEMENT3-FROMDATE-SCENARIO',
				'DSH-SCENARIO-PR-ELEMENT1-TODATE-SCENARIO',
				'DSH-SCENARIO-PR-ELEMENT2-TODATE-SCENARIO',
				'DSH-SCENARIO-PR-ELEMENT3-TODATE-SCENARIO',

				-- Scheduling dashboard
				'DSH-SCHD-CAL-FROM-DATE',
				'DSH-SCHD-CONF-FROM-DATE',
				'DSH-SCHD-CONF-TO-DATE',
				'DSH-SCHD-REQ-FROM-DTE',
				'DSH-SCHD-REQ-TO-DTE',
				'DSH-SCHD-RESPLAN-SELECTED-DATE',
				'DSH-SCHD-SCHD-FROM-DATE',
				'DSH-SCHD-SCHD-TO-DATE',

				-- User dashboard
				'DSH-USR-HOME-EXP-FROM-DTE',
				'DSH-USR-HOME-EXPCLM-FROM-DTE',
				'DSH-USER-DEL-FROM-DATE',
				'DSH-USER-DEL-TO-DATE',
				'DSH-USER-MYACTIONS-FROM-DATE',
				'DSH-USER-MYACTIONS-TO-DATE',
				'DSH-USER-MYDEP-FROM-DATE',

				'DSH-USER-PR-ELEMENT1-FROMDATE-USER',
				'DSH-USER-PR-ELEMENT2-FROMDATE-USER',
				'DSH-USER-PR-ELEMENT3-FROMDATE-USER',
				'DSH-USER-PR-ELEMENT1-TODATE-USER',
				'DSH-USER-PR-ELEMENT2-TODATE-USER',
				'DSH-USER-PR-ELEMENT3-TODATE-USER',

				-- Project Plans?
				'PLN-ACTIVITYOVERVIEW-FROMDATE',
				'PLN-ACTIVITYOVERVIEW-TODATE'
		
				);

		-- Business Function dashboards

		-- CRM View dashboards

		-- Process Support dashboards
		UPDATE UserParams SET 
			UP_Number = UP_Number + @intNumberOfDays,
			UP_Value = CAST(UP_Number + @intNumberOfDays AS NVARCHAR)
			WHERE UP_Code LIKE 'DSH-PA-FROMDATE%';

		UPDATE UserParams SET 
			UP_Number = UP_Number + @intNumberOfDays,
			UP_Value = CAST(UP_Number + @intNumberOfDays AS NVARCHAR)
			WHERE UP_Code LIKE 'DSH-PA-TODATE%';

		--------------------
		-- System Parameters
		--------------------

		-- Set First Open Month to be the current month if we are in Manual Mode
		DECLARE @intFirstOpenMonthMode AS INTEGER

		SELECT @intFirstOpenMonthMode = SP_Number FROM SystemParams WHERE SP_Code = 'CV-LOCKMONTHS';

		IF (@intFirstOpenMonthMode = 0)
		BEGIN
			UPDATE SystemParams SET
				SP_Number = @intCurrentMonthDate,
				SP_Value = CAST(@intCurrentMonthDate AS NVARCHAR)
				WHERE SP_Code = 'CV-LOCKDATE';
		END

		----------------
		-- Custom Fields
		----------------
		DECLARE @strCustomTableName NVARCHAR(70)
		DECLARE @intCustomTableIndex INTEGER
		DECLARE @intCustomFieldIndex INTEGER

		DECLARE curCustomFields CURSOR LOCAL READ_ONLY
		FOR
			SELECT CF_CustomTableName, CF_CustomTableIndex, CF_CustomFieldIndex
				FROM CustomFields
				WHERE CF_DataType = 10;

		OPEN curCustomFields

		FETCH NEXT FROM curCustomFields
			INTO @strCustomTableName, @intCustomTableIndex, @intCustomFieldIndex

		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Build SQL of the form:
			--	UPDATE XxxCustomNum1 SET CU_Value1 = CU_Value1 + 7 WHERE CU_Value1 IS NOT NULL;
			SET @strSQL = N'UPDATE ' +
				@strCustomTableName + CAST(@intCustomTableIndex AS NVARCHAR(10)) +
				' SET CU_Value' + CAST(@intCustomFieldIndex AS NVARCHAR(10)) +
				' = CU_Value' + CAST(@intCustomFieldIndex AS NVARCHAR(10)) +
				' + ' + CAST(@intNumberOfDays AS NVARCHAR(10)) +
				' WHERE CU_Value' + CAST(@intCustomFieldIndex AS NVARCHAR(10)) +
				' IS NOT NULL;';

			EXECUTE(@strSQL);

			FETCH NEXT FROM curCustomFields
				INTO @strCustomTableName, @intCustomTableIndex, @intCustomFieldIndex
		END

		CLOSE curCustomFields
		DEALLOCATE curCustomFields

		-------------------------
		-- Commit the transaction
		-------------------------
		COMMIT

	END TRY

	BEGIN CATCH

		---------------------
		-- There was an error
		---------------------
		IF (@@TRANCOUNT > 0)
			ROLLBACK

		IF (CURSOR_STATUS('LOCAL', 'curCustomFields') <> - 3)
		BEGIN
			CLOSE curCustomFields
			DEALLOCATE curCustomFields
		END

		-- Raise an error with the details of the exception
		SET @strError = ERROR_MESSAGE();
		SET @intSeverity = ERROR_SEVERITY();
		RAISERROR(@strError, @intSeverity, 1)

	END CATCH
	
--End aecShiftDemoData
GO
GRANT EXECUTE
	ON [dbo].[aecShiftDemoData]
	TO [V6N14816rwZf]
GO
