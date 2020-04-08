SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW reports.viewtest3
AS
SELECT        dbo.ActionDocuments.AN_Key, dbo.ActionDocuments.DH_Key, dbo.ActionAttachments.AN_Key AS Expr1, dbo.ActionAttachments.AA_PathName, dbo.ABSCurrency.CU_Code, dbo.ABSCurrency.CU_Desc, 
                         dbo.ABSCurrency.CU_Symbol, dbo.ABSCurrency.System_Currency, dbo.ABSCurrency.Active, dbo.ABSCurrency.CU_LastEdit, dbo.ABSCurrency.US_Code, dbo.ABSCurrency.CU_LastEditDate
FROM            dbo.ActionDocuments INNER JOIN
                         dbo.ActionAttachments ON dbo.ActionDocuments.AN_Key = dbo.ActionAttachments.AN_Key CROSS JOIN
                         dbo.ABSCurrency
GO
