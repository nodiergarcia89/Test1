SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ResCapabilityDetail] (
		[RC_Key]            [int] NOT NULL,
		[PP_StartDate]      [float] NOT NULL,
		[RC_Type]           [smallint] NULL,
		[RC_Days]           [float] NULL,
		[RC_FTE]            [float] NULL,
		[RC_SystemCost]     [float] NULL,
		CONSTRAINT [PK__ResCapab__C70EDE272E90DD8E]
		PRIMARY KEY
		CLUSTERED
		([RC_Key], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResCapabilityDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__ResCapabi__PP_St__1392CE8F]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[ResCapabilityDetail]
	CHECK CONSTRAINT [FK__ResCapabi__PP_St__1392CE8F]

GO
ALTER TABLE [dbo].[ResCapabilityDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__ResCapabi__RC_Ke__1486F2C8]
	FOREIGN KEY ([RC_Key]) REFERENCES [dbo].[ResCapability] ([RC_Key])
ALTER TABLE [dbo].[ResCapabilityDetail]
	CHECK CONSTRAINT [FK__ResCapabi__RC_Ke__1486F2C8]

GO
ALTER TABLE [dbo].[ResCapabilityDetail] SET (LOCK_ESCALATION = TABLE)
GO
