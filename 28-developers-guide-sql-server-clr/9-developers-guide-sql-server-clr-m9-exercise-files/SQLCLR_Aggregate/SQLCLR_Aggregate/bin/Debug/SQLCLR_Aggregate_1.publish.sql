﻿/*
Deployment script for AdventureWorksLT2008

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "AdventureWorksLT2008"
:setvar DefaultFilePrefix "AdventureWorksLT2008"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL10.SQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL10.SQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Dropping [dbo].[AverageCountNulls]...';


GO
DROP AGGREGATE [dbo].[AverageCountNulls];


GO
PRINT N'Altering [SQLCLR_Aggregate]...';


GO
ALTER ASSEMBLY [SQLCLR_Aggregate]
    DROP FILE ALL;


GO
ALTER ASSEMBLY [SQLCLR_Aggregate]
    FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C01030058069B540000000000000000E00002210B010B00000A000000060000000000000E290000002000000040000000000010002000000002000004000000000000000400000000000000008000000002000000000000030040850000100000100000000010000010000000000000100000000000000000000000B82800005300000000400000C802000000000000000000000000000000000000006000000C000000802700001C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E746578740000001409000000200000000A000000020000000000000000000000000000200000602E72737263000000C80200000040000000040000000C0000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000001000000000000000000000000000004000004200000000000000000000000000000000F02800000000000048000000020005004821000038060000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056000216730800000A7D0100000402167D020000042AEA0002257B010000040F01280900000A2D090F01280A00000A2B0616730800000A00280B00000A7D0100000402257B0200000417587D020000042ABA0002257B010000040F017B01000004280B00000A7D0100000402257B020000040F017B02000004587D020000042A13300200340000000100001100027B020000042C18027B01000004027B02000004280C00000A280D00000A2B0616730800000A000A06730E00000A0B2B00072A6A0002036F0F00000A7D0100000402036F1000000A7D020000042A720003027B010000046F1100000A0003027B020000046F1200000A002A42534A4201000100000000000C00000076322E302E35303732370000000005006C0000001C020000237E000088020000B802000023537472696E6773000000004005000008000000235553004805000010000000234755494400000058050000E000000023426C6F620000000000000002000001571702000900000000FA25330016000001000000100000000200000002000000060000000500000001000000120000000500000001000000010000000200000000000A00010000000000060041003A000A0072005700060083003A000A00BC00A7000600EC00E2000600FE00E2000A001D01570006005601430123006A0100000600990179010600B90179010600E8013A000A00FE0157000A001F02570006004502260206005B0226020000000001000000000001000100092110001F00000005000100010001008B000A00010097000E005020000000008600A200110001006620000000008600C70015000100A120000000008600D2001B000200D020000000008600D80021000300102100000000E601F900260004002B2100000000E6010B012C000500000001001101000001001701000000000000000001003501000001003C010200090039002F01110041002F01530051002F01590059002F01110061002F01110069002F015E0079002F017F0019002F01590021006602850021007102890019007B028E00190087029700190093028E0021002F019D0029009F0289002900AB02AA0031000B019D0031000B0159002E001300AE002E001B00B7002E002300C00043003300640064000B003200A300048000000000000000000000000000000000D7010000020000000000000000000000010031000000000002000000000000000000000001004B00000000000000003C4D6F64756C653E0053514C434C525F4167677265676174652E646C6C0041766572616765436F756E744E756C6C73006D73636F726C69620053797374656D0056616C7565547970650053797374656D2E44617461004D6963726F736F66742E53716C5365727665722E536572766572004942696E61727953657269616C697A6500446563696D616C00746F74616C416D6F756E7400746F74616C436F756E7400496E69740053797374656D2E446174612E53716C54797065730053716C446563696D616C00416363756D756C617465004D65726765005465726D696E6174650053797374656D2E494F0042696E61727952656164657200526561640042696E6172795772697465720057726974650056616C75650047726F75700053716C4661636574417474726962757465002E63746F7200726561646572007772697465720053797374656D2E446961676E6F73746963730044656275676761626C6541747472696275746500446562756767696E674D6F6465730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C6974794174747269627574650053514C434C525F4167677265676174650053657269616C697A61626C654174747269627574650053716C55736572446566696E656441676772656761746541747472696275746500466F726D61740053797374656D2E52756E74696D652E496E7465726F705365727669636573005374727563744C61796F7574417474726962757465004C61796F75744B696E64006765745F49734E756C6C006765745F56616C7565006F705F4164646974696F6E006F705F496D706C69636974006F705F4469766973696F6E0052656164446563696D616C0052656164496E743332000000000003200000000000D3916717753A3948B93CAD709640BE310008B77A5C561934E0890306110D0206080320000105200101111105200101110804200011110520010112150520010112192001000200540809507265636973696F6E0A0000005408055363616C650600000005200101112504200101080520010111391A010002000000010054080B4D61784279746553697A656400000005200101114103200002042000110D080002110D110D110D050001110D0805200101110D060702110D1111032000080801000701000000000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F777301000000000058069B5400000000020000001C0100009C2700009C09000052534453CE6E6AF45B493447A54D672AB820D7A502000000633A5C50726F6A656374735C53514C434C525F4167677265676174655C53514C434C525F4167677265676174655C6F626A5C44656275675C53514C434C525F4167677265676174652E70646200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E02800000000000000000000FE280000002000000000000000000000000000000000000000000000F028000000000000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF25002000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000018000080000000000000000000000000000001000100000030000080000000000000000000000000000001000000000048000000584000006C02000000000000000000006C0234000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000000000000000000000000000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B004CC010000010053007400720069006E006700460069006C00650049006E0066006F000000A801000001003000300030003000300034006200300000002C0002000100460069006C0065004400650073006300720069007000740069006F006E000000000020000000300008000100460069006C006500560065007200730069006F006E000000000030002E0030002E0030002E00300000004C001500010049006E007400650072006E0061006C004E0061006D0065000000530051004C0043004C0052005F004100670067007200650067006100740065002E0064006C006C00000000002800020001004C006500670061006C0043006F0070007900720069006700680074000000200000005400150001004F0072006900670069006E0061006C00460069006C0065006E0061006D0065000000530051004C0043004C0052005F004100670067007200650067006100740065002E0064006C006C0000000000340008000100500072006F006400750063007400560065007200730069006F006E00000030002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000030002E0030002E0030002E003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000103900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;


GO
ALTER ASSEMBLY [SQLCLR_Aggregate]
    DROP FILE ALL
    ADD FILE FROM 0x4D6963726F736F667420432F432B2B204D534620372E30300D0A1A445300000000020000010000001B000000800000000000000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080930FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF30F2CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0BCA3101380000000010000000100000000000000D00FFFF0400000003800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F862513FC607D311905300C04FA302A1C4454B99E9E6D211903F00C04FA302A10B9D865A1166D311BD2A0000F80849BD60A66E40CF64824CB6F042D48172A79910000000000000002216414BDADBEF2E3154CE6160D98B5908000000090000000C0000000D0000000E0000000F000000100000001200000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000E700000000000000E70000000000000000000000000000000000000000000000010000000000000000000000000000004191320100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA310138000000001000000010000000000000FFFFFFFF040000000380000000000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA310138000000001000000010000000000000FFFFFFFF040000000380000000000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BCA3101380000000010000000100000000000000F00FFFF04000000038000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001BE2300180000000151A2EBDA71FD001020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000200000001000000020000000000000045000000280000001BE230016D2E6C5C58000000010000004400000045000000650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FEEFFEEF010000008800000000633A5C50726F6A656374735C53514C434C525F4167677265676174655C53514C434C525F4167677265676174655C41766572616765436F756E744E756C6C732E63730000633A5C70726F6A656374735C73716C636C725F6167677265676174655C73716C636C725F6167677265676174655C61766572616765636F756E746E756C6C732E637300040000004400000000000000010000004500000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001BE2300180000000779B146AA71FD001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000200000001000000020000000000000045000000280000001BE230018037257B58000000010000004400000045000000650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000002E002A1100000000F80000000000000015000000000000000000000001000006000000000100000000496E69740000001600031104000000C40000001500000000000000010000000A0024115553797374656D00120024115553797374656D2E44617461000000001A0024115553797374656D2E446174612E53716C436C69656E7400001A0024115553797374656D2E446174612E53716C54797065730000001E002411554D6963726F736F66742E53716C5365727665722E53657276657200020006002E000404C93FEAC6B359D649BC250902BBABB460000000004D0044003200000004010000040000000C000000010005000200060032002A110000000060010000000000003A000000000000000000000002000006150000000100000000416363756D756C617465002E000404C93FEAC6B359D649BC250902BBABB460000000004D0044003200000004010000040156000C00000001000006020006002E002A1100000000C4010000000000002E0000000000000000000000030000064F00000001000000004D6572676500002E000404C93FEAC6B359D649BC250902BBABB460000000004D0044003200000004010000040156000C000000010000060200060032002A11000000008402000000000000340000000000000000000000040000067D00000001000000005465726D696E617465000016000311C801000050020000340000007D000000010000001E002011010000000100001100000000000004004353243124303030300000001A00201100000000010000110000000000000000726573756C740000020006002E000404C93FEAC6B359D649BC250902BBABB460000000004D00440032000000040100000401A5000C00000001000006020006002E002A1100000000E8020000000000001A000000000000000000000005000006B10000000100000000526561640000002E000404C93FEAC6B359D649BC250902BBABB460000000004D0044003200000004010000040156000C00000001000006020006002E002A11000000004C030000000000001C000000000000000000000006000006CB0000000100000000577269746500002E000404C93FEAC6B359D649BC250902BBABB460000000004D0044003200000004010000040156000C0000000100000602000600F20000004800000000000000010001001500000000000000040000003C000000000000000F00008001000000100000800D0000001100008014000000120000800500060009001A000900180005000600F20000004800000015000000010001003A00000000000000040000003C000000000000001500008001000000160000802B00000017000080390000001800008005000600090038000900160005000600F2000000480000004F000000010001002E00000000000000040000003C000000000000001B000080010000001C000080190000001D0000802D0000001E0000800500060009002A000900280005000600F2000000480000007D000000010001003400000000000000040000003C00000000000000220000800100000023000080290000002400008032000000250000800500060009004A000900270005000600F200000048000000B1000000010001001A00000000000000040000003C000000000000002800008001000000290000800D0000002A000080190000002B0000800500060009002C000900290005000600F200000048000000CB000000010001001C00000000000000040000003C000000000000002E000080010000002F0000800E000000300000801B0000003100008005000600090023000900220005000600F40000000800000001000000000000003000000000000000140000002C0000004800000060000000740000008C000000A4000000BC000000D0000000E8000000FC0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF1A092FF16000000034020000490000000100000075000000010000002D000000010000001500000001000000FD000000010000008D00000001000000A500000001000000D1000000010000000100000001000000E9000000010000006100000001000000BD00000001000000010000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000010000000000000000000000000000000000000000000000000000000000000001000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000001000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0000001800000024000000300000003C0000004800000054000000600000006C00000078000000840000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001200251100000000040000000100496E697400001600291100000000040000000100303630303030303100001A00251100000000FC0000000100416363756D756C617465000000001600291100000000FC00000001003036303030303032000012002511000000006401000001004D65726765001600291100000000640100000100303630303030303300001600251100000000C801000001005465726D696E617465001600291100000000C801000001003036303030303034000012002511000000008802000001005265616400001600291100000000880200000100303630303030303500001200251100000000EC02000001005772697465001600291100000000EC020000010030363030303030360000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000FFFFFFFF1A092FF100000000000000001A00251100000000FC0000000100416363756D756C617465000000001600291100000000FC00000001003036303030303032000012002511000000006401000001004D65726765001600291100000000640100000100303630303030303300001600251100000000C801000001005465726D696E617465001600291100000000C801000001003036303030303034000012002511000000008802000001005265616400001600291100000000880200000100303630303030303500001200251100000000EC02000001005772697465001600291100000000EC0200000100303630303030303600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFF77093101020000000A00008B0B0015C60C0009465C000000AC0000002C00000050000000000000000000000016000000190000000000EEC00000000000000000FFFF000000000000FFFFFFFF00000000FFFF00000000000000000000000009005003000000000000F0010000010000009820A600000000000000000041766572616765436F756E744E756C6C7300423230413838384400002DBA2EF10100000000000000150000000000000000000000000000000000000001000000150000003A00000000000000000000000000000000000000010000004F0000002E00000000000000000000000000000000000000010000007D000000340000000000000000000000000000000000000001000000B10000001A0000000000000000000000000000000000000001000000CB0000001C00000000000000000000000000000000000000020002000D01000000000100FFFFFFFF00000000E70000000802000000000000FFFFFFFF00000000FFFFFFFF010001000000010000000000633A5C50726F6A656374735C53514C434C525F4167677265676174655C53514C434C525F4167677265676174655C41766572616765436F756E744E756C6C732E63730000FEEFFEEF010000000100000000010000000000000000000000FFFFFFFFFFFFFFFFFFFF0E00FFFFFFFFFFFFFFFFFFFF00000000000000000000000000090000007C000000CC00000038000000FFFFFFFF3800000000000000AC0000008000000058000000040000000300000006000000070000000A0000000B0000000800000072632F66696C65732F633A5C70726F6A656374735C73716C636C725F6167677265676174655C73716C636C725F6167677265676174655C61766572616765636F756E746E756C6C732E6373000400000006000000010000003A0000000000000011000000070000000A0000000600000000000000050000002200000008000000000000004191320100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001400000020000000CC00000038000000F30100003800000000000000AC00000080000000580000002800000074050000A40200002C0000001401000003000000140000000600000013000000070000000A0000000B00000008000000090000000C0000000D0000000E0000000F00000010000000120000001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000942E3101CD059B5402000000CE6E6AF45B493447A54D672AB820D7A5700000002F4C696E6B496E666F002F6E616D6573002F7372632F686561646572626C6F636B002F7372632F66696C65732F633A5C70726F6A656374735C73716C636C725F6167677265676174655C73716C636C725F6167677265676174655C61766572616765636F756E746E756C6C732E6373000400000006000000010000003A0000000000000011000000070000000A0000000600000000000000050000002200000008000000000000004191320100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F00000044000000CC00000038000000F30100003800000000000000AC000000800000005800000074050000A40200002C00000014010000FFFFFFFF2800000014000000160000000600000013000000070000000A00000009000000040000000C0000000D0000000E0000000F00000010000000120000001100000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 AS N'SQLCLR_Aggregate.pdb';


GO
PRINT N'Creating [dbo].[AverageCountNulls]...';


GO
CREATE AGGREGATE [dbo].[AverageCountNulls](@Value NUMERIC (18))
    RETURNS NUMERIC (10, 6)
    EXTERNAL NAME [SQLCLR_Aggregate].[AverageCountNulls];


GO
PRINT N'Update complete.'
GO
