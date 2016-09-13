/*
Author: ToxaBes
Description: endless game create target
*/
_object = objNull;
_type = "";
switch (_type) do { 
	case "target" : {
        removeFromRemainsCollector [_object];
        _object allowDamage false;
        clearMagazineCargo _object;
        clearWeaponCargo _object;
    }; 
	case "target_heli" : {
        removeFromRemainsCollector [_object];
        _object animateDoor ["Door_rear_source", 1, false];
        _object allowDamage false;
        clearMagazineCargo _object;
        clearWeaponCargo _object;
        _object lock 3;
    };
	case "guard_empty" : {
        removeFromRemainsCollector [_object];
        clearMagazineCargo _object;
        clearWeaponCargo _object;
        _object lock 3;
        _object allowDamage false;
        _object enableSimulation false;
    };
    case "guard_vehicle" : {
        removeFromRemainsCollector [_object];
        _object setFuel 0;
        createVehicleCrew _object;
        _object lock 3;
    }; 
    case "guard_vehicle_destroyed" : {
        removeFromRemainsCollector [_object];
        _object setDamage 0;
        _object setDamage 1;
        _object setDamage 1;
    }; 
    case "target_vehicle" : {
        removeFromRemainsCollector [_object]; 
        _object setdamage 0.6; 
        { 
        	_object setHit [_x, 1];  
        } forEach ["wheel_1_1_steering","wheel_2_1_steering","wheel_1_2_steering"]; 
        clearMagazineCargo _object;
        clearWeaponCargo _object;
        _object lock 2;
        _pe = _object spawn { 
            sleep 5; 
            if (!isNull __object) then { 
            	BIS_ppEffect = "#particlesource" createVehicleLocal position __object; 
            	BIS_ppEffect setParticleClass "AmmoSmokeParticles2"; 
            	BIS_ppEffect attachto [__object, [-0.5, 1, 0]]; }; 
        };
    }; 
    case "target_sdv" : {
        removeFromRemainsCollector [_object]; 
        _object setdamage 0.6; 
        clearMagazineCargo _object;
        clearWeaponCargo _object;
        _object lock 2;
    }; 
    case "target_uav" : {
        removeFromRemainsCollector [_object]; 
        if (isServer) then { 
        	_object setDamage 0.8; 
        	[_object, [180, 180, 0]] call BIS_fnc_setObjectRotation; 
        	_object action ["LandGearUp", _object]; 
        }; 
        _pe = _object spawn { 
            sleep 5; 
            if (!isNull __object) then { 
            	BIS_ppEffect = "#particlesource" createVehicleLocal position __object; 
            	BIS_ppEffect setParticleClass "AmmoSmokeParticles2"; 
            	BIS_ppEffect attachto [__object, [-0.5, 1, 0]]; }; 
        };
    }; 
    case "target_heli_destroyed" : {
        removeFromRemainsCollector [_object]; 
        _object setDamage 0; 
        _object setDamage 1; 
        _object setDamage 0;
        _pe = _object spawn { 
            sleep 5; 
            if (!isNull __object) then { 
            	BIS_ppEffect = "#particlesource" createVehicleLocal position __object; 
            	BIS_ppEffect setParticleClass "AmmoSmokeParticles2"; 
            	BIS_ppEffect attachto [__object, [-0.5, 1, 0]]; 
            }; 
        };
    }; 
};





