--http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnsql90/html/forxml2k5.asp

create table parentchild
(
	id int,
	parent int,
	name nvarchar(50)
)
go

insert parentchild values(1,null,'top level')
insert parentchild values(2,1,'level 2')
	insert parentchild values(4,2,'level 2')
		insert parentchild values(5,4,'level 3')

insert parentchild values(3,1,'level 2')
	insert parentchild values(6,3,'level 3')
insert parentchild values(7,1,'level 2')
go

--drop function GetItems

CREATE FUNCTION GetItems(@itemid int)
RETURNS XML
WITH RETURNS NULL ON NULL INPUT 
BEGIN RETURN 
  (SELECT id as "@id", name as "@name", 
      CASE WHEN parent=@itemid
      THEN dbo.GetItems(id)
      END
   FROM dbo.parentchild WHERE parent=@itemid
   FOR XML PATH('Item'), TYPE)
END

select id as "@id", name as "@name", 
       CASE WHEN id=1
       THEN dbo.GetItems(id)
       END
FROM parentchild
WHERE id=1
FOR XML PATH('Item'), TYPE, ROOT('ItemDoc')




/*


CREATE TABLE CATEGORY ( 
    CATEGORY_ID INTEGER IDENTITY(1,1) NOT NULL, 
    CATEGORY_NAME VARCHAR(40) NOT NULL CONSTRAINT 
UC__CATEGORY__CATEGORY_NAME UNIQUE, 
    PARENT_CATEGORY_ID INTEGER, 
    DEPTH INTEGER, 
    CONSTRAINT PK__CATEGORY PRIMARY KEY (CATEGORY_ID) 
) 
GO 


CREATE UNIQUE INDEX IDX__CATEGORY__CATEGORY_NAME ON CATEGORY 
(CATEGORY_NAME ASC) 
GO 


CREATE UNIQUE INDEX IDX__CATEGORY__CATEGORY_ID ON CATEGORY 
(CATEGORY_ID) 
GO 


INSERT INTO CATEGORY (CATEGORY_NAME) VALUES ('PC HARDWARE') 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME) VALUES ('MOBILES') 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME) VALUES ('CAMERAS') 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('NETWORKS', 1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('AUDIO', 1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('VIDEO', 1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('HARD 
DRIVES', 1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('MEMORY', 1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('MOTHERBOARDS', 1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('CPU', 
1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('SWITCHES', 4) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('HUBS', 
4) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('MODEMS', 4) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('ROUTERS', 4) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('BRIDGES', 4) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('EXTERNAL MODEMS', 13) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('INTERNAL MODEMS', 13) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('DSL 
MODEMS', 16) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('ISDN 
MODEMS', 16) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('GRAPHIC CARDS', 6) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AGP 
GRAPHIC CARDS', 20) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('PCI 
GRAPHIC CARDS', 20) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AUDIO 
CARDS', 5) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('PCI 
AUDIO CARDS', 23) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('ISA 
AUDIO CARDS', 23) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('SPEAKER SYSTEMS', 5) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('2.0 
SPEAKER SYSTEMS', 26) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('2.1 
SPEAKER SYSTEMS', 26) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('4.1 
SPEAKER SYSTEMS', 26) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('5.1 
SPEAKER SYSTEMS', 26) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('6.1 
SPEAKER SYSTEMS', 26) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('7.1 
SPEAKER SYSTEMS', 26) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('SPEAKER DECODER', 26) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('HEAD 
PHONES', 5) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('EAR 
PHONES', 5) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AUDIO 
ACCESSORIES', 5) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('EXTERNAL DEVICES', 5) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('DUPLICATION', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('ENCLOSURE', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('INTERNAL SCSI', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('SERIAL 
ATA', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('FIREWIRE', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('EXTERNAL USB', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('NETWORK ATTACHED STORAG', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('INTERNAL IDE', 7) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('TV 
CARDS', 6) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AGP 
016MB', 21) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AGP 
032MB', 21) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AGP 
064MB', 21) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AGP 
128MB', 21) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AGP 
256MB', 21) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('AGP 
512MB', 21) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('CONTROLLER',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('SCANNER',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('CASING',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('OPTICAL DEVICES',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('DISPLAY',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('INPUT 
DEVICES',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('COOLER',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('POWER',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('PRINTER',1) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('EIDE-ATA',53) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('SCSI-RAID',53) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('SCSI',53) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('PCMCIA 
INTERFACE',53) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('ISA 
INTERFACE',53) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('PCI 
INTERFACE',53) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('CD-R',56) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('CD-RW',56) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('DVD-R',56) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('DVD-RW',56) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('MONITOR',57) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('PLASMA',57) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('PROJECTOR',57) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('TOUCH 
SCREEN',57) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('DISPLAY ACCESSORIES',57) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('TABLETS & HANDWRITING',58) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('JOYSTICK & GAME PAD',58) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('KEYBOARD & KEYPAD',58) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('MICE',58) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('MOUSE 
PAD & WRIST REST',58) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('MICROPHONE',58) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('THERMAL GEL',59) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('LIQUID 
COOLING',59) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('FAN 
CONTROLLER',59) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('HARD 
DRIVE COOLER',59) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('CPU 
FAN',59) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES ('FAN 
FUNNEL',59) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('SHIM',59) 
GO 
INSERT INTO CATEGORY (CATEGORY_NAME,PARENT_CATEGORY_ID) VALUES 
('CHIPSET FAN',59) 
GO ...

*/

--http://groups.google.com/group/comp.databases.ms-sqlserver/browse_thread/thread/a17110878581fbe5/5f8ce4056288301d?lnk=st&q=%22sql+2005%22+recursive+query+with+nested+xml&rnum=2&hl=en#5f8ce4056288301d

--drop function dbo.recursfun

 create function dbo.recursfun (@category int,@depth tinyint) 
   returns xml as 
   begin return 

       /* declare @x xml 
        select @x = (select CATEGORY_NAME AS '@name', 
                           CATEGORY_ID   AS '@id', 
                             @depth + 1 as '@depth', 
                             dbo.recursfun(CATEGORY_ID, @depth + 1) 
                  from  CATEGORY 
                  where PARENT_CATEGORY_ID = @category 
                   for xml path('Category'),type) 
        return @x
		*/


(select CATEGORY_NAME AS '@name', 
                           CATEGORY_ID   AS '@id', 
                             @depth + 1 as '@depth', 
                             dbo.recursfun(CATEGORY_ID, @depth + 1) 
                  from  CATEGORY 
                  where PARENT_CATEGORY_ID = @category 
                   for xml path('Category'),type)
 
   end 
   go 


   select CATEGORY_NAME as '@Name', 
                            CATEGORY_ID   AS '@id', 
                             0 as '@depth', 
                              dbo.recursfun(CATEGORY_ID, 0) 
   from  CATEGORY 
   where PARENT_CATEGORY_ID IS NULL 
   for xml path('Category'),root('HARDWARE'), type 
   go 


