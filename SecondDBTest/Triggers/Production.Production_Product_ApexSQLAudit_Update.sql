CREATE TRIGGER [Production].[Production_Product_ApexSQLAudit_Update]
	ON [Production].[Product]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.Production.Product.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
