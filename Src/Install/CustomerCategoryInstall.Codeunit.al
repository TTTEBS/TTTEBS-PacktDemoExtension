codeunit 50104 "TTTEBS CustomerCategoryInstall"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        lv_ArchivedVersion: Text;
        lr_CustomerCategory: Record "TTTEBS CustomerCategory";
        lr_PacktSetup: Record "TTTEBS PacktExtensionSetup";
    begin
        lv_ArchivedVersion := NavApp.GetArchiveVersion();
        if lv_ArchivedVersion = '1.0.0.0' then begin 
            NavApp.RestoreArchiveData(Database::Customer);
            NavApp.RestoreArchiveData(Database::"TTTEBS CustomerCategory");
            NavApp.RestoreArchiveData(Database::"TTTEBS PacktExtensionSetup");
            NavApp.RestoreArchiveData(Database::"TTTEBS GiftCampaign");
            NavApp.RestoreArchiveData(Database::"TTTEBS VendorQuality");
            NavApp.DeleteArchiveData(Database::Customer);
            NavApp.DeleteArchiveData(Database::"TTTEBS CustomerCategory");
            NavApp.DeleteArchiveData(Database::"TTTEBS PacktExtensionSetup");
            NavApp.DeleteArchiveData(Database::"TTTEBS GiftCampaign");
            NavApp.DeleteArchiveData(Database::"TTTEBS VendorQuality");
        end;
        if lr_CustomerCategory.IsEmpty() then
            InsertDefaultCustomerCategory();
        if lr_PacktSetup.IsEmpty then
            InsertDefaultSetup();
    end;


    local procedure InsertDefaultCustomerCategory()
    begin
        InsertCustomerCategory('TOP', 'Top Customer', false);
        InsertCustomerCategory('MEDIUM', 'Standard Customer', true);
        InsertCustomerCategory('BAD', 'Bad Customer', false);
    end;

    local procedure InsertCustomerCategory(pID: code[30]; pDescription: Text[250]; pDefault: Boolean)
    var
        lr_CustomerCategory: Record "TTTEBS CustomerCategory";
    begin
        with lr_CustomerCategory do begin
            Init();
            No := pID;
            Description := pDescription;
            Default := pDefault;
            Insert();
        end;
    end;

    local procedure InsertDefaultSetup()
    var
        lr_PacktSetup: Record "TTTEBS PacktExtensionSetup";
    begin
        with lr_PacktSetup do begin
            Init();
            MinimumAcceptedVendorRate := 6;
            GiftToleranceQty := 2;
            Insert();
        end;
    end;
}