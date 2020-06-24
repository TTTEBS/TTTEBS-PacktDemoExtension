page 50106 "TTTEBS BlobEntryList"
{
    PageType = List;
    SourceTable = "TTTEBS BlobEntry";
    Caption = 'Blob Entry List';
    ApplicationArea = All;
    UsageCategory = Lists;
    AutoSplitKey = true;
    DelayedInsert = true;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(BlobField; BlobField)
                {
                    ApplicationArea = All;
                }
                field(BlobFieldHasValue; BlobField.HasValue())
                {
                    ApplicationArea = All;
                    Caption = 'Blob Field Has Value';
                    Editable = false;
                    ToolTip = 'Specifies if the Blob field Has Value.';
                }
            }
        }
    }
    actions
    { 
        area(Processing)
        {
            action(SetBlobValue)
            {
                ApplicationArea = All;
                Caption = 'Set BLOB value';
                
                trigger OnAction()
                begin
                    if confirm('Add value to BLOB from field "Description"',true) then
                        SetBlobValue(Description);
                end;
            }
            action(GetBlobValue)
            {
                ApplicationArea = All;
                Caption = 'Get BLOB value';
                
                trigger OnAction()
                begin
                    GetBlobValue(Description);
                end;
            }
        }
    }
}
