/*
Author: ToxaBes
Description: remove objects for save fps
*/
_sleep = 300;
_objectsDist = 1000;
_objectFilters = ["WeaponHolder", "GroundWeaponHolder", "WeaponHolderSimulated", "Mine", "MineE"];
while {true} do {
    sleep _sleep;
    _players = allPlayers - entities "HeadlessClient_F";
    for '_i' from 0 to count(_objectFilters) - 1 do {
    	_filter = _objectFilters select _i;
        {
        	_remove = true;
        	_obj = _x;
            {
                if (_x distance2D _obj < _objectsDist) exitWith {
                    _remove = false;
                };
            } forEach _players;
            if (_remove) then {
                deleteVehicle _obj;
            };
        } forEach allMissionObjects _filter;
    };
    if !(isNil "RUINS") then {
        _indexes = [];
        _idx = 0;
        {            
            _currentObject = (_x select 1) call BIS_fnc_objectFromNetId;           
            _remove = true;
            {
                if (_x distance2D _currentObject < _objectsDist) exitWith {
                    _remove = false;
                };
            } forEach _players;
            if (_remove) then {                
                deleteVehicle _currentObject;
                _origObject = (_x select 0) call BIS_fnc_objectFromNetId;
                _origObject setDamage 0;
                _indexes pushBack _idx;                
            };
            _idx = _idx + 1;
        } forEach RUINS;
        _indexes sort false;
        {
            RUINS deleteAt _x;
        } forEach _indexes;
    };
};
