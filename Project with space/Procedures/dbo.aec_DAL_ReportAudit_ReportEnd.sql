SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [aec_DAL_ReportAudit_ReportEnd](
	@pRAUKey int,
	@pRHKey int = NULL,
	@pRHName  nvarchar(70) = NULL, 
	@pUSCode nvarchar(20) = NULL,	
	@pRAUSourceIPAddress nvarchar(70) = NULL, 
	@pRAUSourceIPAddressV4 nvarchar(70) = NULL, 
	@pRAUServerName nvarchar(150) = NULL,
	@pRAUStartTime float = NULL,	
	@pRAUEndTime float = NULL,
	@pRAURowCount int = NULL)
AS
BEGIN	

    -- Insert statements for procedure here
	IF @pRAUKey > 0 
		BEGIN
			UPDATE ReportAudit 
			SET RAU_EndTime = @pRAUEndTime, RAU_RowCount = @pRAURowCount

			WHERE RAU_Key = @pRAUKey;			
		END	

END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_ReportAudit_ReportEnd]
	TO [V6N14816rwZf]
GO
