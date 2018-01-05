using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Diagnostics;

public partial class StoredProcedures
{
    [SqlProcedure]
    public static void LogEntries(string logtype, Int32 count)
    {
        string beginMsg = "Logtype must be either Application or System";
        bool canProcess = false;

        if (logtype.ToLower() == "application" ||
            logtype.ToLower() == "system")
        {
            beginMsg = "Using log type: " + logtype;
            canProcess = true;
        }

        using (SqlConnection dbConnection =
            new SqlConnection("context connection=true"))
        {
            SqlPipe pipe = SqlContext.Pipe;
            SqlDataRecord record;

            pipe.Send(beginMsg);

            if (canProcess)
            {
                SqlMetaData[] metadata = new SqlMetaData[7];

                metadata[0] = new SqlMetaData("Index", SqlDbType.Int);
                metadata[1] = new SqlMetaData("ID", SqlDbType.BigInt);
                metadata[2] = new SqlMetaData("TimeWritten", SqlDbType.DateTime);
                metadata[3] = new SqlMetaData("MachineName", SqlDbType.NVarChar, 256);
                metadata[4] = new SqlMetaData("Source", SqlDbType.NVarChar, 256);
                metadata[5] = new SqlMetaData("UserName", SqlDbType.NVarChar, 256);
                metadata[6] = new SqlMetaData("Message", SqlDbType.NVarChar, -1);

                EventLog eLog = new EventLog(logtype);
                int logLength = eLog.Entries.Count;

                if (count == 0 || count > logLength)
                    count = logLength;

                pipe.Send("Processing " + count.ToString() + " of "
                    + logLength.ToString() + "entries");

                for (int i = logLength - 1; i >= 0; i--)
                {
                    record = buildRecord(metadata, eLog.Entries[i]);

                    if (i == logLength - 1)
                        pipe.SendResultsStart(record);
                    else
                        pipe.SendResultsRow(record);

                    if (count-- < 1)
                        break;
                }

                pipe.SendResultsEnd();
            }
        }     
    }
    private static SqlDataRecord buildRecord(SqlMetaData[] metadata, EventLogEntry entry)
    {
        SqlDataRecord record = new SqlDataRecord(metadata);

        record.SetSqlInt32(0, entry.Index);
        record.SetSqlInt64(1, entry.InstanceId);
        record.SetSqlDateTime(2, entry.TimeWritten);
        record.SetSqlString(3, entry.MachineName);
        record.SetSqlString(4, entry.Source);
        record.SetSqlString(5, entry.UserName);
        record.SetSqlString(6, entry.Message);

        return record;
    }
}
