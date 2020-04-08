SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_DAL_Core_IntegrationAudit_MethodEnd
Purpose
    Called when a Web Service Method finishes.
Behaviour
	Updates the specified entry in the IntegrationAudit table.
Parameters
	@pIAUKey				- Key of record to be updated
	@pIAUServerName			- Web Server Name
	@pIAUSourceIPAddress	- Source IP Address
	@pIAUSourceIPAddressV4	- Source IP Address V4
	@pIAUServiceName		- Web Service Name
	@pIAUMethodName			- Web Method Name
	@pUSCode				- User Code
	@pIAUStartTime			- Method Start Date/Time
	@pIAUEndTime			- Method End Date/Time
	@pIAUSucceeded			- -1 = Yes, 0 = No (applicable to Insert / Update types of method)
	@pIAURowCount			- Number of rows returned (applicable to Get Multiple operations
	@pIAUNotes				- Additional Notes
Prerequisites
	None
Return
    None
*******************************************************************************************************/
CREATE PROCEDURE [aec_DAL_Core_IntegrationAudit_MethodEnd](
	@pIAUKey				INT,
	@pIAUServerName			NVARCHAR(150) = NULL,
	@pIAUSourceIPAddress	NVARCHAR(70) = NULL, 
	@pIAUSourceIPAddressV4	NVARCHAR(70) = NULL, 
	@pIAUServiceName		NVARCHAR(70) = NULL, 
	@pIAUMethodName			NVARCHAR(70) = NULL, 
	@pUSCode				NVARCHAR(20) = NULL,	
	@pIAUStartTime			FLOAT = NULL,	
	@pIAUEndTime			FLOAT = NULL,
	@pIAUSucceeded			SMALLINT = NULL,
	@pIAURowCount			INT = NULL,
	@pIAUNotes				NVARCHAR(2000) = NULL)
AS
BEGIN	

    -- Insert statements for procedure here
	IF (@pIAUKey > 0)
	BEGIN
		UPDATE IntegrationAudit 
		SET IAU_EndTime = @pIAUEndTime, IAU_Succeeded = @pIAUSucceeded, IAU_RowCount = @pIAURowCount
		WHERE IAU_Key = @pIAUKey;
	END	

END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Core_IntegrationAudit_MethodEnd]
	TO [V6N14816rwZf]
GO
