codeunit 50107 "TTTEBS CreateTextFile"
{
    procedure CreateTextFile(pFileName: Text)
    var
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        CR: char;
        LF: char;
    begin
        CR := 13;
        LF := 10;
        TempBlob.CreateOutStream(OutStr);
        OutStr.WriteText('First line'+ CR + LF);
        OutStr.WriteText('Second line'+ CR + LF);
        OutStr.WriteText('Third line'+ CR + LF);
        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', pFileName);
    end;
}