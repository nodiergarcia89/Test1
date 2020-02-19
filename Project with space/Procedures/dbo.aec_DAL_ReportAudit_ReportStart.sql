SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [aec_DAL_ReportAudit_ReportStart](	
	@pRHKey int = NULL, 
	@pRHName  nvarchar(70) = NULL, 
	@pUSCode nvarchar(20) = NULL,	
	@pRAUSourceIPAddress nvarchar(70) = NULL, 
	@pRAUSourceIPAddressv4 nvarchar(70) = NULL, 
	@pRAUServerName nvarchar(150) = NULL,
	@pRAUStartTime float = NULL,	
	@pRAUEndTime float = NULL,
	@pRAURowCount int = NULL,
	@pRAUKey int output)
AS
BEGIN	
		
    -- Insert statements for procedure here
	INSERT INTO ReportAudit (RH_Key,RH_Name,US_Code,RAU_SourceIPAddress,RAU_SourceIPAddressV4,RAU_ServerName,RAU_StartTime)
	VALUES(@pRHKey,@pRHName,@pUSCode,@pRAUSourceIPAddress,@pRAUSourceIPAddressv4,@pRAUServerName,@pRAUStartTime);
	
	SELECT @pRAUKey = SCOPE_IDENTITY();									

End

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_ReportAudit_ReportStart]
	TO [V6N14816rwZf]
GO
