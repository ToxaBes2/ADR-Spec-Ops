/*
Author: ToxaBes
Description: timer for bomb
*/
private ["_stance", "_raised", "_weapon", "_object", "_time", "_step", "_basePos", "_epicenter", "_bigBomb"];
if (!TIMER_IN_USE) then {
    TIMER_IN_USE = true; publicVariable "TIMER_IN_USE";

    // Determine what animation to play
    // If player is prone play kneeling animation
    _stance = "Pknl";
    _raised = "Sras";
    _weapon = "Wrfl";
    if (stance player == "STAND") then {
        _stance = "Perc";
    };
    if (weaponLowered player) then {
        _raised = "Slow";
    };
    call {
        if ((currentWeapon player == handgunWeapon player) and (handgunWeapon player != "")) exitWith {
            _weapon = "Wpst";
        };
        if ((currentWeapon player == secondaryWeapon player) and (secondaryWeapon player != "")) exitWith {
            _weapon = "Wlnr";
        };
        if (currentWeapon player == "") exitWith {
            _raised = "Snon";
            _weapon = "Wnon";
        };
    };

    NUCLEAR_TIMER_SIDE = side player;
    publicVariable "NUCLEAR_TIMER_SIDE";

    // Play animation
    player playMove ("Ainv" + _stance + "Mstp" + _raised + _weapon + "Dnon_Putdown_Amov" + _stance + "Mstp" + _raised + _weapon + "Dnon");

    _object = _this select 0;
    _time = _this select 3 select 0;
    _step = _this select 3 select 1;
    [_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
    _basePos = getMarkerPos "respawn_west";
    while {_time > 0} do {
        if (!alive _object) exitWith {};
        hqSideChat = format ["%1 секунд до подрыва", _time];
        publicVariable "hqSideChat";
        [playerSide, "HQ"] sideChat hqSideChat;
        _time = _time - _step;
        sleep _step;
    };
    if (alive _object && (_object distance _basePos) > 2200) then {
        hqSideChat = "Подрыв!";
    } else {
        hqSideChat = "Заряд находится менее чем в 2км от базы. Командование отключило таймер!";
    };
    publicVariable "hqSideChat";
    [playerSide, "HQ"] sideChat hqSideChat;
    _epicenter = getPos _object;
    if ((_object distance2D _basePos) > 2000) then {
       _object setDamage 0.95;
       _bigBomb = createVehicle ["Bo_GBU12_LGB", _epicenter, [], 0, "NONE"];
    };
} else {
	hintSilent "Таймер уже запущен - ищите укрытие!";
};
