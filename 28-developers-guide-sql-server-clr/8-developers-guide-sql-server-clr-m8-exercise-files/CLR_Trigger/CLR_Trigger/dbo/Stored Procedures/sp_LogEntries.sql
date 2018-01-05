CREATE PROCEDURE [dbo].[sp_LogEntries]
@logtype NVARCHAR (4000), @count INT
AS EXTERNAL NAME [CLRLogEntries].[StoredProcedures].[LogEntries]

