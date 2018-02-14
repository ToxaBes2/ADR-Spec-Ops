/*
Author: Osef (modified by ToxaBes)
Description: show FPS status bar
*/
_showFPS = "ShowFPS" call BIS_fnc_getParamValue;
if (_showFPS == 1) then {
    [] spawn {
        while {true} do {
            sleep 5;
            if (isNull (uiNamespace getVariable ["statusBar", displayNull] displayCtrl 51200)) then {
                disableSerialization;
                _rscLayer = "statusBar" call BIS_fnc_rscLayer;
                _rscLayer cutRsc ["statusBar","PLAIN"];
            };
            _clientFPS = round diag_fps;
            _serverFPS = 0;
            _hc1FPS = 0;
            _hc2FPS = 0;
            if !(isNil "SERVER_FPS") then {
                _serverFPS = SERVER_FPS;
            };
            if !(isNil "HC1_FPS") then {
                _hc1FPS = HC1_FPS;
            };
            if !(isNil "HC2_FPS") then {
                _hc2FPS = HC2_FPS;
            };
            _text = format["<t shadow='1' color='#B3B3B3'>FPS -> Server: %1  |  Headless Client 1: %2  |  Headless Client 2: %3 |  Client: %4</t>", _serverFPS, _hc1FPS, _hc2FPS, _clientFPS];
            (uiNamespace getVariable ["statusBar", displayNull] displayCtrl 51200) ctrlSetStructuredText (parseText _text);
        }; 
    };
};