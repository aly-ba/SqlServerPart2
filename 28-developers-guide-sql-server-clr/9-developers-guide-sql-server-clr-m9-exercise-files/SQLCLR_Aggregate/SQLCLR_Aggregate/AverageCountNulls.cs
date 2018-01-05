using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedAggregate(Format.UserDefined, MaxByteSize = 100)]
public struct AverageCountNulls : IBinarySerialize
{
    private decimal totalAmount;
    private int totalCount;

    public void Init()
    {
        totalAmount = 0m;
        totalCount = 0;
    }

    public void Accumulate([SqlFacet(Precision = 18, Scale = 6)] SqlDecimal Value)
    {
        totalAmount += Value.IsNull ? 0m : Value.Value;
        totalCount++;
    }

    public void Merge (AverageCountNulls Group)
    {
        totalAmount += Group.totalAmount;
        totalCount += Group.totalCount;
    }

    [return: SqlFacet(Precision = 10, Scale = 6)]
    public SqlDecimal Terminate()
    {
        decimal result = totalCount == 0 ? 0m : totalAmount / totalCount;
        return new SqlDecimal(result);
    }

    public void Read(System.IO.BinaryReader reader)
    {
        totalAmount = reader.ReadDecimal();
        totalCount = reader.ReadInt32();
    }

    public void Write(System.IO.BinaryWriter writer)
    {
        writer.Write(totalAmount);
        writer.Write(totalCount);
    }
}
