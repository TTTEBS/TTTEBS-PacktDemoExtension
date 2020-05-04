page 50102 "TTTEBS PacktExtensionSetupCard"
{
    
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "TTTEBS PacktExtensionSetup";
    Caption = 'Packt Extension Setup Card';
    
    layout
    {
        area(content)
        {
            group(General)
            {
                field(MinimumAcceptedVendorRate; MinimumAcceptedVendorRate)
                {
                    ApplicationArea = All;
                    ToolTip = 'If "Vendor Quality" - Rate < "Packt Setup" - "Minimum Accepted Vendor Rate", then error when release purchase document.';
                }
                field(GiftToleranceQty; GiftToleranceQty)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
