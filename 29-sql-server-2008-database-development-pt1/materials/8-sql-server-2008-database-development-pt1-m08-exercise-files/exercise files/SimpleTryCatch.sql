

BEGIN TRY 
	SELECT 1/0 --* FROM sys.messages 
	--WHERE message_id = 19; 
END TRY 

BEGIN CATCH 
	SELECT ERROR_NUMBER() AS ErrorNumber,
	       ERROR_MESSAGE() as ErrorMessage; 
END CATCH; 
GO