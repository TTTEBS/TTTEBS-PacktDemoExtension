init();
var controlAddinX = document.getElementById('controlAddIn');
controlAddinX.innerHTML = 'This is our D365BC control addin';
Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ControlReady2", []);