SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SchFilterDetails] (
		[US_Code]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SF_Name]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SD_Key]        [int] NOT NULL,
		[SD_Type]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SD_Text]       [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SD_Number]     [float] NULL,
		CONSTRAINT [PK__SchFilte__60EFF1BB5575A085]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [SF_Name], [SD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SchFilterDetails]
	WITH CHECK
	ADD CONSTRAINT [FK__SchFilter__US_Co__5748DA5E]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[SchFilterDetails]
	CHECK CONSTRAINT [FK__SchFilter__US_Co__5748DA5E]

GO
ALTER TABLE [dbo].[SchFilterDetails] SET (LOCK_ESCALATION = TABLE)
GO
