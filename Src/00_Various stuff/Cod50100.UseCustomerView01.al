codeunit 50100 UseCustomerView01
{
    procedure UseCustomerView()
    var
        CustViewQuery: Query CustomerView01;
    begin
        if not CustViewQuery.Open() then
            exit;
        while CustViewQuery.Read() do begin
            // Here we have all joined records from the query to loop..
        end;
    end;
}
