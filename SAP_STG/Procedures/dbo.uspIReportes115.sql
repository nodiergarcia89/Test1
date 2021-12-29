SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 21/12/2018
-- Description: Para controlar la insercion de registros
-- Visita Planificado
-- =============================================
CREATE PROCEDURE [dbo].[uspIReportes115]
( @codEmpresa AS int=2
 ,@codReporte as int=772
 ,@nomIPad as nvarchar(50)='ipad836')
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @html nvarchar(MAX)
    DECLARE @Titulo varchar(MAX)
    DECLARE @Observaciones varchar(MAX)
    DECLARE @Observaciones1 varchar(MAX)
    DECLARE @Consulta varchar(MAX)
    declare @recipients varchar(MAX)
    declare @subject varchar(MAX)
    DECLARE @CodAgente nvarchar(20)

	
    -- Inicializar variables
    SELECT @Titulo='Visita Planificada' 
    select @Observaciones='Este proceso se ejecuta con un trigger al insertar un registro en iReportes con codigo de plantilla 115.'
    select @recipients='Ramon.Villanueva@unitos.com;'
    select @subject='Reportes Inacatalog. Visita Concertada'

    SELECT @Consulta='select desCampo Pregunta, datRespuesta Respuesta from INASAM.dbo.iReportesLin WHERE CodEmpresa=' 
	   + convert(nvarchar,@codEmpresa) + ' and nomIPad=''' + rtrim(ltrim(@nomIPad)) + ''' and linReportesLin<>99 and codReporte=' + CONVERT(NVARCHAR,@codReporte)

    EXEC dbo.spQueryToHtmlTable2 @html = @html OUTPUT
	   ,@query = @Consulta

    SELECT @Observaciones1 = 'Terminal: ' + @nomIPad 

    -- Enviar email
    EXEC [uspNotificarEmail]
		  @recipients=@recipients,
		  @subject=@subject,
		  @body=@html,
		  @LogoEmp=2,
		  @Titulo=@Titulo,
		  @Observaciones=@Observaciones,
		  @Observaciones1=@Observaciones1;

END

GO
