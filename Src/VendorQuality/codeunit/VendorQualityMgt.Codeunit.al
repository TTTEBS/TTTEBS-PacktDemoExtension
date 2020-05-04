codeunit 50103 "TTTEBS VendorQualityMgt"
{
    procedure CalculateVendorRate(var pVendorQuality: Record "TTTEBS VendorQuality")
    var
        Handled: Boolean;
    begin
        OnBeforeCalculateVendorRate(pVendorQuality,Handled);  // Eventint
        VendorRateCalculation(pVendorQuality,Handled);
        OnAfterCalculateVendorRate(pVendorQuality);  // EventInt
    end;

    local procedure VendorRateCalculation(var pVendorQuality: Record "TTTEBS VendorQuality"; var Handled: Boolean)
    begin
        if Handled then
            exit;
        pVendorQuality.Rate := (pVendorQuality.ScoreDelivery + pVendorQuality.ScoreItemQuality + pVendorQuality.ScorePackaging + pVendorQuality.ScorePricing) / 4;        
    end;

    procedure UpdateVendorQualityStatistic(var pVendorQuality: Record "TTTEBS VendorQuality")
    var
        Year: Integer;
        DW: Dialog;
        DialogMessage: label 'Calculating vendor statistic..';
    begin
        DW.Open(DialogMessage);
        Year := Date2DMY(Today, 3);
        pVendorQuality.InvoicedYearN := GetInvoicedAmount(pVendorQuality."Vendor No.", DMY2Date(1,1,Year), Today);
        pVendorQuality.InvoicedYearN1 := GetInvoicedAmount(pVendorQuality."Vendor No.", DMY2Date(1,1,Year - 1), Today);
        pVendorQuality.InvoicedYearN2 := GetInvoicedAmount(pVendorQuality."Vendor No.", DMY2Date(1,1,Year - 2), Today);
        pVendorQuality.DueAmount := GetDueAmount(pVendorQuality."Vendor No.", false);
        DW.Close();
    end;

    local procedure GetInvoicedAmount(pVendorNo: code[20]; pStartDato: Date; pEndDate: Date): Decimal
    var
        lr_VLE: Record "Vendor Ledger Entry";
        lv_Total: Decimal;
    begin
        lr_VLE.SetRange("Vendor No.",pVendorNo);
        lr_VLE.SetFilter("Document Date", '%1..%2', pStartDato, pEndDate);
        if lr_VLE.FindSet() then
            repeat
                lv_Total += lr_VLE."Purchase (LCY)";
            until lr_VLE.Next() = 0;
        exit(lv_Total * (-1));
    end;

    local procedure GetDueAmount(pVendorNo: code[20]; pDue: Boolean): Decimal
    var
        lr_VLE: Record "Vendor Ledger Entry";
        lv_Total: Decimal;
    begin
        lr_VLE.SetRange("Vendor No.",pVendorNo);
        lr_VLE.SetRange(Open,true);
        if pDue then
            lr_VLE.SetFilter("Due Date", '< %1', Today)
        else
            lr_VLE.SetFilter("Due Date", '> %1', Today);
        lr_VLE.SetAutoCalcFields("Remaining Amt. (LCY)");
        if lr_VLE.FindSet() then
            repeat
                lv_Total += lr_VLE."Remaining Amt. (LCY)";
            until lr_VLE.Next() = 0;
        exit(lv_Total * (-1));
    end;


    // SubscriberEvent..
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeManualReleasePurchaseDoc', '', false, false)]
    local procedure QualityCheckForReleasingPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        lr_VendorQuality: Record "TTTEBS VendorQuality";
        lr_PacktSetup: Record "TTTEBS PacktExtensionSetup";
        ErrNoMinimumRate: Label 'Vendor %1 has a rate of %2 and it''s under the required minimum value (%3)';
    begin
        lr_PacktSetup.Get();
        if lr_VendorQuality.Get(PurchaseHeader."Buy-from Vendor No.") then 
            if lr_VendorQuality.Rate < lr_PacktSetup.MinimumAcceptedVendorRate then
                Error(ErrNoMinimumRate, PurchaseHeader."Buy-from Vendor No.", Format(lr_VendorQuality.Rate), Format(lr_PacktSetup.MinimumAcceptedVendorRate));
    end;


    // IntegrationEvents..
    [IntegrationEvent(true, false)]
    local procedure OnBeforeCalculateVendorRate(var pVendorQuality: Record "TTTEBS VendorQuality"; var pHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterCalculateVendorRate(var pVendorQuality: Record "TTTEBS VendorQuality")
    begin
    end;
}