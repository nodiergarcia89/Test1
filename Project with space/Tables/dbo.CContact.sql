SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CContact] (
		[CC_Key]          [int] IDENTITY(1, 1) NOT NULL,
		[CL_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Desc]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Phone]        [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Fax]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Invoice]      [smallint] NULL,
		[CC_Notes]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_LastEdit]     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__CContact__DC0EF5156BE40491]
		PRIMARY KEY
		CLUSTERED
		([CC_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CContact]
	WITH CHECK
	ADD CONSTRAINT [FK__CContact__CL_Cod__7484378A]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[CContact]
	CHECK CONSTRAINT [FK__CContact__CL_Cod__7484378A]

GO
ALTER TABLE [dbo].[CContact] SET (LOCK_ESCALATION = TABLE)
GO
