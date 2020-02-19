SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Action] (
		[AN_Key]                     [int] IDENTITY(1, 1) NOT NULL,
		[AN_ProcessID]               [int] NULL,
		[AN_ProcessNotes]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_ProcessStatus]           [smallint] NULL,
		[CL_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Key]                     [int] NULL,
		[AT_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_StartDate]               [float] NOT NULL,
		[AN_StartTime]               [float] NULL,
		[AN_EndDate]                 [float] NULL,
		[AN_EndTime]                 [float] NULL,
		[AN_Reference]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_RequiredDate]            [float] NULL,
		[AN_RequiredTime]            [float] NULL,
		[AN_ToDo]                    [smallint] NULL,
		[AN_EarliestStartDate]       [float] NULL,
		[AN_EarliestStartTime]       [float] NULL,
		[AN_Closed]                  [smallint] NULL,
		[AN_ForwardNotes]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_ForwardKey]              [int] NULL,
		[AN_Attachments]             [smallint] NULL,
		[AN_Priority]                [int] NULL,
		[AN_Forwarded]               [smallint] NULL,
		[AN_RefPrefix]               [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_RefAutoNum]              [int] NULL,
		[AN_MasterActionKey]         [int] NULL,
		[AN_TextPreview]             [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_EditBy]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_EditOn]                  [float] NULL,
		[AN_EditOverwriteBy]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AN_LastEditDate]            [float] NULL,
		[AN_LastEdit]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_KeyArchivedDocument]     [int] NULL,
		[AN_PublishTo]               [int] NULL,
		CONSTRAINT [PK__Action__FF73481A1367E606]
		PRIMARY KEY
		CLUSTERED
		([AN_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Action]
	WITH CHECK
	ADD CONSTRAINT [FK__Action__AN_Maste__161A357F]
	FOREIGN KEY ([AN_MasterActionKey]) REFERENCES [dbo].[Action] ([AN_Key])
ALTER TABLE [dbo].[Action]
	CHECK CONSTRAINT [FK__Action__AN_Maste__161A357F]

GO
ALTER TABLE [dbo].[Action]
	WITH CHECK
	ADD CONSTRAINT [FK__Action__AT_Code__170E59B8]
	FOREIGN KEY ([AT_Code]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[Action]
	CHECK CONSTRAINT [FK__Action__AT_Code__170E59B8]

GO
ALTER TABLE [dbo].[Action]
	WITH CHECK
	ADD CONSTRAINT [FK__Action__CL_Code__18027DF1]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[Action]
	CHECK CONSTRAINT [FK__Action__CL_Code__18027DF1]

GO
ALTER TABLE [dbo].[Action]
	WITH CHECK
	ADD CONSTRAINT [FK__Action__CN_Key__18F6A22A]
	FOREIGN KEY ([CN_Key]) REFERENCES [dbo].[Contacts] ([CN_Key])
ALTER TABLE [dbo].[Action]
	CHECK CONSTRAINT [FK__Action__CN_Key__18F6A22A]

GO
ALTER TABLE [dbo].[Action]
	WITH CHECK
	ADD CONSTRAINT [FK__Action__PR_Code__19EAC663]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Action]
	CHECK CONSTRAINT [FK__Action__PR_Code__19EAC663]

GO
ALTER TABLE [dbo].[Action]
	WITH CHECK
	ADD CONSTRAINT [FK__Action__RE_Code__1ADEEA9C]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Action]
	CHECK CONSTRAINT [FK__Action__RE_Code__1ADEEA9C]

GO
CREATE NONCLUSTERED INDEX [AN_ClientContactIndex]
	ON [dbo].[Action] ([CL_Code], [CN_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_ClientProject]
	ON [dbo].[Action] ([PR_Code], [CL_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_ClientStartDateIndex]
	ON [dbo].[Action] ([CL_Code], [AN_StartDate])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_ProcessIDIndex]
	ON [dbo].[Action] ([AN_ProcessID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_ReferenceIndex]
	ON [dbo].[Action] ([AN_Reference])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_ResourceStartDateIndex]
	ON [dbo].[Action] ([RE_Code], [AN_StartDate])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_StartDateClientIndex]
	ON [dbo].[Action] ([AN_StartDate], [CL_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_StartDateResourceIndex]
	ON [dbo].[Action] ([AN_StartDate], [RE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_StartDateTypeIndex]
	ON [dbo].[Action] ([AN_StartDate], [AT_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AN_TypeStartDateIndex]
	ON [dbo].[Action] ([AT_Code], [AN_StartDate])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Action] SET (LOCK_ESCALATION = TABLE)
GO
