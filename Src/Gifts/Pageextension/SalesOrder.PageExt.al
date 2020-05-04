pageextension 50100 "TTTEBS SalesOrderPageExt" extends "Sales Order"
{
    actions
    {
        addlast(Processing)
        {
            action(AddFreeGifts)
            {
                Caption = 'Add Free Gifts';
                ToolTip = 'Adds Free Gifts to the current Sales Order based on active Campaigns';
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GiftMgt.AddGifts(Rec);
                end;
            }
        }        
    }
    var
        GiftMgt: Codeunit "TTTEBS GiftMgt";
}