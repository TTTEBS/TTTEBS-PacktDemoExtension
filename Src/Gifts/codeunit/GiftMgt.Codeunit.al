codeunit 50102 "TTTEBS GiftMgt"
{
    procedure AddGifts(var SalesHeader: Record "Sales Header")
    var
        SalesLine: record "Sales Line";
        Handled: Boolean;
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);

        // We exclude the generated gifts lines in order to avoid loops
        SalesLine.SetFilter("Line Discount %", '<>100');
        if SalesLine.FindSet() then
            repeat
                OnBeforeFreeGiftSalesLineAdded(SalesLine, Handled);  // Integration event raised
                AddFreeGiftSalesLine(SalesLine, Handled);
                OnAfterFreeGiftSalesLineAdded(SalesLine);  // Integration Event raised
            until SalesLine.Next() = 0;
    end;

    local procedure AddFreeGiftSalesLine(var SalesLine: Record "Sales Line"; var Handled: Boolean)
        var
            GiftCampaign: Record "TTTEBS GiftCampaign";
            SalesHeader: record "Sales Header";
            Customer: Record Customer;
            SalesLineGift: Record "Sales Line";
            LineNo: Integer;
        begin
            if Handled then
            exit;

            SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
            Customer.Get(SalesLine."Sell-to Customer No.");

            GiftCampaign.SetRange(CustomerCategoryCode, Customer."TTTEBS CustomerCategoryCode");
            GiftCampaign.SetRange(ItemNo, SalesLine."No.");
            GiftCampaign.SetFilter(StartingDate, '<=%1', SalesHeader."Order Date");
            GiftCampaign.SetFilter(EndingDate, '>=%1', SalesHeader."Order Date");
            GiftCampaign.SetRange(Inactive, false);
            GiftCampaign.SetFilter(MinimumOrderQuantity, '<= %1', SalesLine.Quantity);
            if GiftCampaign.FindFirst() then begin
                // Active promo found. We need to insert a new Sales Line
                LineNo := GetLastSalesDocumentLineNo(SalesHeader);
                SalesLineGift.init;
                SalesLineGift.TransferFields(SalesLine);
                SalesLineGift."Line No." := LineNo + 10000;
                SalesLineGift.Validate(Quantity, GiftCampaign.GiftQuantity);
                SalesLineGift.Validate("Line Discount %", 100);
                if SalesLineGift.Insert() then;
            end;
        end;

    local procedure GetLastSalesDocumentLineNo(SalesHeader: Record "Sales Header"): Integer
        var
            SalesLine: Record "Sales Line";
        begin
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.FindLast() then
                exit(SalesLine."Line No.")
            else
                exit(0);
        end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure CheckGiftEligibility(var Rec: Record "Sales Line")
    var
        GiftCampaign: Record "TTTEBS GiftCampaign";
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        Handled: Boolean;
    begin
        if (Rec.Type = Rec.Type::Item) and (Customer.Get(Rec."Sell-to Customer No.")) then begin
            SalesHeader.Get(Rec."Document Type", Rec."Document No.");
            GiftCampaign.SetRange(CustomerCategoryCode, Customer."TTTEBS CustomerCategoryCode");
            GiftCampaign.SetRange(ItemNo, Rec."No.");
            GiftCampaign.SetFilter(StartingDate, '<=%1', SalesHeader."Order Date");
            GiftCampaign.SetFilter(EndingDate, '>=%1', SalesHeader."Order Date");
            GiftCampaign.SetRange(Inactive, false);
            GiftCampaign.SetFilter(MinimumOrderQuantity, '> %1', Rec.Quantity);
            if GiftCampaign.FindFirst() then begin
                OnBeforeFreeGiftAlert(Rec, Handled);  // Integration event raised
                DoGiftCheck(Rec, GiftCampaign, Handled);
                OnAfterFreeGiftAlert(Rec);  // Integration Event raised
            end;
        end;
    end;

    local procedure DoGiftCheck(var SalesLine: Record "Sales Line"; var GiftCampaign: Record "TTTEBS GiftCampaign"; var Handled: Boolean)
    var
        PacktSetup: record "TTTEBS PacktExtensionSetup";
        GiftAlert: Label 'Attention: there is an active promotion for item %1. if you buy %2 you can have a gift of %3';
    begin
        if Handled then
            exit;

        PacktSetup.Get();
        if (SalesLine.Quantity < GiftCampaign.MinimumOrderQuantity) and 
            (GiftCampaign.MinimumOrderQuantity - SalesLine.Quantity <= PacktSetup."GiftToleranceQty") then
            Message(GiftAlert, SalesLine."No.", Format(GiftCampaign.MinimumOrderQuantity), Format(GiftCampaign.GiftQuantity));
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeFreeGiftSalesLineAdded(var Rec: Record "Sales Line"; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterFreeGiftSalesLineAdded(var Rec: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeFreeGiftAlert(var Rec: Record "Sales Line";
    var 
        Handled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterFreeGiftAlert(var Rec: Record "Sales Line")
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterItemLedgerEntryInsert(var Rec: Record "Item Ledger Entry")
    var
        Customer: Record Customer;
    begin
        if rec."Entry Type" = rec."Entry Type"::Sale then begin
            if Customer.Get(Rec."Source No.") then begin
                Rec."TTTEBS CustomerCategoryCode" := Customer."TTTEBS CustomerCategoryCode";
                Rec.Modify();
            end;
        end;
    end;
}
