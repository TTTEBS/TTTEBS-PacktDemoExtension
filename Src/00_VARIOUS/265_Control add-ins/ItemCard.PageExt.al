pageextension 50105 "TTTEBS ItemCardPageExt" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            group(AddinGroup)
            {
                Caption = 'Control Add-in';

                usercontrol(DemoAddin; DemoD365BCAddin)
                {
                    ApplicationArea = All;

                    trigger ControlReady2()
                    begin
                        CurrPage.DemoAddin.HelloWorld2();
                    end;
                }
            }
        }
    }
}