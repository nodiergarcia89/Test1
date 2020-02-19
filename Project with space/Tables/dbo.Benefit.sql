SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Benefit] (
		[BE_Key]       [int] IDENTITY(1, 1) NOT NULL,
		[BE_Name]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BET_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Benefit__956DB0BE0D7A0286]
		PRIMARY KEY
		CLUSTERED
		([BE_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Benefit]
	WITH CHECK
	ADD CONSTRAINT [FK__Benefit__BET_Cod__42ECDBF6]
	FOREIGN KEY ([BET_Code]) REFERENCES [dbo].[BenefitType] ([BET_Code])
ALTER TABLE [dbo].[Benefit]
	CHECK CONSTRAINT [FK__Benefit__BET_Cod__42ECDBF6]

GO
ALTER TABLE [dbo].[Benefit] SET (LOCK_ESCALATION = TABLE)
GO
