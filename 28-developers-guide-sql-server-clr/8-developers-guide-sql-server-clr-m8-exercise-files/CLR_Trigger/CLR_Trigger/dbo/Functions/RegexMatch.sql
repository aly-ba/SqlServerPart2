CREATE FUNCTION [dbo].[RegexMatch]
(@search NVARCHAR (MAX), @pattern NVARCHAR (4000))
RETURNS BIT
AS
 EXTERNAL NAME [SQLCLR_Functions].[UserDefinedFunctions].[RegexMatch]

