page 50103 "TTTEBS GiftCampaignList"
{
    
    PageType = List;
    SourceTable = "TTTEBS GiftCampaign";
    Caption = 'Gift Campaign List';
    ApplicationArea = All;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'promotions, marketing, TTTEBS';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CustomerCategoryCode; CustomerCategoryCode)
                {
                    ApplicationArea = All;
                }
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = All;
                }
                field(StartingDate; StartingDate)
                {
                    ApplicationArea = All;
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = All;
                }
                field(MinimumOrderQuantity; MinimumOrderQuantity)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(GiftQuantity; GiftQuantity)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Inactive; Inactive)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    views
    { 
        view(ActiveCampaigns)
        {
            Caption = 'Active Gift Campaigns';
            Filters = where(Inactive = const(false));
        }
        view(InActiveCampaigns)
        {
            Caption = 'Inactive Gift Campaigns';
            Filters = where(Inactive = const(true));
        }
    } 
}
