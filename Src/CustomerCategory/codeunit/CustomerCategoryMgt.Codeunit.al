codeunit 50101 "TTTEBS CustomerCategoryMgt"
{
   procedure CreateDefaultCategory()
   var
       lr_CustCategory: Record "TTTEBS CustomerCategory";
   begin
       with lr_CustCategory do begin
           No := 'DEFAULT';
           Description := 'Default Customer Category';
           Default := true;
           if Insert() then;
       end;
   end; 

   procedure AssignDefaultCategory(pCustomerCode: Code[20])
   var
        lr_Cust: Record Customer;
        lr_CustCategory: Record "TTTEBS CustomerCategory";
   begin
       // Set default category for a customer..
       lr_Cust.get(pCustomerCode);
       lr_CustCategory.SetRange(Default,true);
       if lr_CustCategory.FindFirst() then begin 
           lr_Cust."TTTEBS CustomerCategoryCode" := lr_CustCategory.No;
           lr_Cust.Modify();
       end;
   end;
   
   procedure AssignDefaultCategory()    // TTTEBS -> Note function name is the same as previous - We use overloading!
   var
        lr_Cust: Record Customer;
        lr_CustCategory: Record "TTTEBS CustomerCategory";
   begin
       // Set default category for all customers..
       lr_CustCategory.SetRange(Default,true);
       if lr_CustCategory.FindFirst() then begin 
           lr_Cust.SetFilter("TTTEBS CustomerCategoryCode", '%1', '');
           lr_Cust.ModifyAll("TTTEBS CustomerCategoryCode",lr_CustCategory.No);
       end;
   end;

    procedure GetTotalCustomersWithoutCategory(): Integer
    var
        lr_Cust: Record Customer;
    begin
        // Returns the number of Customers without an assigned Customer Category
        lr_Cust.SetRange("TTTEBS CustomerCategoryCode", '');
        exit(lr_Cust.Count());        
    end;

    procedure GetSalesAmount(pCustCategoryCode: Code[20]): Decimal
    var
        lr_SL: Record "Sales Line";
        lr_Cust: Record Customer;
        v_TotalAmount: Decimal;
    begin
        
        with lr_Cust do begin 
            SetCurrentKey("TTTEBS CustomerCategoryCode");
            SetRange("TTTEBS CustomerCategoryCode",pCustCategoryCode);
            if FindSet() then begin
                repeat
                    lr_SL.SetRange("Document Type",lr_SL."Document Type"::Order);
                    lr_SL.SetRange("Sell-to Customer No.","No.");
                    if lr_SL.FindSet() then
                        repeat
                            v_TotalAmount += lr_SL."Line Amount";
                        until lr_SL.Next() = 0;
                until Next() = 0;
                exit(v_TotalAmount);
            end;
        end;
    end;
}
