tableextension 50100 "TTTEBS CustomerTableExt" extends Customer
{
    fields
    {
        field(50100; "TTTEBS CustomerCategoryCode"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "TTTEBS CustomerCategory".No;
            Caption = 'Customer Category Code';

            trigger OnValidate()
            var
                lr_CustCategory: Record "TTTEBS CustomerCategory";
                ErrBlocked: Label 'This Category is Blocked!';
            begin
                lr_CustCategory.Get("TTTEBS CustomerCategoryCode");
                if lr_CustCategory.Blocked then
                    Error(ErrBlocked);
            end;
        }
    }

    keys
    {
        key(CustomerCategory; "TTTEBS CustomerCategoryCode")
        {
        }
    }
}