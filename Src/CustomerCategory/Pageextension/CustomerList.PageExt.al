pageextension 50102 "TTTEBS CustomerListPageExt" extends "Customer List"
{
    actions
    {
        addlast(processing)
        { 
            action("Assign default category")
            {
                ApplicationArea = All;
                Image = ChangeCustomer;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Assign Default Category';
                ToolTip = 'Assign Default Category to the current Customer';
                
                trigger OnAction()
                var
                    CustCategoryMgt: Codeunit "TTTEBS CustomerCategoryMgt";
                begin
                    // CustCategoryMgt.AssignDefaultCategory(Rec."No.");
                    CustCategoryMgt.AssignDefaultCategory();
                end;
            }
        }
    }

    views
    {
        addlast
        {
            view(CustomersWithoutCategory)
            {
                Caption = 'Customers without Category assigned';
                Filters = where ("TTTEBS CustomerCategoryCode" = filter (''));
            }
        }
    }
}