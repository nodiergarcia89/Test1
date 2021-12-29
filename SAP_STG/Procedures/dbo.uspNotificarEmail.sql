SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ==============================================================
-- Author:		Ramon Villanueva
-- Create date:	18/04/2018
-- Description:	Evial email formateado
-- ===============================================================
CREATE PROCEDURE [dbo].[uspNotificarEmail] 
(
   @recipients nvarchar(MAX)='Ramon.villanueva@unitos.com;',
   @copy_recipients  nvarchar(MAX)=null,
   @blind_copy_recipients nvarchar(MAX)=null,
   @subject nvarchar(MAX)='Prueba de Asunto',
   @body nvarchar(max)='.', -- Aqui vendrá la consulta en modo tabla
   @LogoEmp int=1,
   @Columnas int=1,
   @Titulo nvarchar(MAX)='Titulo del email',
   @Observaciones nvarchar(MAX)='Descripción del proceso.<br>Explicar aqui cuando apoarece este email',
   @Observaciones1 nvarchar(MAX)='Nivel 1 de las observaciones',
   @Observaciones2 nvarchar(MAX)=null,
   @file_attachments nvarchar(MAX)=null
) AS
BEGIN
    DECLARE @html nvarchar(MAX)
    DECLARE @Columna2 nvarchar(MAX)
    declare @ColorTitulo nvarchar(MAX)
    declare @ColorPie nvarchar(MAX)
    declare @Logo nvarchar(MAX)
    declare @Pie nvarchar(MAX)


    select @Pie='&copy; Departamento de Sistemas, ' + Format(datepart(year,getdate()),'#,###.##', 'es-ES')
		  + ' (' + format(getdate(), 'dd/MM/yyyy HH:mm:ss') + ')'


    -- Seleccionar codigos de color en https://html-color-codes.info/
    -- Codificar imagenes https://www.motobit.com/util/base64-decoder-encoder.asp

    --select @ColorTitulo='#045FB4'
    --Select @ColorPie='#045FB4'
    if @LogoEmp=2
	   begin
		  select @ColorTitulo='#C22923'
		  Select @ColorPie='#C22923'
	   end
    else
	   begin
		  select @ColorTitulo='#D62828'
		  Select @ColorPie='#D62828'
	   end	   
    
    -- Seleccion del Logo
    if @LogoEmp=1
	  select @Logo='LogoUCC.jpg'
    else
	  select @Logo='LogoTemplo.jpg'
    select @file_attachments = 'C:\SYSTEM\' + @Logo + IIF(COALESCE(@file_attachments,'')='','',';'+@file_attachments)
    
    if @Columnas=2
	   select @Columna2='<td style="font-size: 0; line-height: 0;" width="20">
						 &nbsp;
			 		   </td>
					    <td width="260" valign="top">
					    <table border="0" cellpadding="0" cellspacing="0" width="100%">
							 <tr>
								<td>
								    <img src="images/right.gif" alt="" width="100%" height="140" style="display: block;" />
								</td>
							 </tr>
							 <tr>
								<td style="padding: 25px 0 0 0; color: #153643; font-family: verdana, sans-serif; font-size: 16px; line-height: 20px;">
								    ' + @Observaciones2 + '
								</td>
							 </tr>
						  </table>
				    </td>
				    '
    else 
	   select @Columna2=''


select @html='
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin: 0; padding: 0;">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">	
		<tr>
			<td style="padding: 0 0 0 0;">
				<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border: 1px solid #cccccc; border-collapse: collapse;">
					<tr>
						<td align="center" bgcolor="' + @ColorTitulo +'" style="padding: 5px 0 5px 0; color: #153643; font-size: 28px; font-weight: bold; font-family: verdana, sans-serif;">
							<img src="cid:' + @Logo + '" style="display: block;" />
						</td>
					</tr>
					<tr>
						<td bgcolor="#ffffff" style="padding: 40px 30px 40px 30px;">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td style="color: #153643; font-family: verdana, sans-serif; font-size: 22px;">
										<b>' + @Titulo + '</b>
									</td>
								</tr>
								<tr>
									<td style="padding: 20px 0 30px 0; color: #153643; font-family: verdana, sans-serif; font-size: 16px; line-height: 20px;">
										' + @Observaciones + '
									</td>
								</tr>
								<tr>
									<td>
										<table border="0" cellpadding="0" cellspacing="0" width="100%">
											<tr>
												<td width="260" valign="top">
													<table border="0" cellpadding="0" cellspacing="0" width="100%">
    													' + @body + '
														<tr>
															<td style="padding: 25px 0 0 0; color: #153643; font-family: verdana, sans-serif; font-size: 12px; font-style:italic; line-height: 20px;">
																' + '<br>' + @Observaciones1 + '
															</td>
														</tr>
													</table>
												</td>
												' + @Columna2 + '
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td bgcolor="' + @ColorPie + '" style="padding: 10px 10px 10px 10px;">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td style="color: #ffffff; font-family: verdana; font-size: 10px; font-weight:bold;" width="75%">
										'+ @Pie + '<br/>
									</td>
									<td align="right" width="25%">
										<table border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td style="font-family: verdana, sans-serif; font-size: 12px; font-weight: bold;">
												</td>
												<td style="font-size: 0; line-height: 0;" width="20">&nbsp;</td>
												<td style="font-family: verdana, sans-serif; font-size: 12px; font-weight: bold;">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
'
		  -- Enviar email
		  EXEC msdb.dbo.sp_send_dbmail
			    @profile_name='SQLMail',
			    @recipients=@recipients,
			    @copy_recipients=@copy_recipients,
			    @blind_copy_recipients=@blind_copy_recipients,
			    @subject=@subject,
			    @body=@html,
			    @body_format='HTML',
			    @query_no_truncate=1,
			    @from_address='noreply@cafestemplo.es',
			    @reply_to='noreply@cafestemplo.es',
			    @attach_query_result_as_file=0,
			    @file_attachments = @file_attachments;

END
GO
