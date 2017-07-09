/*
Author:	ToxaBes
Description: fill cargo patrols with bots in given raduis
Format: [startPos, radius, side, aiming accuracy 0-1 (optional)]
*/
if (!isServer) exitWith {};

// prepare params
_startPos = _this select 0;
if (count _startPos > 2) then {
    _startPos resize 2;
};
_radius = _this select 1;
_side = _this select 2;
_accuracy = _this param [3, -1];
if (_accuracy == -1) then {
    switch (PARAMS_AimingAccuracy) do {
        case 0 : {  _accuracy = 0.1; };
        case 1 : {  _accuracy = 0.3; };
        case 2 : {  _accuracy = 0.5; };
        case 3 : {  _accuracy = 0.7; };
        case 4 : {  _accuracy = 1; };
        default {   _accuracy = 1; };
    };
};
_positions = [
    [-1.5,-1.5,4],
    [-1.5,1.5,4],
    [1.5,1.5,4]
];
_units = [];
switch (_side) do {
    case WEST : {
        _units = ["B_Sharpshooter_F","B_Recon_Sharpshooter_F","B_CTRG_Sharphooter_F","B_HeavyGunner_F","B_G_Sharpshooter_F","B_sniper_F"];
    };
    case RESISTANCE : {
        _units = ["I_G_Sharpshooter_F","I_ghillie_ard_F","I_ghillie_sard_F","I_ghillie_lsh_F"];
    };
    case EAST : {
        _units = ["O_Urban_Sharpshooter_F","O_Urban_HeavyGunner_F","O_Sharpshooter_F","O_sniper_F"];
    };
};
_groups = [];
_nearestTargets = nearestObjects [_startPos, ["Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F"], _radius];
{
    _guardGroup = createGroup _side;
    _hqPos = getPosASL _x;
    {
        _unitType = selectRandom _units;
        _unitPos = [(_hqPos select 0) + (_x select 0), (_hqPos select 1) + (_x select 1), (_hqPos select 2) + (_x select 2)];
        _unitType createUnit [[0,0,0], _guardGroup, "[this] call QS_fnc_moveToHC;currentGuard = this;", 0, (selectRandom ["CAPTAIN","MAJOR","COLONEL"])];
        currentGuard setVariable ["BIS_enableRandomization", false];
        currentGuard allowDamage false;
        currentGuard setPosASL _unitPos;
        currentGuard setDir (random 360);
        doStop currentGuard;
        currentGuard setUnitPos "UP";
        [currentGuard,(selectRandom ["WATCH1","WATCH2"]),"FULL", {lifestate currentGuard == "INJURED"}, "COMBAT"] call BIS_fnc_ambientAnimCombat;
        currentGuard allowDamage true;
    } forEach _positions;
    _guardGroup setBehaviour "SAFE";
    _guardGroup setCombatMode "RED";
    [(units _guardGroup)] call QS_fnc_setSkill4;
    if (_accuracy > -1) then {
        {
            _x setSkill ["aimingAccuracy", _accuracy];
        } forEach (units _guardGroup);
    };
    _groups = _groups + [_guardGroup];
} forEach _nearestTargets;

_groups
