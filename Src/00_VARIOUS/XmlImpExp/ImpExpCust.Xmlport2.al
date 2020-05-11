xmlport 50101 "TTTEBS ImpExpCust2"
{
    // Direction = Export;
    Format = VariableText;
    FieldSeparator = ';';
    RecordSeparator = '<LF>';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Customer; Customer)
            {
                
                fieldattribute(No; Customer."No.")
                {
                }
                fieldattribute(Name; Customer.Name)
                {
                }
                fieldattribute(Address; Customer.Address)
                {
                }
                fieldattribute(City; Customer.City)
                {
                }
                fieldattribute(County; Customer.County)
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
