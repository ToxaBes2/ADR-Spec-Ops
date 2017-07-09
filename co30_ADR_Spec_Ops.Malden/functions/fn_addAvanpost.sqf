/*
Author: ToxaBes
Desciption: deploy partizan avanpost from mobile truck
*/
_campPos = _this select 0;
_camp = [_campPos, resistance, (configfile >> "CfgGroups" >> "Empty" >> "Guerrilla" >> "Camps" >> "CampC")] call BIS_fnc_spawnGroup;
_campFires = nearestObjects [_campPos, ["Land_Campfire_F", "Campfire_burning_F"], 5];
{
    _x inflame true;
} forEach _campFires;
_domes = [];
for "_x" from 1 to 4 do {
    _tentDome = createVehicle ["Land_TentDome_F", _campPos, [], 6, "NONE"];
    _domes pushBack _tentDome;
    _tentDome = nil;
};
_comm = createVehicle ["Land_PowerGenerator_F", _campPos, [], 7, "NONE"];
_comm setDamage 0.5;
_comm enableRopeAttach false;
_names = ["ALPHA","BRAVO","CHARLIE","DELTA","ECHO","FOXTROT","GOLF","HOTEL","INDIA","JULIET","KILO","LIMA","MIKE","NOVEMBER","OSCAR","PAPA","QUEBEC","ROMEO","SIERRA","TANGO","UNIFORM","VICTOR","WHISKY","X-RAY","YANKEE","ZULU"];
_name = "";
_newName = "";
{
	_name = _x;
	if (_newName == "") then {
	    if !(_name in AVANPOST_PARTIZAN_RESPAWN) then {
            _newName = _name;
        };
	};    	
} forEach _names;
_comm setVariable ["NAME_AVANPOST", _newName, true];
_markerName = format ["mkr_%1", _newName];
_markerText = format ["Аванпост %1", _newName];
_marker = createMarker [_markerName, _campPos];
_marker setMarkerAlpha 0;
_marker setMarkerText _markerText;
_marker setMarkerType "mil_box";
_marker setMarkerColor "ColorGUER";
_marker setMarkerSize [0.5, 0.5];
[_markerName, 0] remoteExec ["setMarkerAlphaLocal", west];
[_markerName, 1] remoteExec ["setMarkerAlphaLocal", resistance];

// add respawn point
AVANPOST_PARTIZAN_RESPAWN pushBack _newName; publicVariable "AVANPOST_PARTIZAN_RESPAWN";
[_comm, "QS_fnc_addActionAvanpostPartizan", nil, true] spawn BIS_fnc_MP;
_comm addMPEventHandler ["MPKilled", {
    _box = _this select 0;
    _name = _box getVariable ["NAME_AVANPOST", false];
    _killer = _this select 1;
    if (count _this > 2) then {
        _killer = _this select 2;
    };
    if (side _killer == west) then {
        _points = 10;
        _killer addScore _points;
        ["ScoreBonus", ["Аванпост партизан уничтожен!", _points]] remoteExec ["BIS_fnc_showNotification", _killer];
    };    
    playSound3D ["A3\sounds_f\sfx\special_sfx\sparkles_wreck_3.wss", _box, false, getPosASL _box, 2, 1, 100];
    _idx = AVANPOST_PARTIZAN_RESPAWN find _name;
    if (_idx > -1) then {
        AVANPOST_PARTIZAN_RESPAWN deleteAt _idx; publicVariable "AVANPOST_PARTIZAN_RESPAWN";
    };
    _markerName = format ["mkr_%1", _name];
    try {
        deleteMarker _markerName;
    } catch {};
}];