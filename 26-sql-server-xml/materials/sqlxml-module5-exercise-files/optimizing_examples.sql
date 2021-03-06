
drop table t1
create table t1 (xmldoc xml)
insert t1 values('<a><b attr="x">111</b></a>')
insert t1 values('<a><b attr="y">222</b></a>')
insert t1 values('<a><b attr="z">333</b></a>')

-- 1. Casting
-- bad: 

SELECT CAST( CAST(xmldoc.query('/a/b/text()') as       
 nvarchar(500)) as int)
FROM t1
-- good: 
SELECT xmldoc.value('(/a/b/text())[1]', 'int')
FROM t1


-- bad: 
node.query('.').value('@attr','nvarchar(50)')
-- good:  
node.value('@attr', 'nvarchar(50)')

create table t2 (x xml)
insert t2 values('
<doc>
  <customer id="1">
    <firstname>Bob</firstname>
    <lastname>Smith</lastname>
    <orders id="11"/>
  </customer>
</doc>')
 

-- 2. Grouping value methods
-- assuming a schema constraint
-- bad: 
select c.value('@id', 'int') as CustID  
     , o.value('@id', 'int') as OrdID  
     , c.value('firstname[1]', 'nvarchar(50)') as fname  
     , c.value('lastname[1]', 'nvarchar(50)') as lname
from T2 
cross apply x.nodes('/doc/customer') as N1(c) 
cross apply c.nodes('orders') as N2(o) 
-- good: 
select c.value('@id', 'int') as CustID  
     , c.value('firstname[1]', 'nvarchar(50)') as fname  
     , c.value('lastname[1]', 'nvarchar(50)') as lname  
     , o.value('@id', 'int') as OrdID
from T2 
cross apply x.nodes('/doc/customer') as N1(c)       
cross apply c.nodes('orders') as N2(o) 


-- 3. Join and compare
-- Use exist() method, sql:column()/sql:variable() 
-- and an XQuery comparison for checking 
-- for a value or joining 
-- if secondary XML indices present

-- If applied on XML variable, 
-- value() method may still be more efficient
-- bad: 
select doc
from doc_tab 
join authors
on doc.value('(/doc/mainauthor/lname/text())[1]', 
             'nvarchar(50)') = au_lname
-- good: 
select doc
from doc_tab join authors
on 1 = doc.exist('
/doc/mainauthor/lname/text()[. = sql:column("authors.au_lname")]')

-- 4. avoiding multiple evaluations
-- Use subqueries
-- bad:
SELECT CASE 
  isnumeric(doc.value('(/doc/customer/order/price)[1]'
                    , 'nvarchar(32)'))  
  WHEN 1 THEN doc.value('(/doc/customer/order/price)[1]'
                    , 'decimal(5,2)')  
  ELSE 0 END FROM T 
--good:
SELECT CASE isnumeric(Price)  
  WHEN 1 THEN CAST(Price as decimal(5,2))   
  ELSE 0 END 
FROM (
SELECT doc.value('(/doc/customer/order/price)[1]'
                ,'nvarchar(32)')) as Price 
FROM T) X

-- 5. Value comparisons, 
-- XQuery casts and value() method casts 
-- require atomization of item attribute: 
/person[@age = 42] => /person[data(@age) = 42]

-- Atomic typed element:
/person[age = 42] =>  /person[data(age) = 42]

-- Untyped, mixed content typed element (adds UDX):
/person[age = 42]  
/person[data(age) = 42]  
/person[string(age) = 42] 
-- If only one text node for untyped element (better):
/person[age/text() = 42]  
/person[data(age/text()) = 42] 
-- String() aggregates all text nodes, 
-- prohibits index use for value lookup

-- 5. Value comparisons require casts and type promotion
-- casting is expensive and prohibits index use
-- Untyped attribute: 
/person[@age = 42]  
/person[xs:decimal(@age) = 42]
-- Untyped text node():
/person[age/text() = 42]  
/person[xs:decimal(age/text()) = 42]
-- Typed element 
(typed as xs:int):/person[salary = 3e4]  
/person[xs:double(salary) = 3e4]

-- 6. Avoid predicates in the middle of path expressions
/book[@ISBN = "1-8610-0157-6"]/author[first-name = "Davis"] 
/book[@ISBN = "1-8610-0157-6"] AND
/book/author[first-name = "Davis"] 

-- 7. Move ordinals to the end of path expressions
/a[1]/b[1] ≠ (/a/b)[1] ≠ /a/b[1] 
(/book/@ISBN)[1] is better than/book[1]/@ISBN

-- 8. In where clause 
-- where returned node irrelevant
-- bad:
SELECT * FROM docs WHERE 1 = xCol.exist 
	  ('/book/subject[text() = "security"]') 
-- good:
SELECT * FROM docs WHERE 1 = xCol.exist 
	  ('/book/subject/text()[. = "security"]') 
-- bad:
SELECT * FROM docs WHERE 1 = xCol.exist 
	  ('/book[@price > 9.99 and @price < 49.99]') 
-- good:
SELECT * FROM docs WHERE 1 = xCol.exist 
	  ('/book/@price[. > 9.99 and . < 49.99]') 

-- 9. FOR XML is better than construction
-- bad:
SELECT notes.query('
<Customer cid="{sql:column(''cid'')}">
{<name>{sql:column("name")}</name>, /}</Customer>')
FROM Customers WHERE cid=1
-- good:
SELECT cid as "@cid", name, notes as "*"
FROM Customers 
WHERE cid=1
FOR XML PATH('Customer'), TYPE