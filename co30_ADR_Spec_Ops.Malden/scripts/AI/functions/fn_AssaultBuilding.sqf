//Function that allows AI to clear a garrisoned building
params ["_Group","_Enemy"];

private _nBuildingLst = nearestObjects [_Enemy, ["House", "Building"], 25];
if (count _nBuildingLst < 1) exitWith {};

_nBuilding = nearestBuilding _Enemy;
_positions = [_nBuilding] call BIS_fnc_buildingPositions;
_Locations = [];
{
    _Locations pushBack [_x select 2, _x];
} forEach _positions;
_supressPositions = _nBuilding call VCM_fnc_FindWindows;
{
    _unit = _x;
    _alreadyAssaultBuilding = _unit getVariable ["ASSAULT_BUILDING", false];
    if !(_alreadyAssaultBuilding) then {
        _unit setVariable ["ASSAULT_BUILDING", true];
        _direction = [_unit, _Enemy] call BIS_fnc_dirTo;
        _unit setDir _direction;        
        _allowedTargets = [];
        {
            _attackPosition = _x;
            _unit lookAt _attackPosition;
            _attackDir = [_unit, _attackPosition] call BIS_fnc_dirTo;
            _unit setDir _attackDir;
            _aimPos = aimPos _unit;
            _objs = lineIntersectsWith [_aimPos, _attackPosition, _unit, _nBuilding];
            if (count _objs == 0) then {
                _allowedTargets pushBack _attackPosition;
            };
        } forEach _supressPositions;               
        _supressPos = getPos _Enemy;
        if (count _allowedTargets > 0) then { 
            _supressPos = selectRandom _allowedTargets;
        };

        [_unit, _Locations, _supressPos] spawn {
            _unit = _this select 0;
            _bpos = _this select 1;
            _supressPos = _this select 2;          
            _launcher = false;
            _machineGun = false;
            _machineGuns = ["MMG_02_base_F","arifle_MX_SW_F","LMG_Mk200_F","LMG_Zafir_F","MMG_01_base_F"];
            if (secondaryWeapon _unit isKindOf ["Launcher", configFile >> "CfgWeapons"]) then {
                _launcher = true; 
            }; 
            _gunCheck = {(primaryWeapon _unit) isKindOf [_x, configFile >> "CfgWeapons"]} count _machineGuns;
            if (_gunCheck != 0) then {
                _machineGun = true;
            };
            _target = createVehicle ["SuppressTarget",[0,0,0],[],0,'NONE'];
            waitUntil {!isNull _target};
            _target setPos _supressPos;
            _distance = _unit distance2D _target;
            _supressDir = [_supressPos, _unit] call BIS_fnc_dirTo;
            _unit setDir _supressDir;   
            _unit lookAt _target;
            _unit doTarget _target;
            _unit reveal [_target, 4];
            if (_machineGun) then {
                _unit doFire _target; 
                _unit doSuppressiveFire _supressPos;   
                sleep 4 + (random 3);
            } else {
                if (_launcher && _distance > 15) then {
                    if (VCM_Debug) then {systemchat "launcher!!!";};
                    _unit setUnitPos "UP";
                    _unit setDir _supressDir;
                    _unit selectWeapon (secondaryWeapon _unit);
                    waitUntil {currentWeapon _unit == secondaryWeapon _unit || !alive _unit};
                    _supressDir = _unit getDir _supressPos;
                    _unit setUnitPos "UP";
                    waitUntil {stance _unit == "STAND" || !alive _unit};
                    _unit setDir _supressDir;
                    _unit disableAI "ALL"; 
                    _unit enableAI "ANIM";  
                    _unit playAction "SecondaryWeapon";
                    sleep 3.00;
                    _unit enableAI "MOVE";  
                    _unit enableAI "FSM";
                    _unit setDir _supressDir;
                    _unit fire (secondaryWeapon _unit);
                    sleep 5;
                    _unit enableAI "ALL";                
                } else {
                    if (_distance < 50 && {_distance > 10}) then {
                        _unit forceWeaponFire ["HandGrenadeMuzzle","HandGrenadeMuzzle"];                
                        _unit forceWeaponFire ["MiniGrenadeMuzzle","MiniGrenadeMuzzle"];
                    } else {
                        if (_distance < 60 && {_distance > 6}) then {
                            _unit forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"];
                        };
                    }; 
                };
            };
            sleep 10;
            deleteVehicle _target;
            _dangerUntil = time + 180;
            while {count _bpos > 0 && {time < _dangerUntil}} do {
                _toPos = ((_bpos deleteAt 0) select 1);
                waitUntil {getSuppression _unit < 0.4};
                doStop _unit;       
                _unit doMove _toPos;
                waitUntil {unitReady _unit};            
                doStop _unit;
                sleep (5 + random 20);
            };
            if (alive _unit) then {
                _unit setUnitPosWeak "Auto";
                [_unit] joinSilent (group _unit);
                _unit setVariable ["ASSAULT_BUILDING", false];
            };
        };
    };
} foreach (units _Group);

