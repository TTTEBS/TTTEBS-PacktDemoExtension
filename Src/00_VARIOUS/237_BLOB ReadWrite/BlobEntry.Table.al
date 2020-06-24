table 50104 "TTTEBS BlobEntry"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1;ID; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; BlobField; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    procedure SetBlobValue(value: Text)
    var
        outStr: OutStream;
    begin
        BlobField.CreateOutStream(outStr);
        outStr.WriteText(value);
    end;

    procedure GetBlobValue(value: Text)
    var
        inStr: InStream;
        v_Filename: Text;
    begin
        CalcFields(BlobField);
        if BlobField.HasValue() then begin
            BlobField.CreateInStream(inStr,TextEncoding::Windows);
            inStr.ReadText(value);
            v_Filename := 'Test.txt';
            DownloadFromStream(inStr, '', '', '', v_Filename);
        end else
            value := 'No value on the BLOB field';
    end;
}