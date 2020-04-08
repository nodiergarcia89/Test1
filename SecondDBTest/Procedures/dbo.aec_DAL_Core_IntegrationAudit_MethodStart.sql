SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_DAL_Core_IntegrationAudit_MethodStart
Purpose
    Called when a Web Service Method starts.
Behaviour
	Creates an entry in the IntegrationAudit table.
Parameters
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
    Key of the inserted record
*******************************************************************************************************/
CREATE PROCEDURE [aec_DAL_Core_IntegrationAudit_MethodStart](	
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
	@pIAUNotes				NVARCHAR(2000) = NULL,
	@pIAUKey				INT OUTPUT)
AS
BEGIN	
			
    -- Insert statements for procedure here
	INSERT INTO IntegrationAudit (IAU_ServerName, IAU_SourceIPAddress, IAU_SourceIPAddressV4, IAU_ServiceName, IAU_MethodName, US_Code, IAU_StartTime, IAU_Notes)
	VALUES(@pIAUServerName, @pIAUSourceIPAddress, @pIAUSourceIPAddressV4, @pIAUServiceName, @pIAUMethodName, @pUSCode, @pIAUStartTime, @pIAUNotes);
	
	SELECT @pIAUKey = SCOPE_IDENTITY();									

END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Core_IntegrationAudit_MethodStart]
	TO [V6N14816rwZf]
GO
