page 50109 "TTTEBS License"
{
    
    ApplicationArea = All;
    Caption = 'TTTEBS License';
    PageType = List;
    SourceTable = "TTTEBS License";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
}
