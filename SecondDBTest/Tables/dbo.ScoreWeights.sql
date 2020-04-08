SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ScoreWeights] (
		[SCW_Key]        [int] IDENTITY(1, 1) NOT NULL,
		[PFL_Key]        [int] NOT NULL,
		[CF_Key]         [int] NOT NULL,
		[SCW_Weight]     [float] NULL,
		CONSTRAINT [PK__ScoreWei__8967C00796805AFA]
		PRIMARY KEY
		CLUSTERED
		([SCW_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ScoreWeights]
	WITH CHECK
	ADD CONSTRAINT [FK__ScoreWeig__PFL_K__463E49ED]
	FOREIGN KEY ([PFL_Key]) REFERENCES [dbo].[Portfolio] ([PFL_Key])
ALTER TABLE [dbo].[ScoreWeights]
	CHECK CONSTRAINT [FK__ScoreWeig__PFL_K__463E49ED]

GO
ALTER TABLE [dbo].[ScoreWeights]
	WITH CHECK
	ADD CONSTRAINT [FK__ScoreWeig__CF_Ke__47326E26]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[ScoreWeights]
	CHECK CONSTRAINT [FK__ScoreWeig__CF_Ke__47326E26]

GO
CREATE UNIQUE NONCLUSTERED INDEX [SCW_ScoreCustomFieldKey]
	ON [dbo].[ScoreWeights] ([PFL_Key], [CF_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScoreWeights] SET (LOCK_ESCALATION = TABLE)
GO
