-- xs:dateTime/xs:date/xs:time values now require time zone information 
-- during schema validation and XQuery cast expressions. 

-- As a result, sql:variable/sql:column calls cannot refer to values of the SQL datetime type anymore. -- To work around this behavior, cast the SQL datetime value to a string type in T-SQL, 
-- add a timezone indicator, call the resulting value from sql:variable() or sql:column(), 
-- and then use an XQuery cast to cast the value to xs:datetime.
declare @x xml
declare @t datetime
declare @st nvarchar(30)
set @x = ''
set @t = CONVERT(datetime, '2005-03-01T12:00:00')
set @st = CONVERT(nvarchar(30), @t, 126) + N'Z'
select @x.query('<a>{sql:variable("@st")}</a>')

-- The value() method casts to SQL type datetime 
-- by removing timezone information if the timezone is Z (previously raised an error).
declare @x xml
set @x = N'<a>2005-03-01T12:00:00Z</a>'
select @x.value('xs:dateTime("2005-03-01T12:00:00-01:00")', 'datetime') -- a xs:datetime value
select @x.value('/a[1]', 'datetime') -- an untyped/string value



