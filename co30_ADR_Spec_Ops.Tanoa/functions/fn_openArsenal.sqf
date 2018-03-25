/*
Author: ToxaBes
Description: open arsenal whitelisted per player
*/
private ["_myBox"];
_myBox = _this select 0;
_player = _this select 1;
_type = typeOf _player;

_removeWeapons = _myBox call BIS_fnc_getVirtualWeaponCargo;
[_myBox, _removeWeapons, false] call BIS_fnc_removeVirtualWeaponCargo;

_removeMagazines = _myBox call BIS_fnc_getVirtualMagazineCargo;
[_myBox, _removeMagazines, false] call BIS_fnc_removeVirtualMagazineCargo;

_removeBackpacks = _myBox call BIS_fnc_getVirtualBackpackCargo;
[_myBox, _removeBackpacks, false] call BIS_fnc_removeVirtualBackpackCargo;

_removeItems = _myBox call BIS_fnc_getVirtualItemCargo;
[_myBox, _removeItems, false] call BIS_fnc_removeVirtualItemCargo;

if (_type == "B_T_Helipilot_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\pilot.sqf";
};

if (_type == "B_T_Soldier_SL_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\commander.sqf";
};

if (_type == "B_T_Medic_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\medic.sqf";
};

if (_type == "B_T_Soldier_AR_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\support.sqf";
};

if (_type == "B_T_Engineer_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\engineer.sqf";
};

if (_type == "B_T_Soldier_AT_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\antitank.sqf";
};

if (_type == "B_T_soldier_M_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\marksman.sqf";
};

if (_type == "B_T_Sniper_F") then {
    [_myBox] call compile preProcessFileLineNumbers "scripts\arsenal\sniper.sqf";
};

[_myBox] spawn {
    _myBox = _this select 0;
    sleep 5;
    _myBox removeAction (_myBox getvariable ['bis_fnc_arsenal_action', -1]);
    _myBox setvariable ['bis_fnc_arsenal_action', nil];
};

['Open', [false, _myBox, _player]] call BIS_fnc_arsenal;