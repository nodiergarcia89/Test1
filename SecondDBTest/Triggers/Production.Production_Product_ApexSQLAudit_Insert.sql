CREATE TRIGGER [Production].[Production_Product_ApexSQLAudit_Insert]
	ON [Production].[Product]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.Production.Product.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
