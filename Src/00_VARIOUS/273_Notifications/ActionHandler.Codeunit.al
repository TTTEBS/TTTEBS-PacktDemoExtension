codeunit 50116 "TTTEBS ActionHandler"
{
    procedure OpenVendor(pNotification: Notification)
    var
        lr_Vendor: Record Vendor;
        lp_VendorCard: Page "Vendor Card";
        lv_VendCode: Text;
    begin
        lv_VendCode := pNotification.GetData('VendorNo');
        if lr_Vendor.Get(lv_VendCode) then begin
            lp_VendorCard.SetRecord(lr_Vendor);
            lp_VendorCard.Run();
        end;
    end;
}
