USE [Credit];
GO

	
SELECT  [member].[member_no],
        [member].[lastname],
        [payment].[payment_no],
        [payment].[payment_dt],
        [payment].[payment_amt]
FROM    [dbo].[payment]
INNER HASH JOIN [dbo].[member]
        ON [member].[member_no] = [payment].[member_no]
OPTION  (FORCE ORDER);
GO 10000000