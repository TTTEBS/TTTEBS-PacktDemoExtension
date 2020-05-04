tableextension 50101 "TTTEBS ItemLedgerEntryTableExt" extends "Item Ledger Entry"
{
    fields
    {
        field(50100; "TTTEBS CustomerCategoryCode"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "TTTEBS CustomerCategory".No;
            Caption = 'Customer Category Code';
        }
    }
    
    keys
    { 
        key(FK; "TTTEBS CustomerCategoryCode")
        {
        }
    }
}