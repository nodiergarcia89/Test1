SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DepartmentProfileModel] (
		[DPM_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[DPM_Desc]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DPM_Active]           [smallint] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DPM_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__Departme__B632EE2F703EA55A]
		PRIMARY KEY
		CLUSTERED
		([DPM_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DepartmentProfileModel]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DE_Co__5011CCEA]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[DepartmentProfileModel]
	CHECK CONSTRAINT [FK__Departmen__DE_Co__5011CCEA]

GO
ALTER TABLE [dbo].[DepartmentProfileModel] SET (LOCK_ESCALATION = TABLE)
GO
