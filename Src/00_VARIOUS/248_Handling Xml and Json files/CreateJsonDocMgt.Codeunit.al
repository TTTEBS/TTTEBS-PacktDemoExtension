codeunit 50111 "TTTEBS CreateJsonDocMgt"
{
    procedure CreateJsonOrder(pOrderNo: Code[20])
    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        JsonObjHeader: JsonObject;
        JsonObjLines: JsonObject;
        JsonArrayHeader: JsonArray;
        JsonArrayLines: JsonArray;

        // WRITE TO FILE >>
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        FileName: Text;
        String: Text;
        CR: char;
        LF: char;
        CRLF: Text;
        // WRITE TO FILE <<
    begin
        // WRITE TO FILE >>
        CR := 13;
        LF := 10;
        CRLF := Format(CR) + Format(LF);
        TempBlob.CreateOutStream(OutStr);
        // WRITE TO FILE <<

        // Retrieves the Sales Header..
        SH.Get(SH."Document Type"::Order, pOrderNo);
        FileName := SH."No." + '.json';

        // Create the Json header details..
        JsonObjHeader.Add('SalesOrder_No', SH."No.");
        JsonObjHeader.Add('BillToCustomerNo', SH."Bill-to Customer No.");
        JsonObjHeader.Add('BillToName', SH."Bill-to Name");
        JsonObjHeader.Add('OrderDate', SH."Order Date");
        JsonArrayHeader.Add(JsonObjHeader);

        // // WRITE TO FILE >>
        JsonArrayHeader.WriteTo(String);
        OutStr.WriteText('01_' + String + CRLF);
        // // WRITE TO FILE <<

        // Retrieves the Sales Lines..
        SL.SetRange("Document Type",SL."Document Type"::Order);
        SL.SetRange("Document No.",SH."No.");
        if SL.FindSet() then begin 
            // JsonObject Init..
            JsonObjLines.Add('LineNo', '');
            JsonObjLines.Add('ItemNo', '');
            JsonObjLines.Add('Description', '');
            JsonObjLines.Add('LocationCode', '');
            JsonObjLines.Add('Quantity', '');
            repeat
                JsonObjLines.Replace('LineNo',SL."Line No.");
                JsonObjLines.Replace('ItemNo',SL."No.");
                JsonObjLines.Replace('Description',SL.Description);
                JsonObjLines.Replace('LocationCode',SL."Location Code");
                JsonObjLines.Replace('Quantity',SL.Quantity);
                JsonArrayLines.Add(JsonObjLines);

                // WRITE TO FILE >>
                JsonArrayLines.WriteTo(String);
                OutStr.WriteText('02_' + String + CRLF);
                // WRITE TO FILE <<

            until SL.Next() = 0;
            JsonArrayHeader.add(JsonArrayLines);

            // WRITE TO FILE >>
            JsonArrayHeader.WriteTo(String);
            OutStr.WriteText('03_' + String + CRLF);
            // WRITE TO FILE <<
        end;

        // WRITE TO FILE >>
        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', FileName);
        // WRITE TO FILE <<
    end;
}