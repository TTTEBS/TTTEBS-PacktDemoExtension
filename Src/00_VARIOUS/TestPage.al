page 50105 TestPage
{
    
    PageType = Card;
    SourceTable = Integer;
    Caption = 'TestPage';
    Editable = false;
    SourceTableView = sorting(Number) order(ascending) where(Number = filter(1));
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    AdditionalSearchTerms = 'TestPage, FileTreatment, TTTEBS';

    actions
    {
        area(Processing)
        { 
            action(ExportItemPicture)
            {
                ApplicationArea = All;
                Caption = 'Export Item Picture';

                trigger OnAction()
                var
                    ExportPicture: Codeunit "TTTEBS ExportPicture";
                    Item: Record Item;
                begin
                    Item.SetRange("No.",'1896-S');
                    if Item.FindSet() then
                        repeat
                            if ExportPicture.ExportItemPicture(Item) then
                                Message('Item Picture %1 exported!',Item."No.");
                        until Item.Next() = 0;
                end;
            }
            action(UploadCSVCreateOrModifyItems)
            {
                ApplicationArea = All;
                Caption = 'Upload CSV to Create/Modify Items';

                trigger OnAction()
                var
                    UploadCSV: Codeunit "TTTEBS UploadCSV";
                begin
                    if UploadCSV.UploadCSVCreateOrModifyItems() then
                        Message('CSV file uploaded!');
                end;
            }
            action(CreateTextFile)
            {
                ApplicationArea = All;
                Caption = 'Create Text File';

                trigger OnAction()
                var
                    CreateTextFile: Codeunit "TTTEBS CreateTextFile";
                begin
                    CreateTextFile.CreateTextFile('TestFil.txt');
                end;
            }
            group(Attachment)
            {
                Caption = 'Attachment';
                action(UploadAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'Upload Attachment';

                    trigger OnAction()
                    var
                        AttachmentMgt: Codeunit "TTTEBS AttachmentMgt";
                    begin
                        AttachmentMgt.UploadAttachment();
                    end;
                }
                action(OpenAttachment)
                {
                    ApplicationArea = All;
                    Caption = 'Open Attachment';

                    trigger OnAction()
                    var
                        AttachmentMgt: Codeunit "TTTEBS AttachmentMgt";
                    begin
                        AttachmentMgt.OpenAttachment(2);
                    end;
                }
            }
            group(Blob)
            {
                Caption = 'Blob';
                action(BlobEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Blob Entries';

                    trigger OnAction()
                    var
                        BlobEntryList: Page "TTTEBS BlobEntryList";                        
                    begin
                        BlobEntryList.Run();
                    end;
                }
            }
            group(XmlImpExp)
            {
                Caption = 'Xml Import Export';
                action(XmlExpCust)
                {
                    ApplicationArea = All;
                    Caption = 'Export Customers';

                    trigger OnAction()
                    var
                        ImpExpCustMgt: Codeunit "TTTEBS ImpExpCustMgt";
                    begin
                        ImpExpCustMgt.XmlExportCustomers();
                    end;
                }
                action(XmlImpCust)
                {
                    ApplicationArea = All;
                    Caption = 'Import Customers';

                    trigger OnAction()
                    var
                        ImpExpCustMgt: Codeunit "TTTEBS ImpExpCustMgt";
                    begin
                        ImpExpCustMgt.XmlImportCustomers();
                    end;
                }
            }
        }
    }
}
