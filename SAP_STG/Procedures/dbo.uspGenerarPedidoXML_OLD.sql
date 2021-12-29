SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =======================================================================================================================
-- Author:	 Ramon Villanueva
-- Create date: 02/05/2020
-- Description: Generar Pedido XML
--	   Tipos de Pedido:
--        - Desde Tablet: ZPB1
--        - Desde B2B...: ZPB2
--   Para recodificar el fichero de salida y que no le de problemas a SAP:
--  Get-Content '\\SAPDEV\PedidosIN$\2-ipad18-2.xml' | Set-Content -Encoding Unicode '\\SAPDEV\PedidosIN$\Prueba.xml'
-- EXEC xp_cmdshell 'powershell -Command D:\Temp\StopSDOpsService.ps1 MyServerName'
-- =======================================================================================================================
CREATE PROCEDURE [dbo].[uspGenerarPedidoXML_OLD](
			 @codEmpresa INT         =2
		    , @nomIPad    NVARCHAR(50)='web'
		    , @codPedido  INT         =33
		    , @Salida     INT         =0 -- 0=Normal, 1=Pantalla
		    , @Tipo       INT         =0 -- 0=Producción. 1=Desarrollo
)
AS
    BEGIN
	   
	   SET LANGUAGE SPANISH

	   -- Declarar variables
	   DECLARE 
		   @Contenido AS        NVARCHAR(MAX)
		 , @Folder AS           NVARCHAR(MAX)
		 , @FileName AS         NVARCHAR(MAX)
		 , @FileNameUTF AS      NVARCHAR(MAX)
		 , @Referencia AS       NVARCHAR(MAX)
		 , @Comando AS          VARCHAR(255)
		 , @CentroSuministro AS NVARCHAR(4)
		 , @OrgVentas AS        NVARCHAR(4)
		 , @FechaIDOC AS        NVARCHAR(8)
		 , @HoraIDOC AS         NVARCHAR(8)
		 , @Almacen AS          NVARCHAR(4)
		 , @ClaseDocumento AS   NVARCHAR(4)
		 , @Servidor AS         NVARCHAR(10)
		 , @Mandante AS         NVARCHAR(3)
		 , @CabeceraXML AS      NVARCHAR(100)
		 , @XML AS              XML

	   -- Inicializar variables
	   IF @Tipo = 1
		  BEGIN
			 SELECT @Servidor='SAPDEV'
			 SELECT @Mandante='200'
	   END
		  ELSE
		  BEGIN
			 SELECT @Servidor='SAPPROD'
			 SELECT @Mandante='100'
	   END

	   SELECT @CentroSuministro='0200'
	   SELECT @Almacen='0001'
	   SELECT @OrgVentas='0200'
	   SELECT @FechaIDOC=FORMAT(GETDATE(), 'yyyyMMdd')
	   SELECT @HoraIDOC=FORMAT(GETDATE(), 'HHmmss')
	   SELECT @Folder=CONCAT('\\', @Servidor, '\PedidosIN$')
	   SELECT @CabeceraXML='<?xml version="1.0" encoding="UTF-8"?>'
             --@CabeceraXML='<?xml version="1.0" encoding="ISO-8859-1"?>'
			
	   -- Fichero de destino
	   SELECT	@Referencia=CONCAT(@nomIPad, '-', @codPedido)
	   SELECT	@FileName=CONCAT(@Folder, '\', @codEmpresa, '-', @Referencia, '.xml')
	   SELECT	@FileNameUTF=CONCAT(@Folder, '\', @codEmpresa, '-', @Referencia, '.utf')
	   
	   -- XML de Salida
	   SELECT @Contenido=
	   (
		  SELECT    
		  -- Datos Cabecera
			    'Cabecera del IDOC' AS                                                                      "comment()"
			  , 'EDI_DC40' AS                                                                               [EDI_DC40/TABNAM]
			  , @Mandante AS                                                                                [EDI_DC40/MANDT]
			  , @Referencia AS                                                                              [EDI_DC40/DOCNUM]
			  , '701' AS                                                                                    [EDI_DC40/DOCREL]
			  , '1' AS                                                                                      [EDI_DC40/DIRECT]
			  , '2' AS                                                                                      [EDI_DC40/OUTMOD]
			  , 'ORDERS05' AS                                                                               [EDI_DC40/IDOCTYP]
			  , 'ORDERS' AS                                                                                 [EDI_DC40/MESTYP]
			  , 'PEDB2X' AS                                                                                 [EDI_DC40/SNDPOR]
			  , 'KU' AS                                                                                     [EDI_DC40/SNDPRT]
			  , 'AG' AS                                                                                     [EDI_DC40/SNDPFC]
			  , RIGHT(CONCAT('0000000000', t1.codCliente), 10) AS                                           [EDI_DC40/SNDPRN]
			  , 'PEDB2X' AS                                                                                 [EDI_DC40/RCVPOR]
			  , 'LS' AS                                                                                     [EDI_DC40/RCVPRT]
			  , 'CLI200' AS                                                                                 [EDI_DC40/RCVPRN]
			  , @FechaIDOC AS                                                                               [EDI_DC40/CREDAT]
			  , @HoraIDOC AS                                                                                [EDI_DC40/CRETIM]
			  , '000' AS                                                                                    [E1EDK01/ACTION]
			  , 'EUR' AS                                                                                    [E1EDK01/CURCY]
			  , 1.00000 AS                                                                                  [E1EDK01/WKURS]
			    -- ZPB1 si viene de tablet, ZPB2 si viene de web
			  , IIF(t1.codOrigenVenta = '0', 'ZPB1', 'ZPB2') AS                                             [E1EDK01/BSART]
			  , 'Division' AS                                                                               "comment()"
			  , '006' AS                                                                                    [E1EDK14/QUALF]
			  , '01' AS                                                                                     [E1EDK14/ORGID]
			  , 'Canal de Ventas' AS                                                                        "comment()"
			  , '007' AS                                                                                    [E1EDK14_1/QUALF]
			  , '01' AS                                                                                     [E1EDK14_1/ORGID]
			  , 'Organizacion de Ventas' AS                                                                 "comment()"
			  , '008' AS                                                                                    [E1EDK14_2/QUALF]
			  , @OrgVentas AS                                                                               [E1EDK14_2/ORGID]
			  , 'Tipo de Pedido' AS                                                                         "comment()"
			  , '012' AS                                                                                    [E1EDK14_3/QUALF]
			    -- ZPB1 si viene de tablet, ZPB2 si viene de web
			  , IIF(t1.codOrigenVenta = '0', 'ZPB1', 'ZPB2') AS                                             [E1EDK14_3/ORGID]
			  --, 'Centro' AS                                                                                 "comment()"
			  --, '016' AS                                                                                    [E1EDK14_4/QUALF]
			  --, '0201' AS                                                                                   [E1EDK14_4/ORGID]
			    -- Fecha del IDOC
			  , 'Fecha del IDOC' AS                                                                         "comment()"
			  , '011' AS                                                                                    [E1EDK03/IDDAT]
			  , @FechaIDOC AS                                                                               [E1EDK03/DATUM]
			  , @HoraIDOC AS                                                                                [E1EDK03/UZEIT]
			    -- Fecha del Pedido
			  , 'Fecha del Pedido' AS                                                                       "comment()"
			  , '012' AS                                                                                    [E1EDK03_1/IDDAT]
			  , FORMAT(t1.fecPedido, 'yyyyMMdd') AS                                                         [E1EDK03_1/DATUM]
			  , FORMAT(t1.fecPedido, 'HHmmss') AS                                                           [E1EDK03_1/UZEIT]
			    -- Solicitante
			  , 'Solicitante' AS                                                                            "comment()"
			  , 'AG' AS                                                                                     [E1EDKA1/PARVW]
			  , RIGHT(CONCAT('0000000000', t1.codCliente), 10) AS                                           [E1EDKA1/PARTN]
			  , @OrgVentas AS                                                                               [E1EDKA1/PAORG]
			    -- Destinatario de Mercancia
			  , 'Destinatario de Mercancia' AS                                                              "comment()"
			  , 'WE' AS                                                                                     [E1EDKA1_1/PARVW]
			  --, RIGHT(CONCAT('0000000000', t1.codCliente), 10) AS                                         [E1EDKA1_1/PARTN] --09/10/2020
			  , t1a.codSuDirCli AS														      [E1EDKA1_1/PARTN] --09/10/2020
			  , (t1a.nomDirCli) AS                                                                          [E1EDKA1_1/NAME1]
			  , (t1a.datCalleDirCli) AS                                                                     [E1EDKA1_1/STRAS]
			  , (t1a.datPoblacionDirCli) AS                                                                 [E1EDKA1_1/ORT01]
			  , t1a.codPostalDirCli AS                                                                      [E1EDKA1_1/PSTLZ]
			  , t1a.datPaisDirCli AS                                                                        [E1EDKA1_1/LAND1]
			  , IIF(t1a.datTelefonoDirCli = '', 'N/A', t1a.datTelefonoDirCli) AS                            [E1EDKA1_1/TELF1]
			  , t1a.datFaxDirCli AS                                                                         [E1EDKA1_1/TELFX]
			  , 'S' AS                                                                                      [E1EDKA1_1/SPRAS]
			  , LEFT(t1a.codPostalDirCli, 2) AS                                                             [E1EDKA1_1/REGIO]
			  , 'ES' AS                                                                                     [E1EDKA1_1/SPRAS_ISO]
			  , '001' AS                                                                                    [E1EDK02/QUALF]
			  , IIF(t1.Custom2<>'',t1.Custom2,@Referencia) AS                                               [E1EDK02/BELNR]
			  , FORMAT(t1.fecPedido, 'yyyyMMdd') AS                                                         [E1EDK02/DATUM]
			  , @HoraIDOC AS                                                                                [E1EDK02/UZEIT]
			  -- Observaciones del pedido
			  , 'Observaciones del Pedido' AS                                                               "comment()"
			  , 'ZALB' AS																	 [E1EDKT1C/TDID]
			  , 'ES' AS																	 [E1EDKT1C/TSSPRAS]
			  , 'S' AS																	 [E1EDKT1C/TSSPRAS_ISO]
			  , 'VBBK' AS																	 [E1EDKT1C/TDOBJECT]
			  , '' AS																		 [E1EDKT1C/TDOBNAME]
	   --, t1.linDirCli
	   --, t1.codAgente
	   --, t1.codFormaPago
	   --, t1.tpcDto01
	   --, t1.tpcDto02
	   --, t1.tpcDtoPp
	   --, t1.tpcDto03
	   --, t1.codMoneda
	   --, t1.codIncoterm
	   --, t1.totBrutoPed
	   --, t1.totDto1Ped
	   --, t1.totDto2Ped
	   --, t1.totDto3Ped
	   --, t1.totNetoPed
	   --, t1.totDtoPPPed
	   --, t1.totBaseImponiblePed
	   --, t1.totIVAPed
	   --, t1.totREPed
	   --, t1.totPed
	   --, t1.datFechaEntrega
	   --, t1.flaExpPedido
	   --, t1.datEstadoPedido
	   --, t1.flaIVAIncluido
	   --, t1.codTipoVenta
	   --, t1.codOrigenVenta
	   --, t1.totPuntosPedido
	   --, t1.codFactorPuntos
	   --, t1.datFactorPuntos
	   --, t1.totPuntosTotales
	   --, t1.totPuntosConsumidos
	   --, t1.flaRecibidoMS
	   --, t1.Custom1
	   --, t1.Custom2
	   --, t1.Custom3
		       , CAST(LinObs AS XML)
			  , CAST(Lin AS XML)
		  FROM           sym_iPedidos AS t1
					  INNER JOIN sym_iClientesLDir AS t1a
					    ON t1.CodEmpresa = t1a.CodEmpresa
						  AND t1.codCliente = t1a.CodCliente
						  AND t1.linDirCli = t1a.linDirCli
	  -- Observaciones de cabecera. Multiples lineas de 70 caracteres maximo
	  OUTER APPLY
		  (
	   		 SELECT 
			  -- Lineas de texto. 
				 ot2.Line												   [E1EDKT2/TDLINE]
				 , '*'   	                                            			   [E1EDKT2/TDFORMAT]
				FROM sym_iPedidos ot1
				CROSS APPLY dbo.udfSplitLines(aux.RemoveNonDisplayChars(ot1.obsPedido),70,' ') ot2
				WHERE  t1.CodEmpresa = ot1.codEmpresa
					  AND t1.nomIPad = ot1.nomIPad
					  AND t1.codPedido = ot1.codPedido 
			 FOR XML PATH('') , ROOT('E1EDKT1L')
		  ) AS XmlObs(LinObs)
	  
	  -- Lineas de Pedido
	  OUTER APPLY
		  (
			 SELECT 
				   'Datos de Posicion' AS                                          "comment()"
				 , RIGHT(CONCAT('00000', t2.linPedido), 5) AS                      POSEX
				 , '001' AS                                                        ACTION
				 , 0 AS                                                            PSTYP
				 , t2.canLinPed AS                                                 MENGE
				 , CASE -- Unidad de medida ISO
					    (CASE t2.codMagnitud
						  WHEN 'U' THEN UVenta_U
						  WHEN 'C' THEN UVenta_C
						  WHEN 'P' THEN UVenta_P
						 END) COLLATE DATABASE_DEFAULT
					  WHEN 'ST' THEN 'PCE' 
					  WHEN 'KG' THEN 'KGM' 
					  WHEN 'CS' THEN 'CS'  
					  WHEN 'PAL' THEN 'PF'
					  ELSE 'CR' -- 06/10/2020
				   END AS                                                          PMENE
				 , t2.preLinPed AS                                                 VPREI
				 , t2.impNetoLinPed AS                                             NETWR
				 , @CentroSuministro AS                                            WERKS
				 , @Almacen AS                                                     LGORT
				 , 'Datos del Material' AS                                         "comment()"
				 , '002' AS                                                        [E1EDP19/QUALF]
				 , RIGHT(CONCAT('000000000000000000', t2.codArticulo), 18) AS      [E1EDP19/IDTNR]
				 , t2.desLinPed AS                                                 [E1EDP19/KTEXT] 
				 
			 -- , t2.linMadre
			 -- , t2.sliPedido
			 -- , t2.tpcDto01
			 -- , t2.tpcDto02
			 -- , t2.codTarifa
			 -- , t2.preLinPedSinIVA
			 -- , t2.codOrigenPrecio
			 -- , t2.obsLinPed
			 -- , t2.obsLinPed2
			 -- , t2.obsLinPed3
			 -- , t2.impBrutoLinPed
			 -- , t2.impDto1LinPed
			 -- , t2.impDto2LinPed
			 -- , t2.impDto3LinPed
			 -- , t2.impDtoPPLinPed
			 -- , t2.impBaseImponibleLinPed
			 -- , t2.tpcIva
			 -- , t2.tpcRe
			 -- , t2.valConjunto
			 -- , t2.canIndicada
			 -- , t2.codCatalogo
			 -- , t2.codFamilia
			 -- , t2.codSubFamilia
			 -- , t2.codPlantillaComercialLP
			 -- , t2.codPlantillaComercialVolumen
			 -- , t2.tipDto01Accion
			 -- , t2.tpcModifDto01
			 -- , t2.tipDto02Accion
			 -- , t2.tpcModifDto02
			 -- , t2.canLinPedOri
			 -- , t2.preLinPedOri
			 -- , t2.tpcDto01Ori
			 -- , t2.tpcDto02Ori
			 -- , t2.flaOfertaAlterada
			 -- , t2.codPlantillaComercialLM
			 -- , t2.codTipoArticulo
			 -- , t2.codGrupoPreciosArticulo
			 -- , t2.codModeloTyC
			 -- , t2.Puntos
			 FROM   sym_iPedidosLin AS t2
			 LEFT JOIN vConversionUM AS t3
				ON t2.CodEmpresa=t3.CodEmpresa
				    AND t2.codArticulo=t3.codArticulo
			 WHERE  t1.CodEmpresa = t2.codEmpresa
				   AND t1.nomIPad = t2.nomIPad
				   AND t1.codPedido = t2.codPedido 
		FOR XML PATH('E1EDP01')
		  ) AS XmlDetails(Lin)
		  WHERE t1.codEmpresa = @codEmpresa
			   AND t1.nomipad = @nomipad
			   AND t1.codPedido = @codPedido
	   FOR
	   XML PATH('IDOC'), ROOT('ORDERS05')
	   )

	   -- Reemplazo secciones "multiples" 
	   SELECT 
			@Contenido=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
					   REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
					   REPLACE(REPLACE(
					   dbo.RepetitiveReplace(@Contenido,'%[_][0-9]%','',2)
			 , '<IDOC>', '<IDOC BEGIN="1">')
			 , '<EDI_DC40>', '<EDI_DC40 SEGMENT="1">')
			 , '<E1EDK01>', '<E1EDK01 SEGMENT="1">')
			 , '<E1EDK14>', '<E1EDK14 SEGMENT="1">')
			 , '<E1EDK02>', '<E1EDK02 SEGMENT="1">')
			 , '<E1EDK03>', '<E1EDK03 SEGMENT="1">')
			 , '<E1EDKA1>', '<E1EDKA1 SEGMENT="1">')
			 , '<E1EDP01>', '<E1EDP01 SEGMENT="1">')
			 , '<E1EDP19>', '<E1EDP19 SEGMENT="1">')
			 , '<E1EDKT1C>', '<E1EDKT1 SEGMENT="1">')
			 , '<E1EDKT2>', '<E1EDKT2 SEGMENT="1">')
			 , '</E1EDKT1C>', '')
			 , '<E1EDKT1L>', '')
			 , '</E1EDKT1L>', '</E1EDKT1>')

	   IF @Salida = 0
	   -- Salida a Fichero
		  BEGIN
			 SELECT @Contenido=CONCAT(@CabeceraXML, @Contenido)
			 EXEC aux.writeFile 
				 @fileName=@FileNameUTF, 
				 @fileContents=@Contenido
       		 
			 -- Recodificar fichero para que se vean los caracteres especiales
			 DECLARE @result TABLE (Line NVARCHAR(512))
			 SELECT @Comando=CONCAT('powershell "Get-Content ''',@FileNameUTF,''' | Set-Content -Encoding UTF8 ''', @FileName, '''"')
			 INSERT INTO @result
				EXEC xp_cmdshell @Comando
			 
			 -- Borrar fichero sin convertir
			 SELECT @Comando=CONCAT('DEL ',@FileNameUTF)
			 INSERT INTO @result
	   			EXEC xp_cmdshell @Comando
			 
			 -- Cambio del estado del pedido 
			   UPDATE sym_iPedidos
			 	    SET flaExpPedido=1
			   WHERE codEmpresa=@codEmpresa
			 	    AND nomIPad=@nomIPad
			 	    AND codPedido=@codPedido

			 -- Tracking del Pedido
			 IF EXISTS (SELECT codPedido 
					   FROM sym_iTrackingPedidos 
						  WHERE codEmpresa=@codEmpresa
						     AND nomIPad=@nomIPad
							AND codPedido=@codPedido)
				UPDATE sym_iTrackingPedidos 
				    SET estadoTracking=2
	   			  WHERE codEmpresa=@codEmpresa
				     AND nomIPad=@nomIPad
					AND codPedido=@codPedido
			 ELSE
				INSERT INTO sym_iTrackingPedidos



			 -- Notificar Pedido
			 EXEC uspNotificarPedido  @codEmpresa, @nomIPad, @codPedido
		  END
		  ELSE
			 BEGIN
				SELECT @XML=@Contenido
				SELECT @XML
			 END
    END
GO
