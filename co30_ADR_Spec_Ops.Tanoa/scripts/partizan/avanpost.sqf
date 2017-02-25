/*
Author: ToxaBes
Desciption: deploy partizan avanpost from mobile truck
*/
_veh = _this select 0;
_player = _this select 1;
_stance = "Pknl";
_raised = "Sras";
_weapon = "Wrfl";
if (stance _player == "STAND") then {
    _stance = "Perc";
};
if (weaponLowered _player) then {
    _raised = "Slow";
};
call {
    if ((currentWeapon _player == handgunWeapon _player) and (handgunWeapon _player != "")) exitWith {
        _weapon = "Wpst";
    };
    if ((currentWeapon _player == secondaryWeapon _player) and (secondaryWeapon _player != "")) exitWith {
        _weapon = "Wlnr";
    };
    if (currentWeapon _player == "") exitWith {
        _raised = "Snon";
        _weapon = "Wnon";
    };
};
// Play animation
_player playMove ("Ainv" + _stance + "Mstp" + _raised + _weapon + "Dnon_Putdown_Amov" + _stance + "Mstp" + _raised + _weapon + "Dnon");
sleep 1;
{
    _x action ["EJECT", _veh];
} forEach (crew _veh);
_veh lock 2;
_veh setVelocity [0, 0, 0];
_campPos = getPos _veh;
deleteVehicle _veh;
[_campPos] call QS_fnc_addAvanpost;