SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[APEXSQL_LOG_OPERATION] (
		[LSN]                             [char](22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OPERATION_TYPE]                  [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OBJECT_NAME]                     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[USER_NAME]                       [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TRANSACTION_ID]                  [char](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TRANSACTION_BEGIN]               [datetime] NULL,
		[TRANSACTION_END]                 [datetime] NULL,
		[TRANSACTION_DESCRIPTION]         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ROW_RECONSTRUCTED]               [bit] NULL,
		[PAGE_ID]                         [char](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SLOT_ID]                         [int] NULL,
		[ID_KEY]                          [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SPID]                            [smallint] NULL,
		[SERVER]                          [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DATABASE]                        [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TRANSACTION_STATE]               [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SCHEMA_NAME]                     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ROW_PARTIALLY_RECONSTRUCTED]     [bit] NULL,
		[ROW_ORDINAL]                     [smallint] NOT NULL,
		[PARENT_SCHEMA_NAME]              [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PARENT_OBJECT_NAME]              [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PREVIOUS_LSN]                    [char](22) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DURATION]                        [float] NULL,
		[LOGON_TIME]                      [datetime] NULL,
		CONSTRAINT [PK_APEXSQL_LOG_OPERATION]
		PRIMARY KEY
		CLUSTERED
		([LSN], [ROW_ORDINAL])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[APEXSQL_LOG_OPERATION] SET (LOCK_ESCALATION = TABLE)
GO
