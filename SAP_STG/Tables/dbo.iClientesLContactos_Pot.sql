SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[iClientesLContactos_Pot] (
		[IdRegistro]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEmpresa]                [int] NOT NULL,
		[codCliente]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[linContactCli]             [int] NOT NULL,
		[nomContactCli]             [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datPuestoContactCli]       [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datTelefonoContactCli]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datEmailContactCli]        [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom1ContactCli]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom2ContactCli]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom3ContactCli]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaNvoContactCli]          [int] NOT NULL,
		[FechaAlta]                 [datetime] NOT NULL,
		[Estado]                    [tinyint] NULL,
		CONSTRAINT [PK_iClientesLContactos_Pot]
		PRIMARY KEY
		CLUSTERED
		([IdRegistro])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170217-084819]
	ON [dbo].[iClientesLContactos_Pot] ([codEmpresa], [codCliente], [linContactCli])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[iClientesLContactos_Pot] SET (LOCK_ESCALATION = TABLE)
GO
