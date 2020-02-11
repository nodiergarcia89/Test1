SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Claims] (
		[CM_Key]                  [int] IDENTITY(1, 1) NOT NULL,
		[CM_ClaimPrefix]          [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_ClaimNo]              [int] NULL,
		[CM_ReferenceNo]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_Notes]                [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_Date]                 [float] NULL,
		[CM_ClaimAmount]          [float] NULL,
		[CM_Accepted]             [smallint] NULL,
		[CM_AcceptanceDate]       [float] NULL,
		[CM_AcceptedBy]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_AcceptanceNotes]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_PaidAmount]           [float] NULL,
		[CM_Paid]                 [smallint] NULL,
		[CM_PaymentDate]          [float] NULL,
		[CM_PaidBy]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_PaymentNotes]         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CU_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_ExpenseCount]         [int] NULL,
		[CM_Null]                 [smallint] NULL,
		[US_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_LastEditDate]         [float] NULL,
		[CM_LastEdit]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_Modified]             [smallint] NULL,
		[CM_ModifiedBy]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_ModifiedDate]         [float] NULL,
		[CM_Exported]             [smallint] NULL,
		[CM_ExportedOn]           [float] NULL,
		[CM_ExportedBy]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CM_PayableAmount]        [float] NULL,
		[CM_NonPayableAmount]     [float] NULL,
		CONSTRAINT [PK__Claims__C0AD9CB273852659]
		PRIMARY KEY
		CLUSTERED
		([CM_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Claims]
	WITH CHECK
	ADD CONSTRAINT [FK__Claims__CU_Code__766C7FFC]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Claims]
	CHECK CONSTRAINT [FK__Claims__CU_Code__766C7FFC]

GO
ALTER TABLE [dbo].[Claims]
	WITH CHECK
	ADD CONSTRAINT [FK__Claims__RE_Code__7760A435]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Claims]
	CHECK CONSTRAINT [FK__Claims__RE_Code__7760A435]

GO
ALTER TABLE [dbo].[Claims] SET (LOCK_ESCALATION = TABLE)
GO
