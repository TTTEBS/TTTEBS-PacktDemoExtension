codeunit 50115 "TTTEBS IsolatedStorageMgt"
{
    trigger OnRun()
    begin
        IsolatedStorageTest();
    end;

    local procedure IsolatedStorageTest()
    var
        KeyValue: Text;
    begin
        IsolatedStorage.Set('MyKey','MyValue', DataScope::Company);
        if IsolatedStorage.Contains('MyKey', DataScope::Company) then begin 
            IsolatedStorage.Get('MyKey', DataScope::Company, KeyValue);
            Message('Key value retrieved is = %1',KeyValue);
        end;
        IsolatedStorage.Delete('MyKey',DataScope::Company);
    end;


    procedure StoreLicense()
    var
        StorageKey: Text;
        LicenseText: Text;
        EncryptManagement: Codeunit "Cryptography Management";
        License: Record "TTTEBS License" temporary;
    begin
        StorageKey := GetStorageKey();
        LicenseText := License.WriteLicenseToJson();
        if EncryptManagement.IsEncryptionEnabled() and EncryptManagement.IsEncryptionPossible() then
            LicenseText := EncryptManagement.Encrypt(LicenseText);
        if IsolatedStorage.Contains(StorageKey, DataScope::Module) then
            IsolatedStorage.Delete(StorageKey);

        // message('Licensetext = %1', LicenseText);  // TEST
        if not EncryptionEnabled() then
            IsolatedStorage.Set(StorageKey, LicenseText, DataScope::Module)
        else
            IsolatedStorage.SetEncrypted(StorageKey, LicenseText, DataScope::Module);

        // TEST >>
        // if IsolatedStorage.Contains(StorageKey, DataScope::Module) then
        //     IsolatedStorage.Get(StorageKey, DataScope::Module, LicenseText);
        //     Message('Key value retrieved is  = %1\On MyKey %2', LicenseText, StorageKey);
        // TEST <<
    end;

    local procedure GetStorageKey(): Text
    var
        //Returns a GUID
        // StorageKeyTxt: Label 'dd03d28e-4acb-48d9-9520-c854495362b6',
        StorageKeyTxt: Label 'TEST01',
        Locked = true;
    begin
        exit(StorageKeyTxt);
    end;

    local procedure ReadLicense()
    var
        StorageKey: Text;
        LicenseText: Text;
        EncryptManagement: Codeunit "Cryptography Management";
        License: Record "TTTEBS License" temporary;
    begin
        StorageKey := GetStorageKey();
        if IsolatedStorage.Contains(StorageKey, DataScope::Module) then
            IsolatedStorage.Get(StorageKey, DataScope::Module, LicenseText);
        if EncryptManagement.IsEncryptionEnabled() and EncryptManagement.IsEncryptionPossible() then
            LicenseText := EncryptManagement.Decrypt(LicenseText);
        License.ReadLicenseFromJson(LicenseText);
    end;
}