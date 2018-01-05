using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text.RegularExpressions;
using System.Text;
using System.Collections;
using System.Collections.Generic;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlBoolean RegexMatch(SqlChars search, SqlString pattern)
    {
        return Regex.IsMatch(new string(search.Value), pattern.Value);
    }
    [SqlFunction(DataAccess = DataAccessKind.None,
                FillRowMethodName = "FillWordRow",
                TableDefinition = "word nvarchar(300)")]
    public static IEnumerator wordsToTable(SqlString wordList)
    {
        return new WordList((string)wordList);
    }

    public static void FillWordRow(object Wordrow, out string Word)
    {
        Word = Wordrow == null ? null : (string)Wordrow;
    }

    public partial class WordList : IEnumerator
    {
        private string[] Words;
        private int wordPosition;
        private char[] delimiters = { ',', ' ', ':', ';' };

        public WordList(string wordList)
        {
            this.wordPosition = -1;
            try
            {
                this.Words = wordList.Split(delimiters, StringSplitOptions.RemoveEmptyEntries);
            }
            catch
            {
                this.Words = null;
            }
        }

        public Object Current
        {
            get { return this.Words == null || wordPosition == -1 ? null : Words[wordPosition]; }
        }

        public bool MoveNext()
        {
            if (this.Words == null)
                return false;

            if (this.wordPosition >= (this.Words.Length - 1))
                return false;

            this.wordPosition++;
            return true;
        }

        public void Reset()
        {
            this.wordPosition = -1;
        }
     }
   
    [Microsoft.SqlServer.Server.SqlFunction(DataAccess=DataAccessKind.Read)]
    public static SqlChars ProductToJson(SqlInt32 ID)
    {
        StringBuilder sb = new StringBuilder("");
        string template = "{{\"ProductID\":\"{0}\",\"Name\":\"{1}\"," +
                            "\"Details\":{{\"StandardCost\":\"{2}\"," +
                            "\"ListPrice\":\"{3}\"}}}}";
        
        if (ID.IsNull )
            return new SqlChars("Null ID");

        using (SqlConnection sqlConn = new SqlConnection("context connection=true"))
        {
            sqlConn.Open();
            using (SqlCommand cmd = sqlConn.CreateCommand())
            {
                cmd.CommandText = "SELECT TOP 1 " +  
                                  " ProductID, Name, StandardCost, ListPrice FROM SalesLT.Product " +
                                  " WHERE ProductID = " + ID;
                cmd.CommandType = CommandType.Text;
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sb.AppendFormat(template, 
                            dr.GetInt32(0),
                            dr.GetString(1),
                            dr.GetDecimal(2),
                            dr.GetDecimal(3)
                            );
                    }
                }
            }
        }

        return new SqlChars(sb.ToString());
    }
}

