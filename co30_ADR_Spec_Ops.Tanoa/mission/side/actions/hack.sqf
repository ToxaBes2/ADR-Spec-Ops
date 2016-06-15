/*
Author: ToxaBes
Description: hack terminal
*/
#define ENEMY_SIDE EAST
private ["_object", "_time", "_step", "_failed", "_grp", "_units"];
player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
sleep 1;
_failed = false;
_time = 100;
_step = 2;
_object = _this select 0;
[_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
sleep 2;
hqSideChat = "Оставайтесь у теминала. Подключение...";
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
[_object, 1] call BIS_fnc_dataTerminalAnimate;
sleep 5;
hqSideChat = "Оставайтесь у теминала. Загрузка...";
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
[_object, 2] call BIS_fnc_dataTerminalAnimate;
sleep 5;
[_object, 3] call BIS_fnc_dataTerminalAnimate;
hqSideChat = "Оставайтесь у теминала. 100 сек до завершения...";
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
while {_time > 0} do {
    if (!alive player || player distance _object > 10) exitWith {
    	_failed = true;        
    };    
    _time = _time - _step; 
    sleep _step;
};
if (_failed) then {
    _object setVariable ["GRAPESWRATH_HACKED", "failed", true];
    [_object,"red","red","red"] call BIS_fnc_DataTerminalColor;
    hqSideChat = "Взлом прерван! Терминал заблокирован!";    
} else {
	_object setVariable ["GRAPESWRATH_HACKED", "hacked", true];
	[_object,"green","blue","orange"] call BIS_fnc_DataTerminalColor;
	hqSideChat = "Терминал взломан!";
};
publicVariable "hqSideChat"; 
[WEST, "HQ"] sideChat hqSideChat;
[_object, 0] call BIS_fnc_dataTerminalAnimate;
