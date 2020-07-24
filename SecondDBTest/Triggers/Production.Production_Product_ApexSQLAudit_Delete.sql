CREATE TRIGGER [Production].[Production_Product_ApexSQLAudit_Delete]
	ON [Production].[Product]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.Production.Product.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
