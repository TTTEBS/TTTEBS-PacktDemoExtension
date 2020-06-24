codeunit 50109 "TTTEBS ImpExpCustMgt"
{
    procedure XmlImportCustomers()
    var
        FileInstream: InStream;
        FileName: Text;
    begin
        UploadIntoStream('', '', '', FileName,FileInstream);
        Xmlport.Import(Xmlport::"TTTEBS ImpExpCust2",FileInstream);
        Message('Import compleated!');
    end;

    procedure XmlExportCustomers()
    var
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        FileOutStream: OutStream;
        FileInStream: InStream;
        OutPutFileName: Text;
    begin
        TempBlob.CreateOutStream(FileOutStream);
        Xmlport.Export(Xmlport::"TTTEBS ImpExpCust2",FileOutStream);
        TempBlob.CreateInStream(FileInStream);
        OutPutFileName := 'OutputFile.csv';
        DownloadFromStream(FileInStream, '', '', '',OutPutFileName);  // Output file saved in browser folder..
    end;
}