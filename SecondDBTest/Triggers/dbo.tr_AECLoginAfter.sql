SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

Create TRIGGER [tr_AECLoginAfter]
   ON  [AECLogin]
   AFTER INSERT,DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


--INSERT

if (Select SP_Number from SystemParams Where SP_Code = 'SYS-AUDIT-LOGINS') = -1 
begin
--Login Auditing is enabled

	--INSERT
	insert into LogOnAudit (US_Code, US_Desc, LOA_Date,LOA_Type, LOA_EventTime)
	select [inserted].US_Code, [inserted].US_Desc, [inserted].LO_Date, 'IN', cast(getutcdate() as float)+2 from [inserted]

	--DELETE
	insert into LogOnAudit (US_Code, US_Desc, LOA_Date,LOA_Type, LOA_EventTime)
	select [deleted].US_Code, [deleted].US_Desc, [deleted].LO_Date, 'OUT', cast(getutcdate() as float)+2 from [deleted]

end

END

GO
