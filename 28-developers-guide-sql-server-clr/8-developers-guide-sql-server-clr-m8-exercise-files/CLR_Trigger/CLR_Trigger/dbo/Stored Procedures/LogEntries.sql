CREATE PROCEDURE [dbo].[LogEntries]
@logtype NVARCHAR (4000), @count INT
AS EXTERNAL NAME [CLRLogEntries].[StoredProcedures].[LogEntries]

