page 50101 "TTTEBS CustomerCategoryCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "TTTEBS CustomerCategory";
    Caption = 'Customer Category Card';
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; No)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Default; Default)
                {
                    ApplicationArea = All;
                }
                field(EnableNewsletter; EnableNewsletter)
                {
                    ApplicationArea = All;
                }
                field(FreeGiftsAvailable; FreeGiftsAvailable)
                {
                    ApplicationArea = All;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                field(TotalCustomersForCategory; TotalCustomersForCategory)
                {
                    ApplicationArea = All;
                }
                field(TotalSalesAmount; v_TotalSalesAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Sales Order Amount';
                    Editable = false;
                    Style = Strong;
                }

            }
        }
    }
    
    var
        v_TotalSalesAmount: Decimal;
        
    trigger OnAfterGetRecord()
    begin
        v_TotalSalesAmount := Rec.getSalesAmount();        
    end;
}
