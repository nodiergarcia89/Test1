SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Portfolio] (
		[PFL_Key]             [int] IDENTITY(1, 1) NOT NULL,
		[PFL_Name]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PFL_Description]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PFL_StartDate]       [float] NULL,
		[PFL_EndDate]         [float] NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PFL_LastEditOn]      [float] NOT NULL,
		[DE_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PFL_IsTemp]          [smallint] NOT NULL,
		[PFL_LastEdit]        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Portfoli__9D62BB7A30BD096A]
		PRIMARY KEY
		CLUSTERED
		([PFL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Portfolio]
	ADD
	CONSTRAINT [DF__Portfolio__PFL_I__4361DD42]
	DEFAULT ((0)) FOR [PFL_IsTemp]
GO
ALTER TABLE [dbo].[Portfolio]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__DE_Co__426DB909]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[Portfolio]
	CHECK CONSTRAINT [FK__Portfolio__DE_Co__426DB909]

GO
ALTER TABLE [dbo].[Portfolio] SET (LOCK_ESCALATION = TABLE)
GO
