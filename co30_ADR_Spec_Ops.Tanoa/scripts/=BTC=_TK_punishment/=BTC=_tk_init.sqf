/*
	Created by =BTC= Giallustio
	version 0.3
	Visit us at:
	http://www.blacktemplars.altervista.org/
	06/03/2012

Changelog:
    06/02/2016 - added prison with effects [ToxaBes]
*/
//Def
BTC_tk_blackscreen_punishment = 0;
BTC_tk_last_warning = 10;
BTC_tk_prison_coords = [15259,17355,0];
BTC_tk_light_pos = [15244,17345,0];

BTC_fnc_tk_PVEH = {
	//0 - first aid - create // [0,east,pos]
	//1 - first aid - delete
	_array = _this select 1;
	if (count _array < 2) exitWith {};
	_name  = _array select 0;
	_punisher = _array select 1;
	hint format ["%1 убил своего и был наказан игроком %2", _name, _punisher];
	_time = profileNamespace getVariable ["btc_tk_prison", 0];
	if (name player == _name && _time == 0) then {_spawn = [] spawn BTC_Teamkill;};
};
BTC_EH_killed = {
	_body = _this select 0;
	_killer = _this select 1;
	_veh_body = vehicle _body;
	_veh_killer = vehicle _killer;
	_name = name _killer;
	if (_name != name _body && BTC_vip find (name _killer) == -1) then {
		if (side _killer == playerSide && _veh_body != _veh_killer) then {
			//saving TEAMKILL info in server logs
			["//========================================", "diag_log", false] call BIS_fnc_MP;
			[format ["TEAMKILL: '%1[%3]' killed '%2[%4]'", _name, name _body, getPlayerUID _killer, getPlayerUID _body], "diag_log", false] call BIS_fnc_MP;
			_veh_crew = fullCrew _veh_killer;
			if ((count _veh_crew) > 0) then {
				{
					if (((_veh_crew select _forEachIndex) select 1) != "cargo") then {
						[format ["TEAMKILL: '%1' %2 '%3[%4]'", typeOf _veh_killer, (_veh_crew select _forEachIndex) select 1, name ((_veh_crew select _forEachIndex) select 0), getPlayerUID ((_veh_crew select _forEachIndex) select 0)], "diag_log", false] call BIS_fnc_MP;
					};
				} forEach _veh_crew;
			};
			["//========================================", "diag_log", false] call BIS_fnc_MP;

            _killerName = name _killer;
            if (_veh_killer isKindOf "Autonomous") then {
                if (isUAVConnected _veh_killer) then {
                	_killerName = name ((UAVControl _killer) select 0);
                };
            };

			_killerName spawn {
				hint format ["Вас убил %1! Вы можете наказать игрока через меню действий (колесо мыши)", _this];
				WaitUntil {alive player};
				_action = player addAction [("<t color=""#EF5350""><img image='\a3\ui_f\gui\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa' size='1.0'/> ") + ("Наказать " + _this) + "</t>","scripts\=BTC=_TK_punishment\=BTC=_punish_action.sqf",[_this], 1, true, true, "", "true"];
				_timeout = time + 60;
				WaitUntil {sleep 1; (_timeout < time)};
				player removeAction _action;
			};
		};
	};
};
BTC_Effects = {
    private ["_bolt", "_lighting", "_light"];
    _bolt = createVehicle ["LightningBolt", BTC_tk_light_pos, [], 0, "CAN_COLLIDE"];
    _bolt setVelocity [0, 0, -10];
    _lighting = "lightning_F" createvehiclelocal BTC_tk_light_pos;
    _lighting setPos BTC_tk_light_pos;
    _light = "#lightpoint" createvehiclelocal BTC_tk_light_pos;
    _light setPos BTC_tk_light_pos;
    _light setLightBrightness 30;
    _light setLightAmbient [0.5, 0.5, 1];
    _light setlightcolor [1, 1, 2];
    sleep (0.2 + random 0.1);
    deletevehicle _bolt;
    deletevehicle _light;
    deletevehicle _lighting;
    sleep 0.5;
    playSound (selectRandom ["thunder_1", "thunder_2"]);
};
BTC_Teamkill = {
	player addrating 9999;
	_uid = getPlayerUID player;
	if (!isNil "BTC_logic") then {
        BTC_teamkiller = BTC_logic getVariable _uid;
	    BTC_teamkiller = BTC_teamkiller + 1;
	    BTC_logic setVariable [_uid,BTC_teamkiller,true];
    } else {
        BTC_teamkiller = 1;
    };
	switch (true) do
	{
		case (BTC_teamkiller <= BTC_tk_blackscreen_punishment) :
		{
			titleText ["ПРЕКРАТИТЕ УБИВАТЬ СВОИХ! \ STOP TEAMKILLING!","BLACK FADED"];
			sleep 3;
			titleText ["ПРЕКРАТИТЕ УБИВАТЬ СВОИХ! \ STOP TEAMKILLING!","PLAIN"];
		};
		case (BTC_teamkiller > BTC_tk_blackscreen_punishment && BTC_teamkiller <= BTC_tk_last_warning) :
		{
            [[[player], "scripts\=BTC=_TK_punishment\Prison.sqf"], "BIS_fnc_execVM", true, false, false] call BIS_fnc_MP;
		};
		case (BTC_teamkiller > BTC_tk_last_warning) :
		{

			disableUserInput true;
			titleText ["ВАС НАКАЗАЛИ ЗА УБИЙСТВО СВОИХ! \ YOU HAVE BEEN PUNISHED FOR TEAMKILLING! \ ВАМ ЗДЕСЬ БОЛЬШЕ НЕ РАДЫ \ YOU ARE NOT WELCOME ANYMORE","BLACK FADED"];
			player setPos [0,0,0];
			while {true} do
			{
				titleText ["ВАС НАКАЗАЛИ ЗА УБИЙСТВО СВОИХ \ YOU HAVE BEEN PUNISHED FOR TEAMKILLING! \ ВАМ ЗДЕСЬ БОЛЬШЕ НЕ РАДЫ \ YOU ARE NOT WELCOME ANYMORE","BLACK FADED"];
				sleep 1;
			};
			disableUserInput false;
		};
	};
};
if (isServer) then {
	BTC_tk_PVEH = [];publicVariable "BTC_tk_PVEH";

	// build prison
	private ["_dir1", "_dir2", "_coordsData", "_coords", "_pos", "_wall", "_obj"];
	_dir1 = 180;
    _dir2 = 180;
    _coordsData = [[0,4,0.1],[3.5,4.2,0.4],[3.5,0.62,0.3],[3.5,-2,0.5],[3.5,-9.5,1.5],[-1.5,-4.1,0.3],[-1,-0.58,0.1],[-1,0.18,0.1],[-0.5,0.59,0.1]];
    for "_c" from 0 to 10 do {
    	if (_c < 1) then {
            _wall = createVehicle ["Land_Mil_WiredFence_F", [BTC_tk_prison_coords select 0, BTC_tk_prison_coords select 1, 5.4], [], 0, "CAN_COLLIDE"];
            _wall setDir _dir1;
            _coords = _coordsData select _c;
            _wall setVectorUp _coords;
            _wall allowDamage false;
            _wall enableSimulationGlobal false;
        };
        if (_c < 9) then {
            _pos = [BTC_tk_prison_coords, 10.3, _dir1] call BIS_fnc_relPos;
            _wall = createVehicle ["Land_Mil_WiredFence_F", [_pos select 0, _pos select 1, -0.1], [], 0, "CAN_COLLIDE"];
            _wall setDir _dir1;
            _wall setVectorUp (surfaceNormal (getPosATL _wall));
            _wall allowDamage false;
            _wall enableSimulationGlobal false;
            _wall = createVehicle ["Land_Mil_WiredFence_F", [_pos select 0, _pos select 1, 3.3], [], 0, "CAN_COLLIDE"];
            _wall setDir _dir1;
            _wall setVectorUp (surfaceNormal (getPosATL _wall));
            _wall allowDamage false;
            _wall enableSimulationGlobal false;
            _pos = [BTC_tk_prison_coords, 7.8, _dir1] call BIS_fnc_relPos;
            _wall = createVehicle ["Land_Mil_WiredFence_F", [_pos select 0, _pos select 1, 4.45], [], 0, "CAN_COLLIDE"];
            _wall setDir _dir1 + 180;
            _coords = _coordsData select _c;
            _wall setVectorUp _coords;
            _wall allowDamage false;
            _wall enableSimulationGlobal false;
            _pos = [BTC_tk_prison_coords, 3.7, _dir1] call BIS_fnc_relPos;
            _wall = createVehicle ["Land_Mil_WiredFence_F", [_pos select 0, _pos select 1, 5.4], [], 0, "CAN_COLLIDE"];
            _wall setDir _dir1;
            _coords = _coordsData select _c;
            _wall setVectorUp _coords;
            _wall allowDamage false;
            _wall enableSimulationGlobal false;
            _dir1 = _dir1 + 40;
        };
        _pos = [BTC_tk_prison_coords, 12, _dir2] call BIS_fnc_relPos;
        _wall = createVehicle ["Land_Mil_WiredFence_F", [_pos select 0, _pos select 1, -1], [], 0, "CAN_COLLIDE"];
        _wall setDir (_dir2 + 180);
        _wall setVectorUp (surfaceNormal (getPosATL _wall));
        _wall allowDamage false;
        //_wall enableSimulationGlobal false;
        _dir2 = _dir2 + 34.5;
    };
    _obj = createVehicle ["Land_Garbage_square3_F", BTC_tk_prison_coords, [], 0, "CAN_COLLIDE"];
};
if (!isDedicated) then {
	[] spawn {
		private ["_uid","_array_tk"];
		waitUntil {!isNull player};
		waitUntil {player == player};
		player addEventHandler ["Killed", BTC_EH_killed];
		"BTC_tk_PVEH" addPublicVariableEventHandler BTC_fnc_tk_PVEH;
		player addrating 9999;
		BTC_side = playerSide;
		BTC_vip = [];
		_uid = getPlayerUID player;
		if (!isNil "BTC_logic") then {
		    if (BTC_logic getVariable _uid) then {
		    	BTC_logic setVariable [_uid,0,true];
		    	BTC_teamkiller = 0;
		    } else {
		    	BTC_teamkiller = BTC_logic getVariable _uid;
		    	if (BTC_teamkiller > BTC_tk_last_warning) then {
		    		_tk = [] spawn BTC_Teamkill;
		    	};
		    };
		};
	};
};
