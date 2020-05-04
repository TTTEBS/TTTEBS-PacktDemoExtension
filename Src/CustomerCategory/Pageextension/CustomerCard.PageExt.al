pageextension 50101 "TTTEBS CustomerCardPageExt" extends "Customer Card"
{
    layout
    {
        addlast(General)
        { 
            field("Customer Category";"TTTEBS CustomerCategoryCode")
            {
                ToolTip = 'Customer Category';
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        addlast("F&unctions")
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
                    CustCategoryMgt.AssignDefaultCategory(Rec."No.")
                end;
            }
        }
    }
}