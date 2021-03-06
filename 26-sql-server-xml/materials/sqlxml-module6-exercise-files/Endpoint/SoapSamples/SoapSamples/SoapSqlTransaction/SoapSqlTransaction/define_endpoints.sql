--
-- 
use master
go

drop endpoint pubs_endpoint
go

CREATE ENDPOINT pubs_endpoint                                      
STATE = STARTED
AS HTTP
(
	SITE = '*'	,
	PATH = '/pubs/'	,  
	AUTHENTICATION = (INTEGRATED), 
	PORTS = (CLEAR)
)
FOR SOAP 
(
   
  WEBMETHOD 'urn:www-develop-com:invoices'.'byroyalty' 
  (
    name='pubs.dbo.byroyalty',
    SCHEMA = STANDARD
  ),

  BATCHES = ENABLED, 
  WSDL = DEFAULT, 
  SESSIONS = ENABLED,
  SESSION_TIMEOUT = 600,
  
  DATABASE = 'pubs'
)              
go