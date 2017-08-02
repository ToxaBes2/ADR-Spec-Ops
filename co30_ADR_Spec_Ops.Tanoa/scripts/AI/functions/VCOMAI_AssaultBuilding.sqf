private ["_Enemy", "_nBuilding", "_Locations"];

_Unit = _this select 0;
_VCOMAI_ActivelyClearing = _this select 1;
_VCOMAI_ActivelyAssault = _this select 2;
_VCOM_GARRISONED = _Unit getvariable ["VCOM_GARRISONED", false];
if (_VCOMAI_ActivelyClearing || {_VCOM_GARRISONED} || {_VCOMAI_ActivelyAssault}) exitWith {};
_Enemy = _Unit call VCOMAI_ClosestEnemy;
if (isNil "_Enemy" || {format ["%1", _Enemy] == "[0,0,0]"}) exitWith {};
_nBuilding = nearestBuilding _Enemy;
_Locations = [_nBuilding] call BIS_fnc_buildingPositions;
_SupressPositions = [];
if (count _Locations > 0) then {
    _SupressPositions = _nBuilding call VCOMAI_FindWindows;
    if (count _SupressPositions == 0) then {
        _SupressPositions pushBack (getPosATL _nBuilding);
    };       
    [_Unit, _SupressPositions, _Locations, _nBuilding] spawn {
        _Unit = _this select 0;
        _SupressPositions = _this select 1;
        _Locations = _this select 2;
        _nBuilding = _this select 3;
        _attackPosition = selectRandom _SupressPositions;
        if (_attackPosition select 2 < 1) then {
            _attackPosition set [2, 1];
        };
        _direction = [_Unit, _attackPosition] call BIS_fnc_dirTo;         
        _previousWeapon = currentWeapon _Unit;
        _CheckDistance = _Unit distance2D _attackPosition;  
        _target = "SuppressTarget" createVehicle _attackPosition;           
        _Unit setDir _direction;
        _Unit lookAt _target;
        _Unit doTarget _target; 
        sleep 2;
        _nearestContactArray = lineIntersectsObjs [(eyePos _Unit),(ATLtoASL screenToWorld [0.5,0.5]),objNull,objNull,false,2];
        _nearestContact = objNull;
        if (count _nearestContactArray > 0) then {
            _nearestContact = _nearestContactArray select 0;
        };
        if (_nBuilding == _nearestContact) then {
            _supressTime = 2 + (random 3);            
            _Unit setDir _direction;
            _Unit lookAt _target;
            _Unit doTarget _target;
            _Unit doFire _target; 
            _Unit doSuppressiveFire _attackPosition;
            sleep _supressTime;  
            _Unit doWatch _attackPosition;        
            if (_Unit hasWeapon "launch_RPG32_F" || _Unit hasWeapon "launch_RPG32_ghex_F" || Unit hasWeapon "launch_NLAW_F") then {                   
                _Unit setDir _direction;
                _Unit lookAt _target;
                _Unit doTarget _target;               
                _Unit selectWeapon (secondaryWeapon _Unit);            
                _Unit fire (secondaryWeapon _Unit);
                sleep 3;
                _Unit selectWeapon _previousWeapon;                  
            } else {
                _Unit setDir _direction;
                _Unit lookAt _target;
                _Unit doTarget _target;
                if (_CheckDistance < 50 && {_CheckDistance > 10}) then {
                    _Unit forceWeaponFire ["HandGrenadeMuzzle","HandGrenadeMuzzle"];                
                    _Unit forceWeaponFire ["MiniGrenadeMuzzle","MiniGrenadeMuzzle"];
                };                          
            };  
            sleep 1;
            if (_CheckDistance < 60 && {_CheckDistance > 6}) then {
                _Unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
            };   
            sleep 2; 
            _Unit doWatch objNull;  
            deleteVehicle _target;
            _Unit doMove _attackPosition;
            sleep 8;
            _Unit setBehaviour "COMBAT";
            _cnt = (count _Locations) - 1;
            for "_i" from 0 to _cnt do {
                _Unit doMove (_Locations select _i);
		        _timeout = time + 40;
		        waitUntil {moveToCompleted _Unit || moveToFailed _Unit || !alive _Unit || _timeout < time};
                sleep 2;
            };     
        } else {            
            _Unit doMove _attackPosition;
            _timeout = time + 30;
		    waitUntil {moveToCompleted _Unit || moveToFailed _Unit || !alive _Unit || _timeout < time};
		    if (_CheckDistance < 50 && {_CheckDistance > 6}) then {
                _Unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
            };  
        };                               
    };
};
