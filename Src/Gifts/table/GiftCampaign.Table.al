table 50102 "TTTEBS GiftCampaign"
{
    Caption = 'TTTEBS GiftCampaign';
    DataClassification = ToBeClassified;
    // DrillDownPageId = "Gift Campaign List_PKT";
    // LookupPageId = "Gift Campaign List_PKT";
    
    fields
    {
        field(1; CustomerCategoryCode; Code[20])
        {
            Caption = 'CustomerCategoryCode';
            DataClassification = CustomerContent;
            TableRelation = "TTTEBS CustomerCategory";
            trigger OnValidate()
            var
                CustomerCategory: Record "TTTEBS CustomerCategory";
                ErrNoGifts: Label 'This category is not enabled for Gift Campaigns.';
                ErrBlocked: Label 'This category is blocked.';
            begin
                CustomerCategory.Get(CustomerCategoryCode);
                if CustomerCategory.Blocked then
                    Error(ErrBlocked);
                if not CustomerCategory.FreeGiftsAvailable then
                    Error(ErrNoGifts);
            end;
        }
        field(2; ItemNo; Code[20])
        {
            Caption = 'ItemNo';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(3; StartingDate; Date)
        {
            Caption = 'StartingDate';
            DataClassification = CustomerContent;
        }
        field(4; EndingDate; Date)
        {
            Caption = 'EndingDate';
            DataClassification = CustomerContent;
        }
        field(5; MinimumOrderQuantity; Decimal)
        {
            Caption = 'MinimumOrderQuantity';
            DataClassification = CustomerContent;
        }
        field(6; GiftQuantity; Decimal)
        {
            Caption = 'GiftQuantity';
            DataClassification = CustomerContent;
        }
        field(7; Inactive; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        key(PK; CustomerCategoryCode, ItemNo, StartingDate, EndingDate)
        {
            Clustered = true;
        }
    }
    
}
