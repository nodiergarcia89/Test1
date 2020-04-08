SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dataload] (
		[DL_Key]               [int] IDENTITY(1, 1) NOT NULL,
		[DL_Entity]            [int] NOT NULL,
		[DL_File]              [varbinary](max) NULL,
		[DL_Progress]          [int] NULL,
		[DL_Result]            [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DL_EmailAddress]      [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DL_ContentConfig]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DL_SubType]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Dataload__0F0DED3B8247EA29]
		PRIMARY KEY
		CLUSTERED
		([DL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Dataload]
	WITH CHECK
	ADD CONSTRAINT [FK__Dataload__US_Cod__05EEBAAE]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[Dataload]
	CHECK CONSTRAINT [FK__Dataload__US_Cod__05EEBAAE]

GO
ALTER TABLE [dbo].[Dataload] SET (LOCK_ESCALATION = TABLE)
GO
