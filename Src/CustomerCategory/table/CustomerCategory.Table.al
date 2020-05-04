table 50100 "TTTEBS CustomerCategory"
{
    Caption = 'TTTEBS CustomerCategory';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Default; Boolean)
        {
            Caption = 'Default';
            DataClassification = ToBeClassified;
        }
        field(4; EnableNewsletter; Enum "TTTEBS NewsletterType")
        {
            Caption = 'Enable Newsletter';
            DataClassification = CustomerContent;
        }
        field(5; FreeGiftsAvailable; Boolean)
        {
            Caption = 'Free Gifts Available';
            DataClassification = CustomerContent;
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(10; TotalCustomersForCategory; Integer)
        {
            Caption = 'No. of associated customers';
            FieldClass = FlowField;
            CalcFormula = count (Customer where ("TTTEBS CustomerCategoryCode" = field(No)));
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
        key(K2; Description)
        {
            Unique = true;
        }
    }
    
    procedure GetSalesAmount(): Decimal
    var
        CustomerCategoryMgt: Codeunit "TTTEBS CustomerCategoryMgt";
    begin
        exit(CustomerCategoryMgt.GetSalesAmount(Rec.No));        
    end;
}
