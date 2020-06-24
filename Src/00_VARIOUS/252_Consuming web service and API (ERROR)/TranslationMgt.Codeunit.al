codeunit 50112 "TTTEBS TranslationMgt"
{
    procedure LookupAddressInfo(pName: Text; var pCustomer: Record Customer)
    var
        Client: HttpClient;
        Content: HttpContent;
        ResponceMessage: HttpResponseMessage;
        Result: Text;
        JContent: JsonObject;
        JDetails: JsonObject;
        JLocations: JsonArray;
        JLocation: JsonObject;
        JPhones: JsonArray;
        JPhone: JsonObject;
    begin
        Content.WriteFrom('{domain":"' + pName + '"}');
        // Client.DefaultRequestHeaders().Add('Authorization', 'Bearer <wCAheBpIEYYcPZksECsVH37KkwHAONb5>');
        // Client.DefaultRequestHeaders().Add('Authorization', 'Bearer {wCAheBpIEYYcPZksECsVH37KkwHAONb5}');
        // Client.DefaultRequestHeaders().Add('Authorization', 'Bearer":" wCAheBpIEYYcPZksECsVH37KkwHAONb5');
        // Client.DefaultRequestHeaders().Add('Authorization', 'Bearer: wCAheBpIEYYcPZksECsVH37KkwHAONb5');
        Client.DefaultRequestHeaders().Add('Authorization', 'Bearer wCAheBpIEYYcPZksECsVH37KkwHAONb5');
        Client.Post('https://api.fullcontact.com/v3/company.enrich',Content, ResponceMessage);
        if not ResponceMessage.IsSuccessStatusCode() then
            Error('Error connecting to the web service!');
        ResponceMessage.Content().ReadAs(Result);
        if not JContent.ReadFrom(Result) then
            Error('Invalid responce from web service!');
        JDetails := GetTokenAsObject(JContent, 'details', 'Invalid responce from web service');
        JLocations := GetTokenAsArray(JDetails, 'locations', 'No locations available');
        JLocation := GetArrayElementAsObject(JLocations, 0, 'Locations not available');
        JPhones := GetTokenAsArray(JDetails, 'phones', '');
        JPhone := GetArrayElementAsObject(JPhones, 0, '');

        pCustomer.Name := GetTokenAsText(JContent, 'name', '');
        pCustomer.Address := GetTokenAsText(JLocation, 'addressLine1', '');
        pCustomer.City := GetTokenAsText(JLocation, 'city', '');
        pCustomer."Post Code" := GetTokenAsText(JLocation, 'postalcode', '');
        pCustomer."Country/Region Code" := GetTokenAsText(JLocation, 'countrycode', '');
        pCustomer.County := GetTokenAsText(JLocation, 'country', '');
        pCustomer."Phone No." := GetTokenAsText(JLocation, 'value', '');
    end;


    procedure GetTokenAsText(pJsonObject: JsonObject; pTokenKey: Text; pError: Text): Text;
    var
        lJsonToken: JsonToken;
    begin
        if not pJsonObject.Get(pTokenKey, lJsonToken) then begin 
            if pError <> '' then
                Error(pError);
            exit(lJsonToken.AsValue().AsText());
        end;
    end;


    procedure GetTokenAsObject(pJsonObject: JsonObject; pTokenKey: Text; pError: Text): JsonObject;
    var
        lJsonToken: JsonToken;
    begin 
        if not pJsonObject.Get(pTokenKey, lJsonToken) then begin 
            if pError <> '' then
                Error(pError);
            exit(lJsonToken.AsObject());
        end;
    end;


    procedure GetTokenAsArray(pJsonObject: JsonObject; pTokenKey: Text; pError: Text): JsonArray;
    var
        lJsonToken: JsonToken;
    begin 
        if not pJsonObject.Get(pTokenKey, lJsonToken) then begin 
            if pError <> '' then
                Error(pError);
            exit(lJsonToken.AsArray());
        end;
    end;


    procedure GetArrayElementAsObject(pJsonArray: JsonArray; pIndex: Integer; pError: Text): JsonObject;
    var
        lJsonToken: JsonToken;
    begin 
        if not pJsonArray.Get(pIndex, lJsonToken) then begin 
            if pError <> '' then
                Error(pError);
            exit(lJsonToken.AsObject());
        end;
    end;
}
