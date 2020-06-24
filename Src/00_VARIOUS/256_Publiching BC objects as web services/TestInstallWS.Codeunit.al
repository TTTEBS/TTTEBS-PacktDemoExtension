// Method 1: (Virker ikke?)
codeunit 50113 "TTTEBS TestInstallWSCodeunit"
{
    Subtype = Install;
    
    trigger OnInstallAppPerCompany()
    var
        TWS: Record "Tenant Web Service";
    begin
        TWS.Init();
        TWS."Object Type" := TWS."Object Type"::Page;
        TWS."Object ID" := 26;  // Vendor Card
        TWS."Service Name" := 'VendorCardWS1';
        TWS.Published := true;
        if TWS.Insert(true) then;
    end;
}