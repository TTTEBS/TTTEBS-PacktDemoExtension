codeunit 50114 "TTTEBS AzureFuncMgt"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Post Code', false, false)]
    local procedure ValidatePostCodeViaAzureFunc(var Rec: Record Customer)
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Json: Text;
        JsonObj: JsonObject;
        Token: JsonToken;
        FunctionURL: Label 'http://postcodevalidator.azurewebsites.net/api/postcodevalidator?code=';
        InvalidResponseError: Label 'Invalid Response from Azure Function.';
        InvalidCodeError: Label 'Invalid Post Code. Please reinsert.';
        TokenNotFoundError: Label 'Token not found in Json.';
    begin
        Client.Get(FunctionURL + rec."Post Code", Response);

        //Reads the response content from the Azure Function
        Response.Content().ReadAs(json);
        if not jsonObj.ReadFrom(json) then
            Error(InvalidResponseError);
        
        //Retrieves the JSon token from the response
        if not jsonObj.Get('IsValid',token) then
            Error(TokenNotFoundError);

        //Convert the Json token to a Boolean value. is TRUE the post code is valid.
        if not token.AsValue().AsBoolean() then
            Error(InvalidCodeError);      
    end;
}

// Other solutions:
// FunctionURL: Label 'https://api.bring.com/pickuppoint/api/postalCode/DKK/getCityAndType/{postalCode}.json';
//