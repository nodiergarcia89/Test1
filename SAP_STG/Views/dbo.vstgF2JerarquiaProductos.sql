SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


/* Vista de seleccion de las jerarquias de producto SAP
 Fase 1
 Ramon Villanueva
 Fecha: 30/05/11*/
CREATE VIEW [dbo].[vstgF2JerarquiaProductos] AS
SELECT     CONVERT(int, SUBSTRING(t1.PRODH, 1, 2)) AS CodNivel1,
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      (PRODH = SUBSTRING(t1.PRODH, 1, 2))) AS Nivel1, CONVERT(int, SUBSTRING(t1.PRODH, 3, 2)) AS CodNivel2, CASE substring(t1.PRODH, 3, 2) 
                      WHEN '' THEN
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      (PRODH = SUBSTRING(t1.PRODH, 1, 2))) ELSE
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      PRODH = substring(t1.PRODH, 1, 4)) END AS Nivel2, CONVERT(int, SUBSTRING(t1.PRODH, 5, 2)) AS CodNivel3, CASE substring(t1.PRODH, 5, 2) 
                      WHEN '' THEN (CASE substring(t1.PRODH, 3, 2) WHEN '' THEN
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      (PRODH = SUBSTRING(t1.PRODH, 1, 2))) ELSE
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      PRODH = substring(t1.PRODH, 1, 4)) END) ELSE
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      PRODH = substring(t1.PRODH, 1, 6)) END AS Nivel3, CONVERT(int, SUBSTRING(t1.PRODH, 7, 2)) AS CodNivel4, CASE substring(t1.PRODH, 7, 2) 
                      WHEN '' THEN (CASE substring(t1.PRODH, 5, 2) WHEN '' THEN (CASE substring(t1.PRODH, 3, 2) WHEN '' THEN
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      (PRODH = SUBSTRING(t1.PRODH, 1, 2))) ELSE
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      PRODH = substring(t1.PRODH, 1, 4)) END) ELSE
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      PRODH = substring(t1.PRODH, 1, 6)) END) ELSE
                          (SELECT     VTEXT
                            FROM          dbo.T179T
                            WHERE      PRODH = substring(t1.PRODH, 1, 8)) END AS Nivel4, t1.PRODH AS JerarquiaSAP
FROM         dbo.T179T AS t2 INNER JOIN
                      dbo.T179 AS t1 ON t2.MANDT = t1.MANDT AND t2.PRODH = t1.PRODH


GO
