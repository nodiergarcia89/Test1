SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KNVV] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKORG]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VTWEG]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPART]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERNAM]                [nvarchar](768) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ERDAT]                [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BEGRU]                [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LOEVM]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VERSG]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AUFSD]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KALKS]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KDGRP]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BZIRK]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KONDA]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLTYP]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AWAHR]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[INCO1]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[INCO2]                [nvarchar](1792) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LIFSD]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AUTLF]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ANTLF]                [decimal](1, 0) NOT NULL,
		[KZTLF]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KZAZU]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CHSPL]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LPRIO]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EIKTO]                [nvarchar](768) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VSBED]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FAKSD]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MRNKZ]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PERFK]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PERRL]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KVAKZ]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KVAWT]                [decimal](13, 2) NOT NULL,
		[WAERS]                [nvarchar](320) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KLABC]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KTGRD]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZTERM]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VWERK]                [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VKGRP]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VKBUR]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VSORT]                [nvarchar](640) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KVGR1]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KVGR2]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KVGR3]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KVGR4]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KVGR5]                [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BOKRE]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BOIDT]                [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KURST]                [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRFRE]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT1]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT2]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT3]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT4]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT5]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT6]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT7]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT8]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRAT9]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRATA]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KABSS]                [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KKBER]                [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CASSD]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RDOFF]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AGREL]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MEGRU]                [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UEBTO]                [decimal](3, 1) NOT NULL,
		[UNTTO]                [decimal](3, 1) NOT NULL,
		[UEBTK]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PVKSM]                [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PODKZ]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PODTG]                [decimal](11, 0) NOT NULL,
		[BLIND]                [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CARRIER_NOTIF]        [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[/BEV1/EMLGPFAND]      [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/EMLGFORTS]      [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZCOPALB]             [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZALBVAL]             [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFACCLI]             [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZAGRALB]             [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZAGRENV]             [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCOPFAC]             [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZIMPDEU]             [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZRUTAAUT]            [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZRORD]               [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZDCIERRE]            [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFRECVIS]            [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCONSUMO]            [decimal](13, 3) NOT NULL,
		[ZZMEINS]              [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZGAMA]               [nvarchar](576) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZPRGAMA]             [decimal](15, 2) NOT NULL,
		[ZZLOGO]               [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFECHALT]            [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFECHBAJ]            [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCONTDEU]            [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCLIESTAC]           [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCONSUMO2]           [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZDTLV]               [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZHORA]               [nvarchar](384) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZNOLLAM]             [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZHENTR]              [nvarchar](384) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZPROVACT]            [nvarchar](1600) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCONTVIG]            [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFECHVEN]            [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZMAQUINA]            [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZMODELO]             [nvarchar](1920) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZTIPOCON]            [nvarchar](1920) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZOTRINV]             [nvarchar](1920) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZRITMOE]             [nvarchar](1920) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZHORAE]              [nvarchar](1920) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFACTT]              [nvarchar](960) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZKGSEM]              [nvarchar](960) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZPRECI]              [nvarchar](960) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZGAMAP]              [nvarchar](576) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZPLV]                [nvarchar](1920) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCLIENTE]            [nvarchar](320) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZKSEM]               [decimal](8, 2) NOT NULL,
		[ZZACTPRIN]            [nvarchar](1600) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZNSEDES]             [nvarchar](96) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZMARCPROP]           [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZMARCAP]             [nvarchar](480) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZPROPCLTE]           [nvarchar](320) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZNEMPL]              [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFCOND]              [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFCOND_F]            [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZBAJAD]              [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZBAJAD_F]            [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCLIAS]              [nvarchar](448) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZDIRAS]              [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZNPRESUP]            [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFPRVTA]             [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFYLVTA]             [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZDENC]               [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZTIPE]               [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZDISTRIB]            [nvarchar](1920) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZCOBDC]              [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFREACT]             [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZMHDLP]              [decimal](3, 0) NULL,
		[ZZNUMTIENDA]          [nvarchar](320) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZEMBARGO]            [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZFRECPDA]            [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZMBAJA]              [nvarchar](192) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZTMVISITA]           [nvarchar](384) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZHORARIO1]           [nvarchar](384) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZHORARI11]           [nvarchar](384) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZHORARIO2]           [nvarchar](384) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZZHORARI21]           [nvarchar](384) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZNANALSAT]            [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ZGASTOSAT]            [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_KNVV]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [KUNNR], [VKORG], [VTWEG], [SPART])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_KNVV_7_1045578763__K2]
	ON [dbo].[KNVV] ([MANDT])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_KNVV_7_1045578763__K2_K3_K4_K5_K6_K14_15_17_42_81_90_92_93_95_96_97_98]
	ON [dbo].[KNVV] ([MANDT], [KUNNR], [VKORG], [VTWEG], [SPART], [KDGRP])
	INCLUDE ([BZIRK], [PLTYP], [VKBUR], [ZZFACCLI], [ZZCONSUMO], [ZZGAMA], [ZZPRGAMA], [ZZFECHALT], [ZZFECHBAJ], [ZZCONTDEU], [ZZCLIESTAC])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_KNVV_7_1045578763__K2_K5_K3_K4_K6_K39_K15_K14_17_42_81_90_92_93_95_96_97_98]
	ON [dbo].[KNVV] ([MANDT], [VTWEG], [KUNNR], [VKORG], [SPART], [ZTERM], [BZIRK], [KDGRP])
	INCLUDE ([ZZGAMA], [ZZPRGAMA], [ZZFECHALT], [ZZFECHBAJ], [ZZCONTDEU], [ZZCLIESTAC], [PLTYP], [VKBUR], [ZZFACCLI], [ZZCONSUMO])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_KNVV_7_1045578763__K3_K2_K4_K5_K6]
	ON [dbo].[KNVV] ([KUNNR], [MANDT], [VKORG], [VTWEG], [SPART])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_KNVV_7_1045578763__K5_K2_K3_K4_K6_K119_K111_K17_K39_K15_K14_42_81_90_92_93_95_96_97_98_99_100_101_102_103_104_105_]
	ON [dbo].[KNVV] ([VTWEG], [MANDT], [KUNNR], [VKORG], [SPART], [ZZACTPRIN], [ZZGAMAP], [PLTYP], [ZTERM], [BZIRK], [KDGRP])
	INCLUDE ([VKBUR], [ZZPROPCLTE], [ZZNEMPL], [ZZKGSEM], [ZZPRECI], [ZZKSEM], [ZZNSEDES], [ZZHORAE], [ZZFACTT], [ZZMARCPROP], [ZZMARCAP], [ZZPLV], [ZZCLIENTE], [ZZFECHVEN], [ZZMAQUINA], [ZZMODELO], [ZZTIPOCON], [ZZOTRINV], [ZZRITMOE], [ZZFACCLI], [ZZCONSUMO], [ZZCONTDEU], [ZZCLIESTAC], [ZZGAMA], [ZZPRGAMA], [ZZFECHALT], [ZZFECHBAJ], [ZZPROVACT], [ZZCONTVIG])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[KNVV] SET (LOCK_ESCALATION = TABLE)
GO
