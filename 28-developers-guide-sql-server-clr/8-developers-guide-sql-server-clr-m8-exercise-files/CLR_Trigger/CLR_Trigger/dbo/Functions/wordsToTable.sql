CREATE FUNCTION [dbo].[wordsToTable]
(@wordList NVARCHAR (4000))
RETURNS 
     TABLE (
        [word] NVARCHAR (300) NULL,
        [nbr]  INT            NULL)
AS
 EXTERNAL NAME [SQLCLR_Functions].[UserDefinedFunctions].[wordsToTable]

