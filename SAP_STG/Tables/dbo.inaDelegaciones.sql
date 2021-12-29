SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaDelegaciones] (
		[CodDelegacion]      [int] NOT NULL,
		[Delegacion]         [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Ina]                [bit] NOT NULL,
		[CodDelegado]        [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodAreaManager]     [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodArea]            [tinyint] NULL,
		[Area]               [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VKBUR]              [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_inaDelegaciones]
		PRIMARY KEY
		CLUSTERED
		([CodDelegacion])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaDelegaciones]
	ADD
	CONSTRAINT [DF_inaDelegaciones_Ina]
	DEFAULT ((0)) FOR [Ina]
GO
ALTER TABLE [dbo].[inaDelegaciones] SET (LOCK_ESCALATION = TABLE)
GO
