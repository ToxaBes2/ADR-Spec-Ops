/*
Author:	ToxaBes
Description: spawn blufor reward
*/
_smMarkerList = ["smReward1", "smReward2", "smReward3", "smReward4", "smReward5", "smReward6", "smReward7", "smReward8", "smReward9", "smReward10", "smReward11", "smReward12", "smReward13", "smReward14", "smReward15", "smReward16", "smReward17", "smReward18", "smReward19", "smReward20", "smReward21", "smReward22", "smReward23", "smReward24", "smReward25", "smReward26", "smReward27"];

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
    _rewardDir = 90;
    ["<t color='#7FDA0B' size = '.48'>Вызываем награду...</t>", 0, 0.8, 3, 0.5, 0] spawn BIS_fnc_dynamicText;

    // Spawn the vehicle
    _veh = createVehicle [_vehName, getMarkerPos "smReward1", _smMarkerList, 0, "NONE"];
    waitUntil {!isNull _veh};
    _veh setDir _rewardDir;
    _veh lock 0;
    if (getNumber(configFile >> "CfgVehicles" >> typeof _veh >> "isUav") == 1) then {
        createVehicleCrew _veh;
        _crew = crew _veh;
        _grp = createGroup WEST;
        _crew joinSilent _grp;
        _grp addVehicle _veh;
        {
            _x setName "[AI]";
        } forEach units _grp;
    };    
    [_veh] call QS_fnc_killerCatcher;
    _veh setVariable ["IS_REWARD", true];    
    _class = typeOf _veh;
    switch (_class) do { 
        case "I_APC_Wheeled_03_cannon_F": {
            _veh setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"];
            _veh setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"];
            _veh setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"];
            _veh setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];
        }; 
        case "O_APC_Wheeled_02_rcws_F": {
            _veh addWeapon ("Rocket_04_AP_Plane_CAS_01_F");
            _veh addMagazine ("7Rnd_Rocket_04_AP_F");
            _veh addMagazine ("7Rnd_Rocket_04_AP_F");
            _veh addWeapon ("Rocket_04_HE_Plane_CAS_01_F");
            _veh addMagazine ("7Rnd_Rocket_04_HE_F");
            _veh addMagazine ("7Rnd_Rocket_04_HE_F");
        };
        case "B_MBT_01_arty_F": {
            _veh removeMagazine ("6Rnd_155mm_Mo_AT_mine");
            _veh removeMagazine ("6Rnd_155mm_Mo_mine");
        };
        case "O_Heli_Attack_02_black_F": {
            _veh removeMagazineTurret ["38Rnd_80mm_rockets", [0]];
            _veh removeWeaponTurret ["rockets_Skyfire", [0]];
            _veh addMagazineTurret ["38Rnd_80mm_rockets", [-1]];
            _veh addWeaponTurret ["rockets_Skyfire", [-1]];
        };
        case "I_MBT_03_cannon_F": {
            _veh addMagazineTurret ["SmokeLauncherMag", [-1]];
            _veh addWeaponTurret ["SmokeLauncher", [-1]];
        };
        case "O_MBT_02_cannon_F": {
            _veh addMagazineTurret ["SmokeLauncherMag", [-1]];
            _veh addWeaponTurret ["SmokeLauncher", [-1]];
        };
        case "B_MBT_01_TUSK_F": {
            _veh addMagazineTurret ["SmokeLauncherMag", [-1]];
            _veh addWeaponTurret ["SmokeLauncher", [-1]];
        };
        case "B_MBT_01_cannon_F": {
            _veh addMagazineTurret ["SmokeLauncherMag", [-1]];
            _veh addWeaponTurret ["SmokeLauncher", [-1]];
        };
    };
} else {
	hint "Выберите награду!";
};
