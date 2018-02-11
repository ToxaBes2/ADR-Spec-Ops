/*
@filename: fn_vSetup02.sqf
Author:

	???

Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver

Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
_______________________________________________*/

private ["_u", "_t"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};
_u setVariable ["AUTOSPAWNED", true, true];
_gh_huron = ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "B_Heli_Transport_03_F"]; 	// ghosthawk and huron
_huron = ["B_Heli_Transport_03_F"];																// huron
_taru = ["O_Heli_Transport_04_F"];																// taru
_taru_covered = ["O_Heli_Transport_04_covered_F"];												// taru covered
_strider = ["I_MRAP_03_F", "I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"];								// strider
_mh9 = ["B_Heli_Light_01_F", "B_Heli_Light_01_armed_F", "B_Heli_Light_01_stripped_F"];			// MH-9
_uav = ["B_UAV_02_CAS_F", "B_UAV_02_F", "B_UGV_01_F", "B_UGV_01_rcws_F","B_UAV_05_F","B_UAV_02_dynamicLoadout_F"];			// UAVs
_hellcat = ["I_Heli_light_03_unarmed_F", "I_Heli_light_03_F"];									// Hellcat
_mohawk = ["I_Heli_Transport_02_F"];															// CH-49 Mohawk
_ammoTrucks = ["B_Truck_01_ammo_F", "O_Truck_02_Ammo_F", "I_Truck_02_ammo_F","B_APC_Tracked_01_CRV_F"]; // Ammo trucks with 10^12 ammo
_ammoTrucksTempest = ["O_Truck_03_ammo_F"];														// Ammo trucks with 30 000 ammo
_mrap_lsv = ["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_T_LSV_01_unarmed_F","O_T_LSV_02_unarmed_F","I_MRAP_03_F","I_MRAP_03_hmg_F","B_T_LSV_01_armed_F"];
_apc = ["B_APC_Tracked_01_CRV_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_T_APC_Tracked_01_CRV_F","B_T_APC_Wheeled_01_cannon_F"];
_boat_partizan = ["C_Boat_Transport_02_F"];
_boat_blufor = ["B_Boat_Armed_01_minigun_F","B_T_Boat_Armed_01_minigun_F","I_C_Boat_Transport_02_F"];

if (_t in _boat_partizan) then {
    _u addItemCargoGlobal ["U_I_Wetsuit", 1];
    _u addItemCargoGlobal ["V_RebreatherIA", 1];
    _u addItemCargoGlobal ["G_Diving", 1];
    _u addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 5];
};

if (_t in _boat_blufor) then {
    _u addItemCargoGlobal ["U_B_Wetsuit", 1];
    _u addItemCargoGlobal ["V_RebreatherB", 1];
    _u addItemCargoGlobal ["G_Diving", 1];    
    _u addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 5];
    _u addWeaponCargoGlobal ["arifle_SDAR_F", 1];
};

if (_t in _strider) then {
	_u setObjectTextureGlobal [0, '\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
	_u setObjectTextureGlobal [1, '\A3\data_f\vehicles\turret_co.paa'];
};

if(_t in _mh9) then {
	_u addWeapon "CMFlareLauncher";
	_u addMagazine "168Rnd_CMFlare_Chaff_Magazine";
};

//if(_t in _huron) then {
//	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_03\Data\heli_transport_03_ext01_black_co.paa'];
//	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_03\Data\heli_transport_03_ext02_black_co.paa'];
//};

if(_t in _hellcat) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_epb\Heli_Light_03\Data\heli_light_03_base_co.paa'];
	_u addWeapon "Laserdesignator_mounted";
	_u addMagazine "Laserbatteries";
};

if(_t in _mohawk) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_beta\Heli_Transport_02\Data\skins\heli_transport_02_1_ion_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\air_f_beta\Heli_Transport_02\Data\skins\heli_transport_02_2_ion_co.paa'];
	_u setObjectTextureGlobal [2, 'A3\air_f_beta\Heli_Transport_02\Data\skins\heli_transport_02_3_ion_co.paa'];
};

if(_t in _taru) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa'];
};

if(_t in _taru_covered) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa'];
	_u setObjectTextureGlobal [2, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext01_black_co.paa'];
	_u setObjectTextureGlobal [3, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext02_black_co.paa'];
};

// UAV respawn fixer
if (_t in _uav) then {
	{deleteVehicle _x;} count (crew _u);
	[_u] spawn {
		_u = _this select 0;
		sleep 2;
		createVehicleCrew _u;
	};
	
	if (BLUFOR_BASE_SCORE > 34) then {
	    if (_t == "B_UGV_01_rcws_F") then {
	    	_magazine = selectRandom ["1Rnd_GAT_missiles", "1Rnd_GAA_missiles"];
            for "_i" from 1 to 4 do {
                _u addMagazineTurret [_magazine, [0]];
            };
            _u addWeaponTurret ["missiles_titan_static",[0]];
	    };
	};
};

// Turret locking system
if (_t in _gh_huron) then {
	_u setVariable ["turrets_locked", true, true];
	[[_u, 1, "LMG_Minigun_Transport", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
	[[_u, 2, "LMG_Minigun_Transport2", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
};

// load items in cargo of MRAPs/LSVs/APCs
if (_t in _mrap_lsv || _t in _apc) then {
    clearWeaponCargoGlobal _u;
    clearMagazineCargoGlobal _u;
    clearBackpackCargoGlobal _u;
    clearItemCargoGlobal _u;
    
    if (ARSENAL_ENABLED) then {
        _u addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 3];
        _u addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 3];
        _u addMagazineCargoGlobal ["30Rnd_762x39_Mag_Green_F", 3];
        _u addMagazineCargoGlobal ["30Rnd_762x39_Mag_Tracer_Green_F", 3];
        _u addMagazineCargoGlobal ["30Rnd_556x45_Stanag_red", 4];
        _u addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Red", 4];
        _u addMagazineCargoGlobal ["SmokeShellBlue", 16];
        _u addMagazineCargoGlobal ["HandGrenade", 4];
        _u addItemCargoGlobal ["FirstAidKit", 8];
    
        if (_t in _apc) then {
           _u addMagazineCargoGlobal ["RPG32_F", 2];
           _u addMagazineCargoGlobal ["RPG32_HE_F", 2];
           _u addMagazineCargoGlobal ["NLAW_F", 2];
        };
    };
};

// Ammo trucks
// Set ammo trucks cargo ammo to 32 562 ammo (one full AA rearm)
if ((_t in _ammoTrucks) or (_t in _ammoTrucksTempest)) then {
	while {true} do {
		call {
			if (_t in _ammoTrucks) exitWith {
				_u setAmmoCargo 0.000000032562; // 32 562 ammo
			};
			if (_t in _ammoTrucksTempest) exitWith {
				_u setAmmoCargo 1.08538;        // 32 562 ammo
			};
		};
		if (getAmmoCargo _u != 0) exitWith {}; // Due to very low values setAmmoCargo rounds to 0 on first try
	};
};

// decrease radar scan range
if (_u isKindOf "Air") then {
    _currentScanRange = _u getVariable ["irScanRangeMax", 1500];
    if (_currentScanRange > 1000) then {
    	_u setVariable ["irScanRangeMax", 1500, true];
    };
};

//===== Vehicle Killer monitor system
[_u] call QS_fnc_killerCatcher;
