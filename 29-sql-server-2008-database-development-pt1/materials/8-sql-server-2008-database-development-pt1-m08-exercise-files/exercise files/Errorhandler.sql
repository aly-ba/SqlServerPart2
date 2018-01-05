use Veronicas
go 

CREATE PROCEDURE sales.InsertCustomer 
	-- The parameters for the stored procedure
	@CustomerNumber varchar(10),
	@FirstName		varchar(50)= NULL,
	@LastName		varchar(50)= NULL,
	@Phone			varchar(50)= NULL,
	@Address		varchar(50)= NULL,
	@City			varchar(50)= NULL,
	@State			varchar(50)= NULL,
	@Zip			varchar(10)= NULL,
	@Email			varchar(50)= NULL,
	@Birthdate		varchar(50)= NULL,
	@Anniversary	varchar(50)= NULL
AS

BEGIN TRY
INSERT INTO [veronicas].[SALES].[Customers]
           ([CustomerNumber]
           ,[FirstName]
           ,[LastName]
           ,[Phone]
           ,[Address]
           ,[City]
           ,[State]
           ,[Zip]
           ,[Email]
           ,[Birthdate]
           ,[Anniversary]
           )
     VALUES
           (@CustomerNumber,
			@FirstName,
			@LastName,
			@Phone,
			@Address,
			@City,
			@State,
			@Zip,
			@Email,
			@Birthdate,
			@Anniversary)
 END TRY
 BEGIN CATCH
           select ERROR_NUMBER() as ErrorNumber
                , ERROR_MESSAGE() as ErrorMessage
                , ERROR_SEVERITY() as Severity
                , ERROR_STATE() as ErrorState
                , ERROR_PROCEDURE() as ErrorProcedure
            --exec ErrorProc
END CATCH
GO

exec sales.InsertCustomer  1, 'FirstName' , 'LastName'
