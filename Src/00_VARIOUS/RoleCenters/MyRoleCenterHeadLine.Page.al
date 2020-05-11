page 50108 "TTTEBS MyRoleCenterHeadLine"
{
    PageType = HeadlinePart;

    layout
    { 
        area(Content)
        { 
            field(HeadLine1; txtHeadLine1)
            {
                ApplicationArea = all;
            }
            field(HeadLine2; msgHeadLine2)
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    DrillDownURL: label 'http://www.telosteam.dk/';
                begin
                    Hyperlink(DrillDownURL);
                end;
            }
            field(HeadLine3; msgHeadLine3)
            {
                ApplicationArea = all;
            }
            field(HeadLine4; msgHeadLine4)
            {
                ApplicationArea = all;
                Visible = ShowHesadLine4;  // Determines visibility while the page is open..
            }
        }
    }

    var
        HeadLineMgt: Codeunit "TTTEBS HeadLineMgt";
        msgHeadLine1: Label 'This is HeadLine 1';    
        msgHeadLine2: Label 'This is HeadLine 2 (Click for details)';    
        msgHeadLine3: Label 'This is HeadLine 3';    
        msgHeadLine4: Label 'This is HeadLine 4';
        ShowHesadLine4: Boolean;
        txtHeadLine1: Text;

    trigger OnOpenPage()
        begin 
            txtHeadLine1 := HeadLineMgt.Emphasize(msgHeadLine1) + ' ' + 'And some more text..';
        end;
}