SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomFieldCulture] (
		[CF_Key]                [int] NOT NULL,
		[CLC_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CFC_Section]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFC_Name]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFC_GuidanceNotes]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CFC_Group]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__CustomFi__A55CD0347814D14C]
		PRIMARY KEY
		CLUSTERED
		([CF_Key], [CLC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomFieldCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__CustomFie__CF_Ke__2156DE01]
	FOREIGN KEY ([CF_Key]) REFERENCES [dbo].[CustomFields] ([CF_Key])
ALTER TABLE [dbo].[CustomFieldCulture]
	CHECK CONSTRAINT [FK__CustomFie__CF_Ke__2156DE01]

GO
ALTER TABLE [dbo].[CustomFieldCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__CustomFie__CLC_C__224B023A]
	FOREIGN KEY ([CLC_Code]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[CustomFieldCulture]
	CHECK CONSTRAINT [FK__CustomFie__CLC_C__224B023A]

GO
ALTER TABLE [dbo].[CustomFieldCulture] SET (LOCK_ESCALATION = TABLE)
GO
