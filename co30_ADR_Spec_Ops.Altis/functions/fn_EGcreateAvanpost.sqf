/*
Author: ToxaBes
Description: create avanpost for Endless Game.
Format: [_pos, _objs] call QS_fnc_EGcreateAvanpost;
*/
if (!isServer) exitWith {};
_pos = _this select 0;
_pos set [2, 0];
_objs = _this select 1;
_newObjs = [];
_lamps = ["Land_LampHalogen_F","Land_PortableLight_single_F","Land_PortableLight_double_F"];
_exclude = ["Land_Cargo_Patrol_V1_F", "Land_Cargo_House_V1_F", "Land_Cargo20_military_green_F"];
for "_i" from 0 to ((count _objs) - 1) do {
	private ["_obj", "_type", "_relPos", "_azimuth", "_fuel", "_damage", "_newObj", "_vehicleinit"];
	_obj = _objs select _i;
	_type = _obj select 0;
	_objPos = _obj select 1;
	_azimuth = _obj select 2;							
	_newObj = _type createVehicle _objPos;
	_newObj setDir _azimuth;
	_newObj setPos _objPos;
	switch (true) do { 
		case (_newObj isKindOf "LandVehicle"): {
            //quadbike monitoring
            _newObj setVariable ["ENDLESSGAME_BIKE", true];
            [_newObj,60,FALSE,QS_fnc_vSetup02] spawn QS_fnc_vMonitor;
	    }; 
		case (_newObj isKindOf "StaticWeapon"): {
            //add gunner later in another place
	    }; 
	    case ((typeOf _newObj) in _lamps): {
            //do nothing
	    };	    
		default {
            _newObj allowDamage false;            
            _class = typeOf _newObj;
            if !(_class in _exclude) then {
                _newObj enableSimulation false;
            };                
	    }; 
	};
	_newObjs = _newObjs + [_newObj];	
};
_newObjs
