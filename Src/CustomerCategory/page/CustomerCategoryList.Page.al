page 50100 "TTTEBS CustomerCategoryList"
{
    PageType = List;
    SourceTable = "TTTEBS CustomerCategory";
    Caption = 'Customer Category List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "TTTEBS CustomerCategoryCard";
    AdditionalSearchTerms = 'ranking, categorization, TTTEBS';
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field(TotalCustomersForCategory; TotalCustomersForCategory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Customers for Category';
                }
            }
        }
    }

    actions
    { 
        area(Processing)
        { 
            action(CreateDefaultCategory)
            {
                ApplicationArea = All;
                Image = CreateForm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create default category';
                Caption = 'Create default category';

                trigger OnAction()
                var
                    CustManagement: Codeunit "TTTEBS CustomerCategoryMgt";
                begin
                    CustManagement.CreateDefaultCategory();
                end;
            }
        }
    }    
}