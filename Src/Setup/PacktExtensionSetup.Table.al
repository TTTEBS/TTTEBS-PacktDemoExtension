table 50101 "TTTEBS PacktExtensionSetup"
{
    Caption = 'TTTEBS PacktExtensionSetup';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; MinimumAcceptedVendorRate; Decimal)
        {
            Caption = 'Minimum Accepted Vendor Rate';
            DataClassification = CustomerContent;
        }
        field(3; GiftToleranceQty; Decimal)
        {
            Caption = 'Gift Tolerance Quantity for Sales';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
    
}
