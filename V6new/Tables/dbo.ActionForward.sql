SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionForward] (
		[ANF_Key]           [int] NOT NULL,
		[AN_Key]            [int] NOT NULL,
		[AN_KeyForward]     [int] NOT NULL,
		[RE_Code]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANF_Date]          [float] NULL,
		[ANF_Read]          [smallint] NULL,
		CONSTRAINT [PK__ActionFo__7993F29F276EDEB3]
		PRIMARY KEY
		CLUSTERED
		([ANF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionForward] SET (LOCK_ESCALATION = TABLE)
GO
