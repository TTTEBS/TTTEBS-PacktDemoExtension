query 50100 CustomerView01
{
    QueryType = Normal;

    elements
    {
        dataitem(customer; customer)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(SalesLCY; "Sales (LCY)")
            {
            }
            column(ProfitLCY; "Profit (LCY)")
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(City; City)
            {
            }
            column(SalespersonCode; "Salesperson Code")
            {
            }
            dataitem(SalespersonPurchaser; "Salesperson/Purchaser")
            {
                DataItemLink = Code = customer."Salesperson Code";
                column(SalesPersonName; Name)
                {
                }
                dataitem(CountryRegion; "Country/Region")
                {
                    DataItemLink = Code = customer."Country/Region Code";
                    column(CountryName; Name)
                    {
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
