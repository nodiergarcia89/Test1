SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileDemandLineComment] (
		[PDC_Key]               [int] IDENTITY(1, 1) NOT NULL,
		[PDL_Key]               [int] NOT NULL,
		[PDC_PlainText]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PDC_FormattedText]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PDC_LastEditDate]      [float] NOT NULL,
		CONSTRAINT [PK__ProfileD__47ADBCFC76818E95]
		PRIMARY KEY
		CLUSTERED
		([PDC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileDemandLineComment]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__PDL_K__3434A84B]
	FOREIGN KEY ([PDL_Key]) REFERENCES [dbo].[ProfileDemandLine] ([PDL_Key])
ALTER TABLE [dbo].[ProfileDemandLineComment]
	CHECK CONSTRAINT [FK__ProfileDe__PDL_K__3434A84B]

GO
CREATE NONCLUSTERED INDEX [PDC_DemandLineIndex]
	ON [dbo].[ProfileDemandLineComment] ([PDL_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProfileDemandLineComment] SET (LOCK_ESCALATION = TABLE)
GO
