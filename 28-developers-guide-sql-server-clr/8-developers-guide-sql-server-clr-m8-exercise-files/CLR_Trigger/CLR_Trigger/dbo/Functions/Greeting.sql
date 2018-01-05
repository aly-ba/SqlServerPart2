CREATE FUNCTION [dbo].[Greeting]
(@name NVARCHAR (4000))
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [SQLCLR_Quick].[UserDefinedFunctions].[Greeting]

