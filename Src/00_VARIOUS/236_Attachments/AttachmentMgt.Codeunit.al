codeunit 50108 "TTTEBS AttachmentMgt"
{
    procedure UploadAttachment()
    var
        Attachment: Record Attachment;
        FileMgt: Codeunit "File Management";
        outStr: OutStream;
        inStr: InStream;
        tempfilename: text;
        DialogTitle: Label 'Please select a File...';
    begin
        if UploadIntoStream(DialogTitle, '', 'All Files (*.*)|*.*', tempfilename, inStr) then begin
            Attachment.Init();
            Attachment.Insert(true);
            Attachment."Storage Type" := Attachment."Storage Type"::Embedded;
            Attachment."Storage Pointer" := '';
            Attachment."File Extension" := FileMgt.GetExtension(tempfilename);
            Attachment."Attachment File".CreateOutStream(outStr);
            CopyStream(outStr, inStr);
            Attachment.Modify(true);
        end;
    end;

    procedure OpenAttachment(AttachmentEntryNo: Integer)
    var
        Attachment: record Attachment;
        inStr: InStream;
        tempfilename: text;
        ErrorAttachment: Label 'File not available.';
    begin
        if Attachment.get(AttachmentEntryNo) then
            if Attachment."Attachment File".HasValue then begin
                Attachment.CalcFields("Attachment File");
                Attachment."Attachment File".CreateInStream(inStr);
                tempfilename := CreateGuid() + '.' + Attachment."File Extension";
                DOWNLOADFROMSTREAM(inStr, 'Save file', '', 'All Files(*.*)|*.*', tempfilename);
            end else
                Error(ErrorAttachment);
    end;
}