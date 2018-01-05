using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Text;

[Serializable]
[SqlUserDefinedType(Format.UserDefined, MaxByteSize = 100)]
public struct UDTCatalog : INullable, IBinarySerialize
{
    [SqlFacet(Precision = 10, Scale = 2)]
    public decimal listPrice { get; set; }
    public int catVersion { get; set; }
    public int discountPlan { get; set; }
    public bool IsNull { get; private set; }

#region Constants
    //  Output string sample: $100.00;1;1;$50.00 (listPrice,catVersion,discountPlan,currentPrice)
    private const string TOSTRING_FORMAT = "{0:C};{1};{2};{3:C} " +
                                           "(listPrice;catVersion;discountPlan;currentPrice)";

    private const int DEFAULT_CATALOG_VERSION = 1;
    private const int DEFAULT_DISCOUNT_PLAN = 1;
    private const int MAX_CATALOG_VERSION = 4;
    private const decimal DEFAULT_LIST_PRICE = 0m;

    private const int PARSE_LIST_PRICE = 1;
    private const int PARSE_CATALOG_VERSION = 2;
    private const int PARSE_DISCOUNT_PLAN = 3;

    private const int CATALOG_VERSION_1 = 1;
    private const int CATALOG_VERSION_2 = 2;
    private const int CATALOG_VERSION_3 = 3;
    private const int CATALOG_VERSION_4 = 4;

    private const decimal CATALOG_MULTIPLIER_1 = 1m;                            //  Base Price
    private const decimal CATALOG_MULTIPLIER_2 = CATALOG_MULTIPLIER_1 * 1.05m;  //  5% increase
    private const decimal CATALOG_MULTIPLIER_3 = CATALOG_MULTIPLIER_2 * 1.05m;  //  5% increase
    private const decimal CATALOG_MULTIPLIER_4 = CATALOG_MULTIPLIER_3 * 1.1m;   //  10% increase

    private const int DISCOUNT_PLAN_1 = 1;
    private const int DISCOUNT_PLAN_2 = 2;
    private const int DISCOUNT_PLAN_3 = 3;
    private const int DISCOUNT_PLAN_4 = 4;

    private const decimal DISCOUNT_PLAN_MULTIPLIER_1 = .5m;                                // 50% off
    private const decimal DISCOUNT_PLAN_MULTIPLIER_2 = DISCOUNT_PLAN_MULTIPLIER_1 * .9m;   // 10% off
    private const decimal DISCOUNT_PLAN_MULTIPLIER_3 = DISCOUNT_PLAN_MULTIPLIER_2 * .95m;  // 5% off
    private const decimal DISCOUNT_PLAN_MULTIPLIER_4 = DISCOUNT_PLAN_MULTIPLIER_3 * .95m;  // 5% off
#endregion

    public override string ToString()
    {
        return new StringBuilder()
            .AppendFormat(TOSTRING_FORMAT,
                listPrice,
                catVersion,
                discountPlan,
                currentPrice)
            .ToString();
    }
    
    public static UDTCatalog Null
    {
        get { return new UDTCatalog { IsNull = true }; }
    }

    [SqlMethod(OnNullCall = false)]
    public static UDTCatalog Parse(SqlString strInput)
    {
        UDTCatalog localCatalog = new UDTCatalog
        {
            IsNull = false,
            listPrice = DEFAULT_LIST_PRICE,
            catVersion = DEFAULT_CATALOG_VERSION,
            discountPlan = DEFAULT_DISCOUNT_PLAN
        };

        try
        {
            string[] values = strInput.ToString().Split(';');
            if (values.Length >= PARSE_LIST_PRICE &&
                values[PARSE_LIST_PRICE - 1] != String.Empty)
                localCatalog.listPrice = Decimal.Parse(values[PARSE_LIST_PRICE - 1],
                                        System.Globalization.NumberStyles.Any);

            if (values.Length >= PARSE_CATALOG_VERSION &&
                values[PARSE_CATALOG_VERSION - 1] != String.Empty)
                localCatalog.catVersion = int.Parse(values[PARSE_CATALOG_VERSION - 1]);


            if (values.Length >= PARSE_DISCOUNT_PLAN &&
                values[PARSE_DISCOUNT_PLAN - 1] != String.Empty)
                localCatalog.discountPlan = int.Parse(values[PARSE_DISCOUNT_PLAN - 1]);
        }
        catch (Exception e)
        {
            throw new ArgumentException("Invalid Catalog value: " + strInput.ToString() +
                                        "\n" + e.Message);
        }
        return localCatalog;
    }

    [SqlFacet(Precision = 10, Scale = 2)]
    public decimal currentPrice
    {
        get
        {
            decimal result = listPrice;

            switch (catVersion)
            {
                case CATALOG_VERSION_1:
                    result = result * CATALOG_MULTIPLIER_1;
                    break;

                case CATALOG_VERSION_2:
                    result = result * CATALOG_MULTIPLIER_2;
                    break;

                case CATALOG_VERSION_3:
                    result = result * CATALOG_MULTIPLIER_3;
                    break;

                case CATALOG_VERSION_4:
                    result = result * CATALOG_MULTIPLIER_4;
                    break;
            }

            switch (discountPlan)
            {
                case DISCOUNT_PLAN_1:
                    result = result * DISCOUNT_PLAN_MULTIPLIER_1;
                    break;

                case DISCOUNT_PLAN_2:
                    result = result * DISCOUNT_PLAN_MULTIPLIER_2;
                    break;

                case DISCOUNT_PLAN_3:
                    result = result * DISCOUNT_PLAN_MULTIPLIER_3;
                    break;

                case DISCOUNT_PLAN_4:
                    result = result * DISCOUNT_PLAN_MULTIPLIER_4;
                    break;
            }
            return result;
        }
    }

    [SqlMethod(IsMutator = true)]
    public void IncrementCatalogVersion()
    {
        if (!this.IsNull && this.catVersion < MAX_CATALOG_VERSION)
        {
            this.catVersion++;
        }
    }

    public void Read(System.IO.BinaryReader reader)
    {
        this.IsNull = false;
        catVersion = reader.ReadInt32();
        listPrice = reader.ReadDecimal();
        discountPlan = reader.ReadInt32();
    }

    public void Write(System.IO.BinaryWriter writer)
    {
        writer.Write(catVersion);
        writer.Write(listPrice);
        writer.Write(discountPlan);
    }
}