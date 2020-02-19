SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aecspLog
Purpose
    Populates a log table with details of the Quickbooks integration run
Behaviour
	Inserts an entry in the Log table
Parameters
	@Tag	- 
			
	@Msg	- 
			
	@LogTime - 
Prerequisites
	None
Return
    Nothing
*******************************************************************************************************/

CREATE PROCEDURE [aecspLog]
	-- Add the parameters for the stored procedure here
	@Tag nvarchar(20), 
	@Msg nvarchar(Max),
	@LogDateTime float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Log
          ( 
            LOG_Tag,
            LOG_Msg,
			LOG_DateTime                                    
          ) 
     VALUES 
          ( 
            @Tag,
            @Msg,
			@LogDateTime                 
          )	 

END

GO
GRANT EXECUTE
	ON [dbo].[aecspLog]
	TO [V6N14816rwZf]
GO
