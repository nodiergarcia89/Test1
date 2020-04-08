SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomFields] (
		[CF_Key]                           [int] NOT NULL,
		[CF_Name]                          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_DataType]                      [int] NULL,
		[CF_Required]                      [smallint] NULL,
		[CF_MaxLength]                     [int] NULL,
		[CF_Order]                         [int] NULL,
		[CF_Table]                         [int] NULL,
		[CF_CustomTableName]               [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_CustomTableIndex]              [int] NULL,
		[CF_CustomFieldIndex]              [int] NULL,
		[CF_Filter]                        [int] NULL,
		[CF_LastEdit]                      [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_DefaultValue]                  [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_ReadOnly]                      [smallint] NULL,
		[CF_MaxRows]                       [int] NULL,
		[CF_Section]                       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_FieldSize]                     [int] NULL,
		[CF_KeywordSort]                   [smallint] NULL,
		[CF_AppearsOnInfoScreens]          [smallint] NULL,
		[CF_UseDefaultValueWhenCloned]     [smallint] NULL,
		[CF_Options]                       [int] NULL,
		[CF_Validate]                      [smallint] NULL,
		[CF_SelectType]                    [smallint] NULL,
		[CF_GuidanceNotes]                 [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_GroupName]                     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_Expression]                    [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_IsControlled]                  [smallint] NULL,
		[CF_TriggerTypes]                  [bigint] NULL,
		[CF_EnableArchiving]               [smallint] NULL,
		[US_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CF_LastEditDate]                  [float] NULL,
		[CF_DecimalPlaces]                 [int] NULL,
		[CF_UseThousandSeperator]          [smallint] NULL,
		[CF_PortfolioTotal]                [int] NULL,
		CONSTRAINT [PK__CustomFi__8E3AED2E038683F8]
		PRIMARY KEY
		CLUSTERED
		([CF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[CustomFields] SET (LOCK_ESCALATION = TABLE)
GO
