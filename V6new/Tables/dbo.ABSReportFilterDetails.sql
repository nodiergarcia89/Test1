SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ABSReportFilterDetails] (
		[AF_Key]         [int] NOT NULL,
		[ARD_Key]        [int] NOT NULL,
		[RP_Name]        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ARD_Number]     [int] NULL,
		[ARD_Value]      [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ABSRepor__DB0F88B20F975522]
		PRIMARY KEY
		CLUSTERED
		([AF_Key], [ARD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ABSReportFilterDetails]
	WITH CHECK
	ADD CONSTRAINT [FK__ABSReport__AF_Ke__15261146]
	FOREIGN KEY ([AF_Key]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[ABSReportFilterDetails]
	CHECK CONSTRAINT [FK__ABSReport__AF_Ke__15261146]

GO
ALTER TABLE [dbo].[ABSReportFilterDetails] SET (LOCK_ESCALATION = TABLE)
GO
