report 50100 "TTTEBS ILEAnalysis"
{
    Caption = 'Item Ledger Entry Analysis';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    UseRequestPage = true;

    // DefaultLayout = RDLC;
    DefaultLayout = Word;

    WordLayout = '.\Src\00_VARIOUS\289_Reports\ILEAnalysis.docx';
    RDLCLayout = '.\Src\00_VARIOUS\289_Reports\ILEAnalysis.rdl';

    // Speciel - See dataset:
    // Open Layout in ReportBuilder, and choose Table -> Table Wizzard -> Dataset x2 Click -> Mark All fields -> Insert in Values
    // When Running Report - Save data to Excel..    
    // RDLCLayout = '.\Src\00_VARIOUS\289_Reports\ILEAnalysisDATASET.rdl';

    dataset
    {
        dataitem(FirstLine; Integer)

        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;

            column(Company; CompanyName)
            {
            }
            column(Picture_companyinfo; r_CompanyInfo.Picture)
            {
            }
            column(DateToday; Format(Today))
            {
            }
            column(FilterSet; v_FilterSetText)
            {
            }
        }
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(ItemNo; "Item No.")
            {
                IncludeCaption = true;
            }
            column(PostingDate; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(EntryType; "Entry Type")
            {
                IncludeCaption = true;
            }
            column(EntryNo; "Entry No.")
            {
                IncludeCaption = true;
            }
            column(DocumentNo; "Document No.")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(LocationCode; "Location Code")
            {
                IncludeCaption = true;
            }
            column(Quantity; Quantity)
            {
                IncludeCaption = true;
            }
            column(CustomerCategoryCode;"TTTEBS CustomerCategoryCode")
            {
                IncludeCaption = true;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(IncludeLogo;v_IncludeLogo)
                    {
                        Caption = 'Include company logo';
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    // TTTEBS - If no translation is needed, use this one insted of - var -> labels.
    labels
    {
        PageLBL = 'Page', Comment = 'Foo', MaxLength = 999, Locked = true;
        HeadLineLBL = 'Item Ledger Entry Analysis';
    }

    var
    r_CompanyInfo: Record "Company Information";
    v_FilterSet: Text[250];
    v_FilterSetText: Text[250];
    v_IncludeLogo: Boolean;

    trigger OnPreReport()
    begin
        if v_IncludeLogo then begin
            r_CompanyInfo.Get();
            r_CompanyInfo.CalcFields(Picture);
        end;

        v_FilterSet := ItemLedgerEntry.GetFilters();
        IF v_FilterSet <> '' then
            v_FilterSetText := 'Filters: ' + v_FilterSet;
    end;
}
