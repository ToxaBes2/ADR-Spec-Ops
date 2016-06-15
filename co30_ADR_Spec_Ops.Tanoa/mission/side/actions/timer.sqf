/*
Author: ToxaBes
Description: timer for bomb
*/
private ["_object", "_time", "_step"];
if (!TIMER_IN_USE) then {
    TIMER_IN_USE = true; publicVariable "TIMER_IN_USE";
    player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
    _object = _this select 0;
    _time = _this select 3 select 0;
    _step = _this select 3 select 1;
    [_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
    _basePos = getMarkerPos "respawn_west";
    while {_time > 0} do {    
        if (!alive _object) exitWith {};
        hqSideChat = format ["%1 секунд до подрыва", _time];        
        publicVariable "hqSideChat"; 
        [WEST, "HQ"] sideChat hqSideChat;
        _time = _time - _step; 
        sleep _step;
    };
    if (alive _object && (_object distance _basePos) > 2200) then {
        hqSideChat = "Подрыв!";        
    } else {
        hqSideChat = "Заряд находится менее чем в 2км от базы. Командование отключило таймер!"; 
    };
    publicVariable "hqSideChat"; 
    [WEST, "HQ"] sideChat hqSideChat;
    _epicenter = getPos _object;
    if ((_object distance _basePos) > 2200) then {  
       _object setDamage 0.95;    
       _bigBomb = createVehicle ["Bo_GBU12_LGB", _epicenter, [], 0, "NONE"];
    };
} else {
	hintSilent "Таймер уже запущен - ищите укрытие!";
};
