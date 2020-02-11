SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BenefitActual] (
		[BA_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[BA_Date]             [float] NULL,
		[PP_StartDate]        [float] NULL,
		[PP_EndDate]          [float] NULL,
		[BE_Key]              [int] NULL,
		[CU_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BA_Amount]           [float] NULL,
		[BA_SystemAmount]     [float] NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BA_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__BenefitA__AFB02B24114A936A]
		PRIMARY KEY
		CLUSTERED
		([BA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[BenefitActual]
	WITH CHECK
	ADD CONSTRAINT [FK__BenefitAc__BE_Ke__43E1002F]
	FOREIGN KEY ([BE_Key]) REFERENCES [dbo].[Benefit] ([BE_Key])
ALTER TABLE [dbo].[BenefitActual]
	CHECK CONSTRAINT [FK__BenefitAc__BE_Ke__43E1002F]

GO
ALTER TABLE [dbo].[BenefitActual]
	WITH CHECK
	ADD CONSTRAINT [FK__BenefitAc__CU_Co__44D52468]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[BenefitActual]
	CHECK CONSTRAINT [FK__BenefitAc__CU_Co__44D52468]

GO
ALTER TABLE [dbo].[BenefitActual] SET (LOCK_ESCALATION = TABLE)
GO
