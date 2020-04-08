SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserLists] (
		[UL_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[UL_Type]             [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UL_Name]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UL_ItemsXML]         [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UL_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_CodeLastEdit]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UL_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__UserList__EDB8E82368536ACF]
		PRIMARY KEY
		CLUSTERED
		([UL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserLists]
	WITH CHECK
	ADD CONSTRAINT [FK__UserLists__US_Co__1269A02C]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserLists]
	CHECK CONSTRAINT [FK__UserLists__US_Co__1269A02C]

GO
ALTER TABLE [dbo].[UserLists] SET (LOCK_ESCALATION = TABLE)
GO
