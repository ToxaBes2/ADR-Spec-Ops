private ["_failedText"];

_decreaseScore = true;
if !(isNil "MISSION_START_TIME") then {
    _startTime = MISSION_START_TIME;
    _delta = time - _startTime;
    if (_delta < 300) then {
        _decreaseScore = false;
    };
};

if (_this select 0) then {
    if (_decreaseScore) then {
        _failedText = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#F44336'>Провалена</t><br/>____________________<br/>Уровень разития базы синих уменьшен на 1.<br/><br/>Впредь будьте бдительней и работайте сообща.<br/><br/>Выдвигайтесь на базу или прямиком на точку захвата.</t>";
    } else {
    	_failedText = "<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#F44336'>Провалена</t><br/>____________________<br/>Уровень разития базы синих не изменился<br/><br/>т.к. с начала миссии прошло меньше 5 минут.<br/><br/>Выдвигайтесь на базу или прямиком на точку захвата.</t>";
    };
    showNotification = ["FailedSpecMission", sideMarkerText];
} else {
    if (_decreaseScore) then {
        _failedText = "<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#F44336'>Провалено</t><br/>____________________<br/>Уровень разития базы синих уменьшен на 1.<br/><br/>Впредь будьте бдительней и работайте сообща.<br/><br/>Выдвигайтесь на базу или прямиком на точку захвата.</t>";
    } else {
    	_failedText = "<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#F44336'>Провалено</t><br/>____________________<br/>Уровень разития базы синих не изменился<br/><br/>т.к. с начала миссии прошло меньше 5 минут.<br/><br/>Выдвигайтесь на базу или прямиком на точку захвата.</t>";    
    };
    showNotification = ["FailedSideMission", sideMarkerText];
};

publicVariable "showNotification";
GlobalSideHint = [west, _failedText]; publicVariable "GlobalSideHint"; (parseText _failedText) remoteExec ["hint", west];

if (_decreaseScore) then {
    BLUFOR_BASE_SCORE = BLUFOR_BASE_SCORE - 1; 
    if (BLUFOR_BASE_SCORE < 0) then {
    	BLUFOR_BASE_SCORE = 0;
    };
    publicVariable "BLUFOR_BASE_SCORE";
    [BLUFOR_BASE_SCORE] call QS_fnc_setBaseBlufor;
};