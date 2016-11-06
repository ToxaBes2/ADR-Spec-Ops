/*
@filename: fn_vSetup02.sqf
Author:

	???

Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver

Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
*/

private ["_u", "_t", "_taru", "_taru_covered", "_striders", "_mh9", "_hellcats", "_uavs", "_ammoTrucks", "_ammoTrucksTempest", "_prowlers", "_ghosthawks", "_hurons", "_blackfishes", "_random"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};

_taru = ["O_Heli_Transport_04_F"];															// Taru
_taru_covered = ["O_Heli_Transport_04_covered_F"];											// Taru covered
_striders = ["I_MRAP_03_F", "I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"];							// Striders
_mh9 = ["B_Heli_Light_01_F", "B_Heli_Light_01_armed_F", "B_Heli_Light_01_stripped_F"];		// MH-9
_hellcats = ["I_Heli_light_03_unarmed_F", "I_Heli_light_03_F"];								// Hellcats
_uavs = ["B_UAV_02_CAS_F", "B_UAV_02_F", "B_UGV_01_F", "B_UGV_01_rcws_F"];					// UAVs
_ammoTrucks = ["B_Truck_01_ammo_F", "O_Truck_02_Ammo_F", "I_Truck_02_ammo_F"];				// Ammo trucks with 10^12 ammo
_ammoTrucksTempest = ["O_Truck_03_ammo_F"];													// Ammo trucks with 30 000 ammo
_prowlers = ["B_T_LSV_01_armed_F","B_T_LSV_01_unarmed_F"];									// Prowlers
_ghosthawks = ["B_Heli_Transport_01_camo_F", "B_CTRG_Heli_Transport_01_tropic_F",
             "B_Heli_Transport_01_F"];														// Ghosthawks
_hurons = ["B_Heli_Transport_03_F"];														// Hurons
_blackfishes = ["B_T_VTOL_01_armed_F","B_T_VTOL_01_infantry_F","B_T_VTOL_01_vehicle_F"];	// Blackfish
_noThermalVision = ["B_Plane_CAS_01_F", "O_Plane_CAS_02_F", "I_Plane_Fighter_03_CAS_F", "I_Plane_Fighter_03_AA_F"];

call {
    if(_t in _taru) exitWith {
    	_u setObjectTextureGlobal [0, "A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa"];
    	_u setObjectTextureGlobal [1, "A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa"];
    };

    if(_t in _taru_covered) exitWith {
    	_u setObjectTextureGlobal [0, "A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa"];
    	_u setObjectTextureGlobal [1, "A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa"];
    	_u setObjectTextureGlobal [2, "A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext01_black_co.paa"];
    	_u setObjectTextureGlobal [3, "A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext02_black_co.paa"];
    };

    if (_t in _striders) exitWith {
    	_u setObjectTextureGlobal [0, "\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa"];
    	_u setObjectTextureGlobal [1, "\A3\data_f\vehicles\turret_co.paa"];
    };

    if(_t in _mh9) exitWith {
    	_u addWeapon "CMFlareLauncher";
    	_u addMagazine "168Rnd_CMFlare_Chaff_Magazine";
    };

    if(_t in _hellcats) exitWith {
    	_u setObjectTextureGlobal [0, "A3\air_f_epb\Heli_Light_03\Data\heli_light_03_base_co.paa"];
    	_u addWeapon "Laserdesignator_mounted";
    	_u addMagazine "Laserbatteries";
    };

    // UAV respawn fixer
    if (_t in _uavs) exitWith {
    	{deleteVehicle _x;} count (crew _u);
    	[_u] spawn {
    		_u = _this select 0;
    		sleep 2;
    		createVehicleCrew _u;
    	};
    };

    // Ammo trucks
    // Set ammo trucks cargo ammo to 32 562 ammo (one full AA rearm)
    if ((_t in _ammoTrucks) or (_t in _ammoTrucksTempest)) exitWith {
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

    // Random textures for Prowlers
    if (_t in _prowlers) exitWith {
        _random = floor(random 3);
        call {
            if (_random == 0) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_olive_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_olive_CO.paa"];
                _u setObjectTextureGlobal [2, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_olive_CO.paa"];
                _u setObjectTextureGlobal [3, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_olive_CO.paa"];
            };
            if (_random == 1) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_dazzle_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_olive_CO.paa"];
                _u setObjectTextureGlobal [2, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_olive_CO.paa"];
                _u setObjectTextureGlobal [3, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_olive_CO.paa"];
            };
            if (_random == 2) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_01_black_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_02_black_CO.paa"];
                _u setObjectTextureGlobal [2, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_03_black_CO.paa"];
                _u setObjectTextureGlobal [3, "\A3\Soft_F_Exp\LSV_01\Data\NATO_LSV_Adds_black_CO.paa"];
            };
        };
    };

    // Random textures for Ghosthawks
    if (_t in _ghosthawks) exitWith {
        _random = floor(random 3);
        call {
            if (_random == 0) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext01_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext02_CO.paa"];
            };
            if (_random == 1) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext01_BLUFOR_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext02_BLUFOR_CO.paa"];
            };
            if (_random == 2) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Air_F_Exp\Heli_Transport_01\Data\Heli_Transport_01_ext01_tropic_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Air_F_Exp\Heli_Transport_01\Data\Heli_Transport_01_ext02_tropic_CO.paa"];
            };
        };

        // Turret locking system
        _u setVariable ["turrets_locked", true, true];
    	[[_u, 1, "LMG_Minigun_Transport", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
    	[[_u, 2, "LMG_Minigun_Transport2", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
    };

    // Random textures for Hurons
    if (_t in _hurons) exitWith {
        _random = floor(random 2);
        call {
            if (_random == 0) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Air_F_Heli\Heli_Transport_03\Data\Heli_Transport_03_ext01_black_CO.paa"];
                _u setObjectTextureGlobal [1, "\a3\air_f_heli\heli_transport_03\data\heli_transport_03_ext02_black_co.paa"];
            };
            if (_random == 1) exitWith {
                _u setObjectTextureGlobal [0, "\a3\air_f_heli\heli_transport_03\data\heli_transport_03_ext01_co.paa"];
                _u setObjectTextureGlobal [1, "\a3\air_f_heli\heli_transport_03\data\heli_transport_03_ext02_co.paa"];
            };
        };

        // Turret locking system
        _u setVariable ["turrets_locked", true, true];
    	[[_u, 1, "LMG_Minigun_Transport", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
    	[[_u, 2, "LMG_Minigun_Transport2", 0], "QS_fnc_uh80Turret", true, false] spawn BIS_fnc_MP;
    };

    // Random textures for Blackfishes
    if (_t in _blackfishes) exitWith {
        _random = floor(random 2);
        call {
            if (_random == 0) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT01_blue_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT02_blue_CO.paa"];
                _u setObjectTextureGlobal [2, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT03_blue_CO.paa"];
                _u setObjectTextureGlobal [3, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT04_blue_CO.paa"];
            };
            if (_random == 1) exitWith {
                _u setObjectTextureGlobal [0, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT01_olive_CO.paa"];
                _u setObjectTextureGlobal [1, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT02_olive_CO.paa"];
                _u setObjectTextureGlobal [2, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT03_olive_CO.paa"];
                _u setObjectTextureGlobal [3, "\A3\Air_F_Exp\VTOL_01\Data\VTOL_01_EXT04_olive_CO.paa"];
            };
        };
    };
};

// decrease radar scan range
if (_u isKindOf "Air") then {
    _currentScanRange = _u getVariable ["irScanRangeMax", 1500];
    if (_currentScanRange > 1000) then {
        _u setVariable ["irScanRangeMax", 1500, true];
    };
};

if (_t in _noThermalVision) then {
    _u disableTIEquipment true;
};

//===== Vehicle Killer monitor system
[_u] call QS_fnc_killerCatcher;
