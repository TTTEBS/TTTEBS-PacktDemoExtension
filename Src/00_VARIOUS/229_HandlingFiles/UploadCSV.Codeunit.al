codeunit 50106 "TTTEBS UploadCSV"
{
    procedure UploadCSVCreateOrModifyItems(): Boolean
    var
        CSVBuffer: Record "CSV Buffer";
        Item: Record Item; 
        // TempBlob: Codeunit "Temp Blob";
        CSVInstream: InStream;
        UploadResult: Boolean;
        DialogCaption: Text;
        FileName: Text;
    begin
        if not Confirm('Import file with the following layout: "ItemNo";"Description";"ItemCategoryCode"',true) then
            exit(false);

        UploadResult := UploadIntoStream(DialogCaption, '', '', FileName, CSVInstream);
        CSVBuffer.DeleteAll();
        CSVBuffer.LoadDataFromStream(CSVInstream,';');
        if CSVBuffer.FindSet() then
            repeat
                if CSVBuffer."Field No." = 1 then
                    item.Init();
                case CSVBuffer."Field No." of
                    1: Item.Validate("No.", CSVBuffer.Value);
                    2: Item.Validate(Description, CSVBuffer.Value);
                    3: item.Validate("Item Category Code",CSVBuffer.Value);
                end;
                if not Item.Insert() then
                    item.Modify();
            until CSVBuffer.Next() = 0;
        exit(true);
    end;
}