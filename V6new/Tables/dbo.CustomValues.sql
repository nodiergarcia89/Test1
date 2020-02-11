SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomValues] (
		[CV_Value]        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_Key]          [int] NULL,
		[CV_Order]        [int] NULL,
		[CV_NumValue]     [float] NULL,
		[CV_Colour]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CV_Key]          [int] IDENTITY(1, 1) NOT NULL,
		CONSTRAINT [PK__CustomVa__A859DA0012C8C788]
		PRIMARY KEY
		CLUSTERED
		([CV_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomValues]
	WITH CHECK
	ADD CONSTRAINT [FK__CustomVal__CF_Ke__261B931E]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[CustomValues]
	CHECK CONSTRAINT [FK__CustomVal__CF_Ke__261B931E]

GO
ALTER TABLE [dbo].[CustomValues] SET (LOCK_ESCALATION = TABLE)
GO
