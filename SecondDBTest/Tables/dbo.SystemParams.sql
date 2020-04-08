SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemParams] (
		[SP_Code]       [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SP_Index]      [int] NOT NULL,
		[SP_Value]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SP_Number]     [float] NULL,
		CONSTRAINT [PK__SystemPa__C680FE5104308F6E]
		PRIMARY KEY
		CLUSTERED
		([SP_Code], [SP_Index])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SystemParams] SET (LOCK_ESCALATION = TABLE)
GO
