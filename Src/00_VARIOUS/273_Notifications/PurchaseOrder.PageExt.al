pageextension 50106 "TTTEBS PurchaseOrderPageExt" extends "Purchase Order"
{
    trigger OnOpenPage()
    var
        lr_Vendor: record Vendor;
        lv_VendNotification: Notification;
        lv_OpenVendor: Text;
        lv_TextNotification: Label 'TTTEBS -> This Vendor has a balance due. Please check before sending orders!';
        lv_TextNotificationAction: Label 'Check balance due';
    begin
        lr_Vendor.Get("Buy-from Vendor No.");
        lr_Vendor.CalcFields("Balance Due");
        if lr_Vendor."Balance Due" > 0 then begin 
            lv_VendNotification.Message(lv_TextNotification);
            lv_VendNotification.Scope := NotificationScope::LocalScope;
            lv_VendNotification.SetData('VendorNo', lr_Vendor."No.");
            lv_VendNotification.AddAction(lv_TextNotificationAction, Codeunit::"TTTEBS ActionHandler", 'OpenVendor');
            lv_VendNotification.Send();
        end;
    end;
}