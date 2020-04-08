SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IntegrationAudit] (
		[IAU_Key]                   [int] IDENTITY(1, 1) NOT NULL,
		[IAU_ServerName]            [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IAU_SourceIPAddress]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IAU_SourceIPAddressV4]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IAU_ServiceName]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IAU_MethodName]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IAU_StartTime]             [float] NULL,
		[IAU_EndTime]               [float] NULL,
		[IAU_Succeeded]             [smallint] NULL,
		[IAU_RowCount]              [int] NULL,
		[IAU_Notes]                 [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Integrat__470D2E83297722B6]
		PRIMARY KEY
		CLUSTERED
		([IAU_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[IntegrationAudit] SET (LOCK_ESCALATION = TABLE)
GO
