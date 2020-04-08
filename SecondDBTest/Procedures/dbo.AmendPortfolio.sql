SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



Create Procedure AmendPortfolio
	@PortfolioKey float,
	@PortfolioName nvarchar(70),
	@PortfolioDesc nvarchar(250),	
	@DepartmentCode nvarchar(20),
	@UsCode	nvarchar(20)		
AS

	IF EXISTS (	select	1 
				from	Portfolio 
				where	PFL_Key = @PortfolioKey)
		BEGIN
			--Update
			update Portfolio
			set PFL_Name = @PortfolioName,
				PFL_Description = @PortfolioDesc,
				DE_Code = @DepartmentCode
			where PFL_Key = @PortfolioKey;				
						
		END;
	ELSE
		BEGIN
			Return;
		END;
	
GO
GRANT EXECUTE
	ON [dbo].[AmendPortfolio]
	TO [V6N14816rwZf]
GO
