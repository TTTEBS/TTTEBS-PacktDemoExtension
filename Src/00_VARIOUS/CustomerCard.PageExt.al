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
        // 256_Consuming web service and API >>
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                TranslationMgt: Codeunit "TTTEBS TranslationMgt";
            begin
                if Name.EndsWith('.com') then begin 
                    if Confirm('Do you want to retrieve company details?', false) then
                        TranslationMgt.LookupAddressInfo(Name,Rec);
                end;
            end;   
        }
        // 256_Consuming web service and API <<
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