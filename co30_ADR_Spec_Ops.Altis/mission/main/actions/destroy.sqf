/*
Author: ToxaBes
Description: destroy avanpost
*/
#define ENEMY_SIDE EAST
private ["_player", "_stance", "_raised", "_weapon", "_object", "_points"];
_player = _this select 1;

// Determine what animation to play
// If player is prone play kneeling animation
_stance = "Pknl";
_raised = "Sras";
_weapon = "Wrfl";

if (stance _player == "STAND") then {
    _stance = "Perc";
};
if (weaponLowered _player) then {
    _raised = "Slow";
};
call {
    if ((currentWeapon _player == handgunWeapon _player) and (handgunWeapon _player != "")) exitWith {
        _weapon = "Wpst";
    };
    if ((currentWeapon _player == secondaryWeapon _player) and (secondaryWeapon _player != "")) exitWith {
        _weapon = "Wlnr";
    };
    if (currentWeapon _player == "") exitWith {
        _raised = "Snon";
        _weapon = "Wnon";
    };
};

// Play animation
_player playMove ("Ainv" + _stance + "Mstp" + _raised + _weapon + "Dnon_Putdown_Amov" + _stance + "Mstp" + _raised + _weapon + "Dnon");

sleep 1;
_object = _this select 0;
[_object,"QS_fnc_removeAction",nil,true] spawn BIS_fnc_MP;
_points = 10;
MAIN_AO_SUCCESS = true; publicVariable "MAIN_AO_SUCCESS";
[_object,"green","green","green"] call BIS_fnc_DataTerminalColor;
[_object, 0] call BIS_fnc_dataTerminalAnimate;
["ScoreBonus", ["Аванпост противника уничтожен!", _points]] remoteExec ["BIS_fnc_showNotification", _player];
[_player, _points] remoteExec ["addScore", 2];
_c4Message = selectRandom [
    "Аванпост заминирован. У вас полторы минуты чтобы найти укрытие!",
    "Аванпост будет уничтожен через 90 секунд. Валите оттуда!"
];
hqSideChat = _c4Message; publicVariable "hqSideChat"; 
[west, "HQ"] sideChat _c4Message;
[resistance, "HQ"] sideChat _c4Message;

// destroy avanpost
[_object] spawn {
    _object = _this select 0;
    _pos = getPos _object;    
    sleep 90;
    "Bo_GBU12_LGB" createVehicle _pos;
    _allObjects = nearestObjects [_object, [], 30];
    {
        if !(_x isKindOf "Man") then {
            if (typeOf _x == "B_Quadbike_01_F") then {
                _av_bike = _x getVariable ["AVANPOST_BIKE", false];
                if (_av_bike) then {
                    _x setVariable ["AVANPOST_DESTROYED", true];
                };
            };
            _x allowDamage true;
            _x enableSimulation true;
            _x setDamage 1;
        };
    } forEach _allObjects;
    "Bo_GBU12_LGB" createVehicle _pos;
    deleteVehicle _object;
};
[AVANPOST_COORDS] spawn {
    _coords = _this select 0;
    sleep 120;
    _allObjects = nearestObjects [_coords, ["B_Quadbike_01_F"], 40];
    {
        hideObjectGlobal _x;
    } forEach _allObjects;
};

//hide respawn place
AVANPOST_COORDS = false; publicVariable "AVANPOST_COORDS";
AVANPOST_RESPAWN = false; publicVariable "AVANPOST_RESPAWN";