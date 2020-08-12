controladdin DemoD365BCAddin
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 250;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 'ControlAddIns/Scripts/main.js';
    StyleSheets = 'ControlAddIns/CSS/stylesheet.css';
    StartupScript = 'ControlAddIns/Scripts/start.js';
    Images = 'ControlAddIns/Images/Avatar.png';

    event ControlReady2()

    procedure HelloWorld2()
}