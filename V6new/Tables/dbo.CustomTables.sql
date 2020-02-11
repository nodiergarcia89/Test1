SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CustomTables] (
		[CT_Table]     [int] NOT NULL,
		[CT_STxt]      [int] NULL,
		[CT_Txt]       [int] NULL,
		[CT_Num]       [int] NULL,
		CONSTRAINT [PK__CustomTa__795A54D40EF836A4]
		PRIMARY KEY
		CLUSTERED
		([CT_Table])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomTables] SET (LOCK_ESCALATION = TABLE)
GO
