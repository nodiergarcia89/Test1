SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO




/******************************************************************************************************
	aec_BL_Timesheet_AuditTimesheetSubmission
Purpose
    Audit the Timesheets associated with a Timesheet Submission.
Behaviour
	Creates copies of the Timesht records in the Timesht Audit table.
	Creates copies of the associated Custom Field records in the appropriate Custom Field Audit tables.
	Creates copies of any associated Custom Field Free Text records in the CustomFieldFreeTextAudit table.
Parameters
    @pKey		- The Key of the Timesheet Submission record
Prerequisites
	None
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Timesheet_AuditTimesheetSubmission](@pKey AS INTEGER)
AS
BEGIN
	DECLARE @intNumTables AS INTEGER;
	DECLARE @intSTxtTables AS INTEGER;
	DECLARE @intTxtTables AS INTEGER;
	DECLARE @intTable AS INTEGER;
	DECLARE @intField AS INTEGER;
	DECLARE @strSourceTable AS NVARCHAR(50);
	DECLARE @strDestinationTable AS NVARCHAR(50);
	DECLARE @strSQL AS NVARCHAR(MAX);
	DECLARE @strParamDefinition AS NVARCHAR(500);

	-- Maximum numbers of each type of Custom Field slot
	DECLARE @INT_MaxNumFields AS INTEGER;
	DECLARE @INT_MaxSTxtFields AS INTEGER;
	DECLARE @INT_MaxTxtFields AS INTEGER;

	SET @INT_MaxNumFields = 50;
	SET @INT_MaxSTxtFields = 50;
	SET @INT_MaxTxtFields = 15;

	--------------------------
	-- Audit Timesheet records
	--------------------------
	INSERT INTO TimeshtAudit (
	TSS_Key,
	TS_Key,
	TS_Date,
	RE_Code,
	PR_Code,
	AC_Code,
	RE_CodeRole,
	DE_Code,
	CO_Code,
	CI_Key,
	TS_Accrued,
	TS_CostRateAmt,
	CH_Code,
	TS_ChargeRateAmt,
	TS_LocalCostRateAmt,
	TS_LocalCostCurrencySymbol,
	TS_LocalChargeRateAmt,
	TS_LocalChargeCurrencySymbol,
	TS_StartTime,
	TS_FinishTime,
	TS_Hours,
	TS_Chargeable,
	TS_Overtime,
	IH_Key,
	TA_Key,
	AS_Key,
	MS_Key,
	TS_Notes,
	TS_Approved,
	TS_ApprovalDate,
	TS_ApprovalRef,
	CP_Key,
	CC_Code,
	TS_DirectEntry,
	TS_Null,
	US_Code,
	TS_LastEditDate,
	TS_LastEdit,
	BI_Key,
	BCD_Key,
	TS_WrittenOff,
	TS_Invoiced,
	BIL_Key)
	SELECT 
	TSS_Key,
	TS_Key,
	TS_Date,
	RE_Code,
	PR_Code,
	AC_Code,
	RE_CodeRole,
	DE_Code,
	CO_Code,
	CI_Key,
	TS_Accrued,
	TS_CostRateAmt,
	CH_Code,
	TS_ChargeRateAmt,
	TS_LocalCostRateAmt,
	TS_LocalCostCurrencySymbol,
	TS_LocalChargeRateAmt,
	TS_LocalChargeCurrencySymbol,
	TS_StartTime,
	TS_FinishTime,
	TS_Hours,
	TS_Chargeable,
	TS_Overtime,
	IH_Key,
	TA_Key,
	AS_Key,
	MS_Key,
	TS_Notes,
	TS_Approved,
	TS_ApprovalDate,
	TS_ApprovalRef,
	CP_Key,
	CC_Code,
	TS_DirectEntry,
	TS_Null,
	US_Code,
	TS_LastEditDate,
	TS_LastEdit,
	BI_Key,
	BCD_Key,
	TS_WrittenOff,
	TS_Invoiced,
	BIL_Key
	FROM Timesht
	WHERE TSS_Key = @pKey;

	---------------------------------------
	-- Audit Timesheet Custom Field records
	---------------------------------------

	-- Get counts of existing Custom Field Tables
	SELECT
		@intNumTables = CustomTables.CT_Num,
		@intSTxtTables = CustomTables.CT_STxt,
		@intTxtTables = CustomTables.CT_Txt
	FROM CustomTables
	WHERE CustomTables.CT_Table = 1029;

	-- Audit Num Tables
	SET @intTable = 1;
	WHILE (@intTable <= @intNumTables)
	BEGIN
		SET @strSourceTable = 'TimeshtCustomNum' + CAST(@intTable AS NVARCHAR)
		SET @strDestinationTable = @strSourceTable + 'Audit'

		SET @strSQL = 'INSERT INTO ' + @strDestinationTable + ' ('
		SET @strSQL = @strSQL + 'TSS_Key, '
		SET @strSQL = @strSQL + 'TS_Key, '

		SET @intField = 1
		WHILE (@intField <= @INT_MaxNumFields)
		BEGIN
			SET @strSQL = @strSQL + 'CU_Value' + CAST(@intField AS NVARCHAR) + ', '
			SET @intField = @intField + 1;
		END

		-- Trim trailing ","
		SET @strSQL = SUBSTRING(@strSQL, 1, LEN(@strSQL) - 1)

		SET @strSQL = @strSQL + ') SELECT '
		SET @strSQL = @strSQL + 'Timesht.TSS_Key, '
		SET @strSQL = @strSQL + 'Timesht.TS_Key, '

		SET @intField = 1
		WHILE (@intField <= @INT_MaxNumFields)
		BEGIN
			SET @strSQL = @strSQL + @strSourceTable + '.CU_Value' + CAST(@intField AS NVARCHAR) + ', '
			SET @intField = @intField + 1;
		END

		-- Trim trailing ","
		SET @strSQL = SUBSTRING(@strSQL, 1, LEN(@strSQL) - 1) + ' '

		SET @strSQL = @strSQL + 'FROM ' + @strSourceTable + ' '
		SET @strSQL = @strSQL + 'INNER JOIN Timesht ON Timesht.TS_Key = ' + @strSourceTable + '.TS_Key '
		SET @strSQL = @strSQL + 'WHERE Timesht.TSS_Key = @key;'

		SET @strParamDefinition = '@key INTEGER';

		EXECUTE sp_executesql
					@strSQL,
					@strParamDefinition,
					@key = @pKey;

		SET @intTable = @intTable + 1;
	END

	-- Audit STxt Tables
	SET @intTable = 1;
	WHILE (@intTable <= @intNumTables)
	BEGIN
		SET @strSourceTable = 'TimeshtCustomSTxt' + CAST(@intTable AS NVARCHAR)
		SET @strDestinationTable = @strSourceTable + 'Audit'

		SET @strSQL = 'INSERT INTO ' + @strDestinationTable + ' ('
		SET @strSQL = @strSQL + 'TSS_Key, '
		SET @strSQL = @strSQL + 'TS_Key, '

		SET @intField = 1
		WHILE (@intField <= @INT_MaxSTxtFields)
		BEGIN
			SET @strSQL = @strSQL + 'CU_Value' + CAST(@intField AS NVARCHAR) + ', '
			SET @intField = @intField + 1;
		END

		-- Trim trailing ","
		SET @strSQL = SUBSTRING(@strSQL, 1, LEN(@strSQL) - 1)

		SET @strSQL = @strSQL + ') SELECT '
		SET @strSQL = @strSQL + 'Timesht.TSS_Key, '
		SET @strSQL = @strSQL + 'Timesht.TS_Key, '

		SET @intField = 1
		WHILE (@intField <= @INT_MaxSTxtFields)
		BEGIN
			SET @strSQL = @strSQL + @strSourceTable + '.CU_Value' + CAST(@intField AS NVARCHAR) + ', '
			SET @intField = @intField + 1;
		END

		-- Trim trailing ","
		SET @strSQL = SUBSTRING(@strSQL, 1, LEN(@strSQL) - 1) + ' '

		SET @strSQL = @strSQL + 'FROM ' + @strSourceTable + ' '
		SET @strSQL = @strSQL + 'INNER JOIN Timesht ON Timesht.TS_Key = ' + @strSourceTable + '.TS_Key '
		SET @strSQL = @strSQL + 'WHERE Timesht.TSS_Key = @key;'

		SET @strParamDefinition = '@key INTEGER';

		EXECUTE sp_executesql
					@strSQL,
					@strParamDefinition,
					@key = @pKey;

		SET @intTable = @intTable + 1;
	END

	-- Audit Txt Tables
	SET @intTable = 1;
	WHILE (@intTable <= @intNumTables)
	BEGIN
		SET @strSourceTable = 'TimeshtCustomTxt' + CAST(@intTable AS NVARCHAR)
		SET @strDestinationTable = @strSourceTable + 'Audit'

		SET @strSQL = 'INSERT INTO ' + @strDestinationTable + ' ('
		SET @strSQL = @strSQL + 'TSS_Key, '
		SET @strSQL = @strSQL + 'TS_Key, '

		SET @intField = 1
		WHILE (@intField <= @INT_MaxTxtFields)
		BEGIN
			SET @strSQL = @strSQL + 'CU_Value' + CAST(@intField AS NVARCHAR) + ', '
			SET @intField = @intField + 1;
		END

		-- Trim trailing ","
		SET @strSQL = SUBSTRING(@strSQL, 1, LEN(@strSQL) - 1)

		SET @strSQL = @strSQL + ') SELECT '
		SET @strSQL = @strSQL + 'Timesht.TSS_Key, '
		SET @strSQL = @strSQL + 'Timesht.TS_Key, '

		SET @intField = 1
		WHILE (@intField <= @INT_MaxTxtFields)
		BEGIN
			SET @strSQL = @strSQL + @strSourceTable + '.CU_Value' + CAST(@intField AS NVARCHAR) + ', '
			SET @intField = @intField + 1;
		END

		-- Trim trailing ","
		SET @strSQL = SUBSTRING(@strSQL, 1, LEN(@strSQL) - 1) + ' '

		SET @strSQL = @strSQL + 'FROM ' + @strSourceTable + ' '
		SET @strSQL = @strSQL + 'INNER JOIN Timesht ON Timesht.TS_Key = ' + @strSourceTable + '.TS_Key '
		SET @strSQL = @strSQL + 'WHERE Timesht.TSS_Key = @key;'

		SET @strParamDefinition = '@key INTEGER';

		EXECUTE sp_executesql
					@strSQL,
					@strParamDefinition,
					@key = @pKey;

		SET @intTable = @intTable + 1;
	END

	-- Audit Custom Field Free Text Table
	INSERT INTO CustomFieldFreeTextAudit (
	CFFAU_AuditId,
	CFF_Id,
	CF_Key,
	CFF_RecordCode,
	CFF_RecordKey,
	CFF_PlainText,
	CFF_FormattedText)
	SELECT 
	Timesht.TSS_Key,
	CustomFieldFreeText.CFF_Id,
	CustomFieldFreeText.CF_Key,
	CustomFieldFreeText.CFF_RecordCode,
	CustomFieldFreeText.CFF_RecordKey,
	CustomFieldFreeText.CFF_PlainText,
	CustomFieldFreeText.CFF_FormattedText
	FROM CustomFields 
	INNER JOIN CustomFieldFreeText ON CustomFieldFreeText.CF_Key = CustomFields.CF_Key 
	INNER JOIN Timesht ON Timesht.TS_Key = CustomFieldFreeText.CFF_RecordKey
	WHERE CustomFields.CF_Table = 1029
	AND Timesht.TSS_Key = @pKey

END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Timesheet_AuditTimesheetSubmission]
	TO [V6N14816rwZf]
GO
