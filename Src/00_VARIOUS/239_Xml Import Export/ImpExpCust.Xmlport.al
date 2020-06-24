xmlport 50100 "TTTEBS ImpExpCust"
{
    // Direction = Export;
    Format = VariableText;
    FieldSeparator = ';';
    // RecordSeparator = '<LF>';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Customer; Customer)
            {
                fieldelement(No; Customer."No.")
                {
                }
                fieldelement(Name; Customer.Name)
                {
                }
                fieldelement(Address; Customer.Address)
                {
                }
                fieldelement(City; Customer.City)
                {
                }
                fieldelement(County; Customer.County)
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
