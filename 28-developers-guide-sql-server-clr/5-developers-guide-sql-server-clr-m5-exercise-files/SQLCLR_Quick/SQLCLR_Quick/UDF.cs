//------------------------------------------------------------------------------
// <copyright file="CSSqlFunction.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Web.Script.Serialization;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlString Greeting(SqlString name)
    {
        System.Web.Script.Serialization.JavaScriptSerializer ser = new JavaScriptSerializer();
        
        return new SqlString("Howdy " + 
            (name.IsNull ? "" : (string) name));

    }
}
