/*
Author: ToxaBes
Description: calculate decimal azimuth for artillery gunner
*/
while {true} do {
    waitUntil {player != vehicle player && player == gunner vehicle player && getNumber (configfile >> "CfgVehicles" >> typeOf (vehicle player) >> "artilleryScanner") == 1};
    titleRsc["ArtilleryHUD", "PLAIN", -1, false];
    _ctrl = uiNamespace getVariable ['ArtilleryHud', controlNull];
    _hud = _ctrl displayCtrl 20000;
    while {player != vehicle player && player == gunner vehicle player} do {
        _vehicle = vehicle player;
        _dirArray = _vehicle weaponDirection (currentWeapon _vehicle);
        _posPlayer = ATLToASL positionCameraToWorld [0,0,0];
        _posDistant = ATLToASL positionCameraToWorld [0,0,100000];
        if !([] isEqualTo lineIntersectsSurfaces [_posPlayer, _posDistant, player, _vehicle, true, 1, "VIEW", "NONE"]) then {
            _dirArray = positionCameraToWorld [0,0,0] vectorFromTo positionCameraToWorld [0,0,10];
        };
        _dir = (_dirArray select 0) atan2 (_dirArray select 1);
        if (_dir < 0) then {
        	_dir = _dir + 360;
        };
        _dir = round (_dir * 1.00001 * 10 ^ 2) / 10 ^ 2;
        _hud ctrlSetText format["%1", _dir];
    };
    titleText["", "PLAIN"];
};
