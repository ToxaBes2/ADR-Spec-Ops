/*
Author:	ToxaBes
Description: spawn blufor reward
*/
if (!isNil "SELECTED_REWARD" && {count SELECTED_REWARD == 2}) then {
    disableSerialization;
    _idx = SELECTED_REWARD select 1;
    SELECTED_REWARD = nil; publicVariable "SELECTED_REWARD";
    _data = BLUFOR_REWARDS_LIST deleteAt _idx;
    publicVariable "BLUFOR_REWARDS_LIST";
    _display = uiNamespace getVariable['VAS_Reward_Display_Blufor', displayNull];
    _ctrl = _display displayCtrl 7777;
    _ctrl lnbDeleteRow _idx;
    _vehs = _data select 1;    
    _vehName = _vehs select 0;    
    [_vehName] spawn {    
        REWARD_IN_PROGRESS = true; publicVariable "REWARD_IN_PROGRESS";
        _rewardDir = 90;
        hqSideChat = "Наградная техника будет доставлена через несколько минут..."; 
        publicVariable "hqSideChat"; 
        [WEST, "HQ"] sideChat hqSideChat;
        _vehName = _this select 0;
        _start =[7788,4342,500];
        _land = [6955,7376,0];
        _startCargo = [0,0,100];
        landpoint = "Land_HelipadEmpty_F" createVehicle _land;
        _veh = createVehicle ["B_Heli_Transport_03_F", [0,0,500], [], 0, "FLY"];
        _veh setPos _start;
        createVehicleCrew _veh;
        _veh setPos _start;
        _veh addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
        _veh lock 2;
        _veh allowCrewInImmobile true;
        _cargo = "B_Slingload_01_Ammo_F" createVehicle _startCargo;
        _cargo setPos _startCargo;
        _veh setSlingLoad _cargo;
        _crew = crew _veh;
        _group = group (driver _veh);
        {
            _x addCuratorEditableObjects [[_veh], true];
        } forEach allCurators;    
        _veh doMove _land;
        waitUntil {
            sleep 2;
            if (unitReady (effectiveCommander _veh) || {!(alive _cargo)} || {(getPos _cargo) select 2 < 2}) exitWith {true};
        };
        if (alive _cargo) then {
            _veh land "land";
        };    
        waitUntil {
            sleep 1;
            if (!(alive _cargo) || {(getPos _cargo) select 2 < 7}) exitWith {true};        
        };
        _veh setSlingLoad objNull;
        _veh land "NONE";
        _veh doMove _start; 
        _veh flyInHeight 100;
        if (alive _cargo) then {  
            _veh setDamage 0;
            _veh setFuel 1;
            _veh setVehicleAmmo 1;  
            _spawnPos = getPos _cargo;
            _spawnDamage = damage _cargo;
            deleteVehicle _cargo;
            
            if (_vehName == "ctrg") then {
        
                // spawn group of bots
                _rewardGroup = [_spawnPos, west, (configfile >> "CfgGroups" >> "West" >> "BLU_CTRG_F" >> "Infantry" >> "CTRG_InfSquad")] call BIS_fnc_spawnGroup;
                {
                    _x setDamage _spawnDamage;
                } forEach (units _rewardGroup);
                [(units _rewardGroup)] call QS_fnc_setSkill4;
                if ((getPos (leader _rewardGroup)) distance2D _land < 50) then {
                    hqSideChat = "Груз доставлен";
                } else {
                    hqSideChat = "Груз потерян из-за нападения";
                };
                (units _rewardGroup) joinSilent player;
                deleteGroup _rewardGroup;                
            } else {
        
                // Spawn the vehicle    
                _vehReward = createVehicle [_vehName, _spawnPos, [], 0, "NONE"];
                waitUntil {!isNull _vehReward};
                _vehReward  addEventHandler ['incomingMissile', {_this spawn QS_fnc_HandleIncomingMissile}];
                _vehReward setDir _rewardDir;
                _vehReward lock 0;
                _vehReward setDamage _spawnDamage;
                if (getNumber(configFile >> "CfgVehicles" >> typeof _vehReward >> "isUav") == 1) then {
                    createVehicleCrew _vehReward;
                    _crew = crew _vehReward;
                    _grp = createGroup WEST;
                    _crew joinSilent _grp;
                    _grp addVehicle _vehReward;
                    {
                        _x setName "[AI]";
                    } forEach units _grp;
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
                };
                if (_vehReward distance2D _land < 50) then {
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
} else {
    hint "Выберите награду!";
};
