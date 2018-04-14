/*
Author: ToxaBes
Description: apply changes to BLUFOR base depends of score
*/
_level = _this select 0;

// Base #1
if (_level > 0) then {	
    {
        _x hideObjectGlobal false;
    } forEach [stop1, gate1, stop2, gate2, stop3, gate3];
    _turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
    baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15, baseTurret16, baseTurret17, baseTurret18, baseTurret19, baseTurret20];
    {
        if !(isPlayer (gunner _x)) then {
            deleteVehicle (gunner _x);
        };   
    } foreach _turrets;
	_grpTurret1 = createGroup west;
    "B_support_MG_F" createUnit [getposATL baseTurret1, _grpTurret1, "this moveInGunner baseTurret1"];
    "B_support_MG_F" createUnit [getposATL baseTurret3, _grpTurret1, "this moveInGunner baseTurret3"];
    "B_support_MG_F" createUnit [getposATL baseTurret5, _grpTurret1, "this moveInGunner baseTurret5"];
    "B_support_MG_F" createUnit [getposATL baseTurret7, _grpTurret1, "this moveInGunner baseTurret7"];
    "B_support_MG_F" createUnit [getposATL baseTurret9, _grpTurret1, "this moveInGunner baseTurret9"];
    "B_support_MG_F" createUnit [getposATL baseTurret11, _grpTurret1, "this moveInGunner baseTurret11"];
    "B_support_MG_F" createUnit [getposATL baseTurret13, _grpTurret1, "this moveInGunner baseTurret13"];
    "B_support_MG_F" createUnit [getposATL baseTurret15, _grpTurret1, "this moveInGunner baseTurret15"];
    "B_support_MG_F" createUnit [getposATL baseTurret17, _grpTurret1, "this moveInGunner baseTurret17"];
    "B_support_MG_F" createUnit [getposATL baseTurret19, _grpTurret1, "this moveInGunner baseTurret19"];
    _grpTurret1 setBehaviour "COMBAT";
    _grpTurret1 setCombatMode "RED";
    [(units _grpTurret1)] call QS_fnc_setSkill4;        
} else {
    {
        _x hideObjectGlobal true;
    } forEach [stop1, gate1, stop2, gate2, stop3, gate3];
    _turrets = [baseTurret1, baseTurret2, baseTurret3, baseTurret4, baseTurret5, baseTurret6, baseTurret7, baseTurret8, baseTurret9, baseTurret10, 
    baseTurret11, baseTurret12, baseTurret13, baseTurret14, baseTurret15, baseTurret16, baseTurret17, baseTurret18, baseTurret19, baseTurret20];
    {
        if !(isPlayer (gunner _x)) then {
            deleteVehicle (gunner _x);
        };        
    } foreach _turrets;
};

// Base #4
if (_level > 27) then {
    _posSpawn = [15167, 17246, (random 15) + 15];
    _uavData = [_posSpawn, 90, "B_UAV_01_F", WEST] call BIS_fnc_spawnVehicle;
    base_darter = _uavData select 0;
    _uavGroup = _uavData select 2;
    base_darter addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    base_darter addWeapon ("LMG_Mk200_F");
    base_darter addMagazine ("200Rnd_65x39_cased_Box_Tracer");
    base_darter setVariable ["VCOM_NOAI", true];
    _uavGroup setVariable ["zbe_cacheDisabled", true];
    _uavGroup setBehaviour "SAFE";
    _uavGroup setCombatMode "RED";
    [(units _uavGroup)] call QS_fnc_setSkill3;
    [_uavGroup, _posSpawn, (40 + (random 80))] call BIS_fnc_taskPatrol;
    _uavGroup deleteGroupWhenEmpty true;
    [base_darter] spawn {
        _u = _this select 0;
        while {alive _u} do {            
            _u setFuel 1;
            _u setVehicleAmmo 1;
            sleep 600;
        };        
    };
    [base_darter] spawn {
        _u = _this select 0;
        while {alive _u} do {
            waitUntil {isUAVConnected _u};
            _ctrl = UAVControl _u;
            _unit = _ctrl select 0;
            _unit connectTerminalToUAV objNull;
            "Доступ к автоматической системе охраны запрещен!" remoteExec ["hint", _unit];                 
        };
    };
} else {
    if (!isNil "base_darter") then {
        {
            deleteVehicle _x;
        } forEach (crew base_darter);
        deleteVehicle base_darter;    
    };   
};

// Engeneer 4
if (_level > 34) then {
    _ugvs = [UGV1];
    if !(isNil "UGV2") then {
        _ugvs pushBack UGV2;
    };
    {
        if (alive _x) then {
            _ugv = _x;
            _weapons = _ugv weaponsTurret [0];
            if !("missiles_titan_static" in _weapons) then {
                _magazine = selectRandom ["1Rnd_GAT_missiles", "1Rnd_GAA_missiles"];
                for "_i" from 1 to 4 do {
                    _ugv addMagazineTurret [_magazine, [0]];
                };
                _ugv addWeaponTurret ["missiles_titan_static",[0]];
            };
        };
    } forEach _ugvs;
};

// Pilot 1
if (_level > 6) then {
    base_supply_modules_spawn hideObjectGlobal false;
} else {
    base_supply_modules_spawn hideObjectGlobal true;
};