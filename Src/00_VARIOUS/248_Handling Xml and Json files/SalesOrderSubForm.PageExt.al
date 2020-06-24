pageextension 50104 "TTTEBS SalesOrderSubForm" extends "Sales Order Subform"
{
    actions
    {
        addlast("F&unctions")
        { 
            action(CreateJSON)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                var
                    CreateJsonDocMgt: Codeunit "TTTEBS CreateJsonDocMgt";
                begin
                    CreateJsonDocMgt.CreateJsonOrder("Document No.");
                    message('Json created!');
                end;
            }
        }
    }
}