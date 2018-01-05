using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using System.Text;

public partial class Triggers
{
    private const int RECORDID = 0;
    private const int NEW_COLOR = 1;
    private const int ORIGINAL_COLOR = 2;
    private const int NEW_SIZE = 3;
    private const int ORIGINAL_SIZE = 4;

    private const int COLOR_FIELD_POSITION = 3;
    private const int SIZE_FIELD_POSITION = 6;

    private const int EMPTY_STRINGBUILDER = 0;

    [SqlTrigger(Name = "SampleTrigger", Target = "SalesLT.Product", Event = "FOR UPDATE")]
    public static void SampleTrigger ()
    {
        using (SqlConnection conn = new SqlConnection("context connection=true"))
        {
            conn.Open();
            using (SqlCommand curUserCmd = new SqlCommand("SELECT system_user", conn))
            {
                string theUserName = curUserCmd.ExecuteScalar().ToString();
                SqlContext.Pipe.Send("Update trigger fired by user " + theUserName);
            }
            using (SqlCommand joinCmd = new SqlCommand())
            {
                joinCmd.Connection = conn;
                joinCmd.CommandText = "SELECT i.ProductID, " +
                    "ISNULL(i.Color, 'null') AS Color, ISNULL(d.Color, 'null') AS OldColor, " +
                    "ISNULL(i.Size, 'null') AS Size, ISNULL(d.Size, 'null') as OldSize " +
                    "FROM INSERTED i " +
                    "JOIN DELETED d ON i.ProductID = d.ProductID";

                SqlDataReader dr;
                dr = joinCmd.ExecuteReader();

                StringBuilder sb = new StringBuilder();

                while (dr.Read())
                {   sb.Length = EMPTY_STRINGBUILDER;

                    if (SqlContext.TriggerContext.IsUpdatedColumn(COLOR_FIELD_POSITION) &&
                        dr[ORIGINAL_COLOR].ToString() != dr[NEW_COLOR].ToString())
                        sb.AppendFormat("RecordId {0}:\n  {1} changed from {2} to {3}",
                            dr[RECORDID],
                            dr.GetName(NEW_COLOR),
                            dr[ORIGINAL_COLOR],
                            dr[NEW_COLOR]);
                    if (SqlContext.TriggerContext.IsUpdatedColumn(SIZE_FIELD_POSITION) &&
                        dr[ORIGINAL_SIZE].ToString() != dr[NEW_SIZE].ToString())
                    {
                        if (sb.Length == EMPTY_STRINGBUILDER)
                        {
                            sb.AppendFormat("RecordId {0}:\n", dr[RECORDID]);
                        }
                        else
                        {
                            sb.Append("\n");
                        }

                        sb.AppendFormat("  {0} changed from {1} to {2}",
                                dr.GetName(NEW_SIZE),
                                dr[ORIGINAL_SIZE],
                                dr[NEW_SIZE]);
                    }
                    if (sb.Length == EMPTY_STRINGBUILDER)
                        sb.AppendFormat("RecordId {0} had no color or size changes", dr[RECORDID]);

                    SqlContext.Pipe.Send(sb.ToString());
                }
                dr.Close();
                dr.Dispose();
            }
        }
    }
}

