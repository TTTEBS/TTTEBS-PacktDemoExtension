page 50107 "TTTEBS MyRoleCenter"
{
    
    PageType = RoleCenter;
    Caption = 'TTTEBS MyRoleCenter';
    
    layout
    {
        area(RoleCenter)
        {
            part(HeadLine; "TTTEBS MyRoleCenterHeadLine")
            { 
                ApplicationArea = All;
                Visible = true;
            }
            part(SalesPerformance; "Sales Performance")
            { 
                ApplicationArea = All;
                Visible = true;
            }
            part(MyCustomers; "My Customers")
            { 
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
}
