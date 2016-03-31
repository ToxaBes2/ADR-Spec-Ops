#include "macro.sqf"
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	If preload is enabled, it will build our preloaded config otherwise
	fetches from the configFile and caches the results in variables.
*/
private["_cfg","_type","_temp","_ret","_master","_class","_details","_displayName","_scope","_type","_str","_itemInfo","_timeStamp"];
_cfg = [_this,0,"",[""]] call BIS_fnc_param;
if(EQUAL(_cfg,"")) exitWith {};
_timeStamp = diag_tickTime;
if(VAS_preload && {!isNil "VAS_pre_weapons"} && {!isNil "VAS_pre_magazines"} && {!isNil "VAS_pre_items"} && {!isNil "VAS_pre_backpacks"} && {!isNil "VAS_pre_glasses"}) exitWith {};

switch(_cfg) do {
	case "CfgWeapons": {
		if(!isNil {GVAR_UINS "VASP_weapons"}) exitWith {["CfgWeapons"] call VAS_fnc_VASP};
		VAS_pre_items = [];
		VAS_pre_weapons = [];
		_temp = [];
		_ret = [];
		_ret2 = [];
		_master = "getNumber(_x >> 'scope') >= 2 && getNumber(_x >> 'type') in [1,2,3,4,5,4096,131072]" configClasses (configFile >> _cfg);
		private["_base","_ret2"];
		
		{
			_class = configName _x;
			_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
			_displayName = _details select 1;
			_picture = _details select 2;
			_scope = _details select 3;
			_type = _details select 4;
			_itemInfo = _details select 5;
			_AGMItem = _details select 15;
			_base = configName(inheritsFrom (configFile >> "CfgWeapons" >> _class));
			
			_str = [_class,4] call VAS_fnc_KRON_StrLeft;
				
			if(_scope >= 2 && !(EQUAL(_str,"ACRE"))) then {
				switch (true) do {
					case (_type in [1,2,4,5,4096]): {
						if(_picture != "" && !(EQUAL(_displayName,""))) then {
							if(EQUAL(_type,4096) && (EQUAL(_itemInfo,616) OR _AGMItem)) then {
								if(_class in VAS_r_items) exitWith {}; //Exit the loop.
								VAS_pre_items pushBack _class;
								pushBackMNS("VAS_pre_items_misc",_class)
							} else {
								if(!(_displayName in _temp) && !(_base in VAS_r_weapons) && !(_class in VAS_r_weapons)) then {
									_temp pushBack _displayName;
									VAS_pre_weapons pushBack _class;
									
									//Cache filtered weapons
									switch(_type) do {
										case 1: {pushBackMNS("VAS_pre_weapons_rifles",_class)};
										case 5: {pushBackMNS("VAS_pre_weapons_heavy",_class)};
										case 4: {pushBackMNS("VAS_pre_weapons_launchers",_class)};
										case 2: {pushBackMNS("VAS_pre_weapons_pistols",_class)};
									};
								};
							};
						};
					};
					
					case (EQUAL(_type,131072)): {
						if(_picture != "" && !(_base in VAS_r_items) && !(_class in VAS_r_items)) then {
							VAS_pre_items pushBack _class;
								
							//Cache filtered items
							switch(true) do {
								case (EQUAL(_itemInfo,801)): {pushBackMNS("VAS_pre_items_uniforms",_class)};
								case (EQUAL(_itemInfo,701)): {pushBackMNS("VAS_pre_items_vests",_class)};
								case (EQUAL(_itemInfo,605)): {pushBackMNS("VAS_pre_items_headgear",_class)};
								case (_itemInfo in [201,101,301,302]): {pushBackMNS("VAS_pre_items_attachments",_class)};
								default {pushBackMNS("VAS_pre_items_misc",_class)};
							};
						};
					};
				};
			};
		} foreach _master;
	};
	
	case "CfgMagazines":
	{
		if(!isNil {uiNamespace getVariable "VASP_magazines"}) exitWith {["CfgMagazines"] call VAS_fnc_VASP;};
		if(count VAS_magazines > 0) exitWith {}; //Don't waste CPU-processing on something that isn't required.
		_temp = [];
		_ret = [];
		_master = "getNumber(_x >> 'scope') >= 2 && getText(_x >> 'picture') != """"" configClasses (configFile >> _cfg);
		
		for "_i" from 0 to (count _master)-1 do
		{
			_class = _master select _i;
			if(isClass _class) then
			{
				_class = configName _class;
				_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
				_displayName = _details select 1;
				_picture = _details select 2;
				_scope = _details select 3;
				
				if(_scope >= 1 && _picture != "" && !(_displayName in _temp)) then
				{
					_str = [_class,4] call VAS_fnc_KRON_StrLeft;
					if(_str != "ACRE" && !(_class in VAS_R_magazines)) then
					{
						_temp set[count _temp,_displayName];
						_ret set[count _ret,_class];
					};
				};
			};
		};
		
		VAS_pre_magazines = _ret;
	};
	
	case "CfgVehicles":
	{
		if(!isNil {uiNamespace getVariable "VASP_backpacks"}) exitWith {["CfgVehicles"] call VAS_fnc_VASP;};
		if(count VAS_backpacks > 0) exitWith {}; //Don't waste CPU-processing on something that isn't required.
		_ret = [];
		_master = "getNumber(_x >> 'scope') >= 2 && getText(_x >> 'picture') != """" && getText(_x >> 'vehicleClass') == 'Backpacks'" configClasses (configFile >> _cfg);
		private["_base"];
		for "_i" from 0 to (count _master)-1 do
		{
			_class = _master select _i;
			if(isClass _class) then
			{
				_class = configName _class;
				_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
				_displayName = _details select 1;
				_picture = _details select 2;
				_scope = _details select 3;
				_type = _details select 4;
				_base = inheritsFrom (configFile >> _cfg >> _class);
				if(_scope >= 2 && _type == "Backpacks" && _picture != "") then
				{
					_str = [_class,4] call VAS_fnc_KRON_StrLeft;
					if(_str != "ACRE" && !(_base in VAS_r_backpacks) && !(_class in VAS_r_backpacks)) then
					{
						_ret set[count _ret,_class];
					};
				};
			};
		};
		
		VAS_pre_backpacks = _ret;
	};
	
	case "CfgGlasses":
	{
		if(!isNil {uiNamespace getVariable "VASP_glasses"}) exitWith {["CfgGlasses"] call VAS_fnc_VASP;};
		if(count VAS_glasses > 0) exitWith {}; //Don't waste CPU-processing on something that isn't required.
		_temp = [];
		_ret = [];
		_master = "getText(_x >> 'picture') != """" && getText(_x >> 'displayName') != 'None'" configClasses (configFile >> _cfg);
		for "_i" from 0 to (count _master)-1 do
		{
			_class = _master select _i;
			if(isClass _class) then
			{
				_class = configName _class;
				_details = [_class,_cfg] call VAS_fnc_fetchCfgDetails;
				_displayName = _details select 1;
				_picture = _details select 2;
				
				if(_picture != "" && _displayName != "None" && !(_displayName in _temp)) then
				{
					_str = [_class,4] call VAS_fnc_KRON_StrLeft;
					if(_str != "ACRE" && !(_class in VAS_r_glasses)) then
					{
						_temp set[count _temp,_displayName];
						_ret set[count _ret,_class];
					};
				};
			};
		};
		VAS_pre_glasses = _ret;
	};
};

diag_log format["Cfg Processed: %1 | Time to complete: %2",_cfg,(diag_tickTime) - _timeStamp];