codeunit 50105 "TTTEBS ExportPicture"
{
    procedure ExportItemPicture(pItem: Record Item): Boolean
    var
        TenantMedia: Record "Tenant Media";
        TenantMediaSet: Record "Tenant Media Set";
        FileInStream: InStream;
        Filename: Text;
        i: Integer;
        ErrMsg: Label 'No images stored for the selected item.';
    begin
        if pItem.Picture.Count() = 0 then
            Error(ErrMsg);
        
        for i := 1 to pItem.Picture.Count() do
            begin
                // CORRECTION >>
                // if TenantMedia.Get(pItem.Picture.MediaId()) then begin  // Not working - Will newer get in here - wrong ID?..
                // if TenantMedia.Get('{edfdcc8b-e3aa-4866-94ff-0823d3ad6724}') then begin  // dummy testing - working!
                TenantMediaSet.SetRange(ID,pItem.Picture.MediaId());
                if TenantMediaSet.FindFirst() then
                // CORRECTION <<
                    if TenantMedia.Get(Format(TenantMediaSet."Media ID")) then begin  // Not working - Will newer get in here - wrong ID?..
                        // message('Item SystemID = %1\\Tenant Media Set:\ID = %2\MediaID = %3',pItem.Picture.MediaId(),TenantMediaSet.ID,TenantMediaSet."Media ID");  // TEST
                        TenantMedia.CalcFields(Content);
                        if TenantMedia.Content.HasValue() then begin 
                            Filename := pItem."No." + '_' + Format(i) + GetImageExtension(TenantMedia);
                            TenantMedia.Content.CreateInStream(FileInStream);
                            DownloadFromStream(FileInStream, '', '', '', Filename);
                            exit(true);
                        end;
                    end;
            end;
    end;    

    procedure GetImageExtension(var pTenantMedia: Record "Tenant Media"): Text
    begin
        case pTenantMedia."Mime Type" of
            'image/jpeg': exit('.jpg');
            'image/bmp': exit('.bmp');
            'image/png': exit('.png');
            'image/gif': exit('.gif');
            'image/tiff': exit('.tiff');
            'image/wmf': exit('.wmf');
        end;
    end;
}