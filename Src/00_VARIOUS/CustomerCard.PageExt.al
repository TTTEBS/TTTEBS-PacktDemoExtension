pageextension 50101 "TTTEBS CustomerCardPageExt" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Customer Category"; "TTTEBS CustomerCategoryCode")
            {
                ToolTip = 'Customer Category';
                ApplicationArea = All;
            }
            // 276_BackGroundTask >>
            field(SalesAmount; v_SalesAmount)
            {
                ApplicationArea = All;
                Caption = 'Sales Amount';
                Editable = false;
                StyleExpr = 'Favorable';
            }
            field(NoOfSales; v_NoOfSales)
            {
                ApplicationArea = All;
                Caption = 'No. of Sales';
                Editable = false;
                StyleExpr = 'Favorable';
            }
            field(NoOfItemsShipped;v_NoOfItemsShipped)
            {
                ApplicationArea = All;
                Caption = 'No. Of Items Shipped';
                Editable = false;
                StyleExpr = 'Favorable';
            }
            // 276_BackGroundTask <<
        }
        // 256_Consuming web service and API >>
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                TranslationMgt: Codeunit "TTTEBS TranslationMgt";
            begin
                if Name.EndsWith('.com') then begin
                    if Confirm('Do you want to retrieve company details?', false) then
                        TranslationMgt.LookupAddressInfo(Name, Rec);
                end;
            end;
        }
        // 256_Consuming web service and API <<
    }
    actions
    {
        addlast("F&unctions")
        {
            action("Assign default category")
            {
                ApplicationArea = All;
                Image = ChangeCustomer;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Assign Default Category';
                ToolTip = 'Assign Default Category to the current Customer';

                trigger OnAction()
                var
                    CustCategoryMgt: Codeunit "TTTEBS CustomerCategoryMgt";
                begin
                    CustCategoryMgt.AssignDefaultCategory(Rec."No.")
                end;
            }
        }
    }
    // 276_BackGroundTask >>
    var
        v_TaskSalesID: Integer;
        v_SalesAmount: Decimal;
        v_NoOfSales: Decimal;
        v_NoOfItemsShipped: Decimal;

    trigger OnAfterGetCurrRecord()
    var
        TaskParameters: Dictionary of [Text, Text];
    begin
        TaskParameters.Add('CustomerNo', Rec."No.");
        CurrPage.EnqueueBackgroundTask(v_TaskSalesId, 50117, TaskParameters, 20000, PageBackgroundTaskErrorLevel::Warning);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        PBTNotification: Notification;
    begin
        if (TaskId = v_TaskSalesId) then begin
            Evaluate(v_SalesAmount, Results.Get('TotalSales'));
            Evaluate(v_NoOfSales, Results.Get('NoOfSales'));
            Evaluate(v_NoOfItemsShipped, Results.Get('NoOfItemsShipped'));
            PBTNotification.Message('TTTEBS - Sales Statistics updated (with Background Task)');
            PBTNotification.Send();
        end;
    end;

    trigger OnPageBackgroundTaskError(pTaskId: Integer; pErrorCode: Text; pErrorText: Text; pErrorCallStack: Text; var pIsHandled: Boolean)
    var
        PBTNotification: Notification;
    begin
        if pErrorText = 'Invalid parameter CustomerNo' then begin 
            pIsHandled := true;
            PBTNotification.Message('Something went wrong! Invalid parameter CustomerNo.');
            PBTNotification.Send();
        end else
            if pErrorText = 'Child Session task was terminated because of a timeout.' then begin 
                pIsHandled := true;
                PBTNotification.Message('It took to long to get results. Try again.');
                PBTNotification.Send();
            end;
    end;
    // 276_BackGroundTask <<
}