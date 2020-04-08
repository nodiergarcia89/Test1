SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AECLogin] (
		[LO_Key]             [int] IDENTITY(1, 1) NOT NULL,
		[US_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Desc]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Date]            [float] NULL,
		[LO_Product]         [smallint] NULL,
		[LO_ProductName]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__AECLogin__CB40FEF96A30C649]
		PRIMARY KEY
		CLUSTERED
		([LO_Key])
	ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX [LO_UserProductIndex]
	ON [dbo].[AECLogin] ([US_Code], [LO_Product])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[AECLogin] SET (LOCK_ESCALATION = TABLE)
GO
