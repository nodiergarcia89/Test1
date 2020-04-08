SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ABSFilterDetails] (
		[AF_Key]        [int] NOT NULL,
		[AD_Key]        [int] NOT NULL,
		[AD_Type]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_Text]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_Number]     [float] NULL,
		CONSTRAINT [PK__ABSFilte__6437887E07F6335A]
		PRIMARY KEY
		CLUSTERED
		([AF_Key], [AD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ABSFilterDetails]
	WITH CHECK
	ADD CONSTRAINT [FK__ABSFilter__AF_Ke__133DC8D4]
	FOREIGN KEY ([AF_Key]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[ABSFilterDetails]
	CHECK CONSTRAINT [FK__ABSFilter__AF_Ke__133DC8D4]

GO
ALTER TABLE [dbo].[ABSFilterDetails] SET (LOCK_ESCALATION = TABLE)
GO
