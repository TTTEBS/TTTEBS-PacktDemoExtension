table 50105 "TTTEBS License"
{
    DataClassification = CustomerContent;
    Caption = 'License';

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    procedure ReadLicenseFromJson(license: Text)
    begin
    end;

    procedure WriteLicenseToJson(): Text
    begin
    end;
}