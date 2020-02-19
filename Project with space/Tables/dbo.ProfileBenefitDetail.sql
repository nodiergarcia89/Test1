SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProfileBenefitDetail] (
		[PBL_Key]              [int] NOT NULL,
		[PP_StartDate]         [float] NOT NULL,
		[PP_EndDate]           [float] NOT NULL,
		[PBD_LocalAmount]      [float] NULL,
		[PBD_SystemAmount]     [float] NULL,
		CONSTRAINT [PK__ProfileB__DD0E78C14C8B54C9]
		PRIMARY KEY
		CLUSTERED
		([PBL_Key], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileBenefitDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileBe__PBL_K__2121D3D7]
	FOREIGN KEY ([PBL_Key]) REFERENCES [dbo].[ProfileBenefitLine] ([PBL_Key])
ALTER TABLE [dbo].[ProfileBenefitDetail]
	CHECK CONSTRAINT [FK__ProfileBe__PBL_K__2121D3D7]

GO
ALTER TABLE [dbo].[ProfileBenefitDetail] SET (LOCK_ESCALATION = TABLE)
GO
