/*
Author: ToxaBes
Description: spawn blufor reward
*/
_vehName = _this select 0;
[_vehName] spawn {    
    REWARD_IN_PROGRESS = true; publicVariable "REWARD_IN_PROGRESS";
    _rewardDir = 80;    
    _vehName = _this select 0;
    _start =[7788,4342,500];
    _land = [6955,7376,0];
    _startCargo = [0,0,100];
    _landpoint = "Land_HelipadEmpty_F" createVehicle _land;

    _veh = createVehicle ["B_T_VTOL_01_infantry_F", _start, [], 0, "FLY"];
    createVehicleCrew _veh;
    _veh setPos _start;
    _veh addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
    _veh lock 2;
    _veh allowCrewInImmobile true;
    _veh setPilotLight true;
    _veh setCollisionLight true;
    _crew = crew _veh;
    _group = group (driver _veh);
    {
        _x addCuratorEditableObjects [[_veh], true];
    } forEach allCurators;       
    _wp0 = _group addWayPoint [_land, 0];
    _wp0 setWaypointBehaviour "SAFE";
    _wp0 setWaypointSpeed "NORMAL";
    _wp0 setWaypointBehaviour "CARELESS";
    _wp0 setWaypointForceBehaviour true;
    _wp0 setWaypointCombatMode "BLUE";
    _wp0 setWaypointCompletionRadius 30;
    _wp0 setWaypointType "SCRIPTED";
    _wp0 setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
    _wp2 = _group addWayPoint [_start, 1];
    _wp2 setWaypointType "MOVE";
    _wp2 setWaypointBehaviour "SAFE";
    _wp2 setWaypointForceBehaviour true;
    _wp2 setWaypointSpeed "FULL";    
    _wp2 setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];

    waitUntil {
        sleep 2;
        if (!(alive _veh) || (getPosATL _veh) select 2 < 1) exitWith {true};        
    };
    if (alive _veh) then {  
        deleteVehicle _landpoint;
        _vehPos = getPos _veh;
        _vehPos set [2,0];
        _spawnPos = [_vehPos, 15, 100, 2, 0, 0, 0, [], [_vehPos]] call QS_fnc_findSafePos;
        _veh setDamage 0;
        _veh setFuel 1;
        _veh setVehicleAmmo 1;
        sleep 1;
        if (_vehName == "ctrg") then {
    
            // spawn group of bots
            _rewardGroup = [_spawnPos, west, (configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry" >> "CTRG_InfSquad")] call BIS_fnc_spawnGroup;
            [(units _rewardGroup)] call QS_fnc_setSkill4;
            if ((getPos (leader _rewardGroup)) distance2D _land < 200) then {
                hqSideChat = "Груз доставлен";
            } else {
                hqSideChat = "Груз потерян из-за нападения";
            };
            (units _rewardGroup) joinSilent player;
            deleteGroup _rewardGroup;                
        } else {
    
            // Spawn the vehicle
            _spawnPositions = [];
            if (_veh distance2D _land < 200) then {
                _spawnPositions = ["reward1","reward2","reward3","reward4","reward5"];
            };
            _vehReward = createVehicle [_vehName, _spawnPos, _spawnPositions, 0, "NONE"];
            [_vehReward,"",["showCamonetHull",(selectRandom [0,1]),"showCamonetTurret",(selectRandom [0,1]),"showSLATHull",(selectRandom [0,1])]] call BIS_fnc_initVehicle;
            _correctPos = getPos _vehReward;
            _correctPos set [2,0];
            _vehReward setPos _correctPos;

            _vehReward  addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
            _vehReward setDir _rewardDir;
            _vehReward lock 0;
            if (getNumber(configFile >> "CfgVehicles" >> typeof _vehReward >> "isUav") == 1) then {
                if (_vehReward isKindOf "UAV_05_Base_F") then {
                    [_vehReward] spawn {
                        _u = _this select 0;
                        sleep 2;
                        createVehicleCrew _u;
                        _grp = group _u; 
                        {
                            _x setName "[AI]";
                        } forEach units _grp;
                    };
                } else {
                    createVehicleCrew _vehReward;
                    _crew = crew _vehReward;
                    _grp = createGroup WEST;
                    _crew joinSilent _grp;
                    _grp addVehicle _vehReward;
                    {
                        _x setName "[AI]";
                    } forEach units _grp;
                };                                    
            };   

            if (_vehReward isKindOf "LandVehicle") then {
                clearWeaponCargoGlobal _vehReward;
                clearMagazineCargoGlobal _vehReward;
                clearBackpackCargoGlobal _vehReward;
                clearItemCargoGlobal _vehReward;
            };
            
            [_vehReward] call QS_fnc_killerCatcher;
            _vehReward setVariable ["IS_REWARD", true];    
            _class = typeOf _vehReward;
            switch (_class) do { 
                case "I_APC_Wheeled_03_cannon_F": {
                    _vehReward setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"];
                    _vehReward setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"];
                    _vehReward setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"];
                    _vehReward setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];
                }; 
                case "O_APC_Wheeled_02_rcws_F": {
                    _vehReward addWeapon ("Rocket_04_AP_Plane_CAS_01_F");
                    _vehReward addMagazine ("7Rnd_Rocket_04_AP_F");
                    _vehReward addMagazine ("7Rnd_Rocket_04_AP_F");
                    _vehReward addWeapon ("Rocket_04_HE_Plane_CAS_01_F");
                    _vehReward addMagazine ("7Rnd_Rocket_04_HE_F");
                    _vehReward addMagazine ("7Rnd_Rocket_04_HE_F");
                };
                case "B_T_MBT_01_arty_F": {
                    _vehReward removeMagazine ("6Rnd_155mm_Mo_AT_mine");
                    _vehReward removeMagazine ("6Rnd_155mm_Mo_mine");
                };
                case "O_Heli_Attack_02_black_F": {
                    _vehReward removeMagazineTurret ["38Rnd_80mm_rockets", [0]];
                    _vehReward removeWeaponTurret ["rockets_Skyfire", [0]];
                    _vehReward addMagazineTurret ["38Rnd_80mm_rockets", [-1]];
                    _vehReward addWeaponTurret ["rockets_Skyfire", [-1]];
                };
                case "I_MBT_03_cannon_F": {
                    _vehReward addMagazineTurret ["SmokeLauncherMag", [-1]];
                    _vehReward addWeaponTurret ["SmokeLauncher", [-1]];
                };
                case "O_MBT_02_cannon_F": {
                    _vehReward addMagazineTurret ["SmokeLauncherMag", [-1]];
                    _vehReward addWeaponTurret ["SmokeLauncher", [-1]];
                };
                case "B_T_MBT_01_TUSK_F": {
                    _vehReward addMagazineTurret ["SmokeLauncherMag", [-1]];
                    _vehReward addWeaponTurret ["SmokeLauncher", [-1]];
                };
                case "B_T_MBT_01_cannon_F": {
                    _vehReward addMagazineTurret ["SmokeLauncherMag", [-1]];
                    _vehReward addWeaponTurret ["SmokeLauncher", [-1]];
                };
                case "O_T_VTOL_02_vehicle_F": {
                    _vehReward removeMagazineTurret ["38Rnd_80mm_rockets", [0]];
                    _vehReward removeWeaponTurret ["rockets_Skyfire", [0]];
                    _vehReward addMagazineTurret ["38Rnd_80mm_rockets", [-1]];
                    _vehReward addWeaponTurret ["rockets_Skyfire", [-1]];
                };
                case "O_T_VTOL_02_infantry_F": {
                    _vehReward removeMagazineTurret ["38Rnd_80mm_rockets", [0]];
                    _vehReward removeWeaponTurret ["rockets_Skyfire", [0]];
                    _vehReward addMagazineTurret ["38Rnd_80mm_rockets", [-1]];
                    _vehReward addWeaponTurret ["rockets_Skyfire", [-1]];
                };
                case "O_T_VTOL_02_infantry_dynamicLoadout_F": {
                    _idx = 0;
                    _textures = getArray (configfile >> "CfgVehicles" >> "O_T_VTOL_02_infantry_dynamicLoadout_F" >> "TextureSources" >> "Grey" >> "textures");
                    {
                        _vehReward setObjectTextureGlobal [_idx, _x];
                        _idx = _idx + 1;
                    } forEach _textures;
                };
                case "O_Heli_Light_02_dynamicLoadout_F": {
                    _idx = 0;
                    _textures = getArray (configfile >> "CfgVehicles" >> "O_Heli_Light_02_dynamicLoadout_F" >> "TextureSources" >> "Blackcustom" >> "textures");
                    {
                        _vehReward setObjectTextureGlobal [_idx, _x];
                        _idx = _idx + 1;
                    } forEach _textures;
                };
                case "O_Heli_Attack_02_dynamicLoadout_F": {
                    _idx = 0;
                    _textures = getArray (configfile >> "CfgVehicles" >> "O_Heli_Attack_02_dynamicLoadout_F" >> "TextureSources" >> "Black" >> "textures");
                    {
                        _vehReward setObjectTextureGlobal [_idx, _x];
                        _idx = _idx + 1;
                    } forEach _textures;
                };
                case "I_Plane_Fighter_04_F": {
                    _idx = 0;
                    _textures = getArray (configfile >> "CfgVehicles" >> "I_Plane_Fighter_04_F" >> "TextureSources" >> "DigitalCamoGrey" >> "textures");
                    {
                        _vehReward setObjectTextureGlobal [_idx, _x];
                        _idx = _idx + 1;
                    } forEach _textures;
                };
                case "B_Plane_Fighter_01_F": {
                    _idx = 0;
                    _textures = getArray (configfile >> "CfgVehicles" >> "B_Plane_Fighter_01_F" >> "TextureSources" >> "DarkGreyCamo" >> "textures");
                    {
                        _vehReward setObjectTextureGlobal [_idx, _x];
                        _idx = _idx + 1;
                    } forEach _textures;
                };
                case "O_Plane_Fighter_02_F": {
                    _idx = 0;
                    _textures = getArray (configfile >> "CfgVehicles" >> "O_Plane_Fighter_02_F" >> "TextureSources" >> "CamoGreyHex" >> "textures");
                    {
                        _vehReward setObjectTextureGlobal [_idx, _x];
                        _idx = _idx + 1;
                    } forEach _textures;
                };
                case "B_UAV_05_F": {
                    _idx = 0;
                    _textures = getArray (configfile >> "CfgVehicles" >> "B_UAV_05_F" >> "TextureSources" >> "DarkGreyCamo" >> "textures");
                    {
                        _vehReward setObjectTextureGlobal [_idx, _x];
                        _idx = _idx + 1;
                    } forEach _textures;
                };
                case "O_Truck_03_device_F": {
                    _vehReward addMPEventHandler ["MPKilled", {            
                        _basePos = getMarkerPos "respawn_west";
                        _curObj = _this select 0;
                        _curObj setDamage 0.9;
                        _epicenter = getPos _curObj;
                        if (isServer) then {
                            _bigBomb = createVehicle ["Bo_GBU12_LGB", _epicenter, [], 0, "NONE"];
                            if (((_this select 0) distance _basePos) > 1500) then {
                                _k = 1.66;
                                _radius = 900;
                                _radiusEMI = 1400;
                                _allObjects1 = nearestObjects [_epicenter,[], _radius];
                                {
                                    _distance = [_epicenter, getPos _x] call BIS_fnc_distance2D;
                                    _x setDamage (abs ((_distance / _radius) - _k));
                                } foreach _allObjects1;
                                _allObjects2 = nearestObjects [_epicenter, ["LandVehicle","Air","Ship"], _radiusEMI];
                                {
                                    _x engineOn false;
                                    _fuel = fuel _x;
                                    _x setFuel 0;
                                    sleep 0.01;
                                    _x setFuel _fuel;
                                    _x setHit ["motor", 1];
                                    driver _x action ["lightOff", _x];
                                    _x setHit ["elektronika", 1];
                                } foreach _allObjects2;
                            };
                            deleteVehicle _curObj;
                        };
                        if (hasInterface) then {
                            [_epicenter] execVM "scripts\nuke\nuke.sqf";
                        };
                    }];
                };
            };
            if (_vehReward distance2D _land < 200) then {
                hqSideChat = "Груз доставлен";                    
            } else {
                hqSideChat = "Груз потерян из-за нападения";
            };                
        };            
        publicVariable "hqSideChat";
        [WEST, "HQ"] sideChat hqSideChat; 
    } else {
        hqSideChat = "Груз разбился при доставке"; 
        publicVariable "hqSideChat";
        [WEST, "HQ"] sideChat hqSideChat; 
    };
    [_veh, _crew] spawn {
        _veh = _this select 0;
        _crew = _this select 1;
        sleep 60;
        try {
            {
                deleteVehicle _x;
            } forEach _crew;
            deleteVehicle _veh;
        } catch {};
    };        
};