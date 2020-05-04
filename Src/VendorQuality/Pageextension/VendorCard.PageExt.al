pageextension 50103 "TTTEBS VendorCardPageExt" extends "Vendor Card"
{
    actions
    {
        addafter(Comment)
        {
            action(QualityClassification)
            {
                ApplicationArea = All;
                Caption = 'Quality Classification';
                Image = QualificationOverview;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "TTTEBS Vendor Quality Card";
                RunPageLink = "Vendor No." = field("No.");
            }
        }
    }
}