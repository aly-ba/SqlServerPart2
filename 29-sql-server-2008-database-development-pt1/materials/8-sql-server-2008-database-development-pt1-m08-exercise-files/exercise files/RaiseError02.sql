begin try
  EXECUTE sp_dropmessage 75000;
end try
begin catch
end catch

GO
EXECUTE sp_addmessage 75000,	-- Message id number
                      10,	-- Severity
                      N'The current database ID is: %d, the database name is: %s.';
GO
DECLARE @DBID INT;
SET @DBID = DB_ID();

DECLARE @DBNAME NVARCHAR(128);
SET @DBNAME = DB_NAME();

RAISERROR (75000,
    10,			-- Severity
    1,			-- State
    @DBID,		-- First substitution argument
    @DBNAME);		-- Second substitution argument
GO