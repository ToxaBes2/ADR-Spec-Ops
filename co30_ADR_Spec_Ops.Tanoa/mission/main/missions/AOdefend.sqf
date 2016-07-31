/*
Author:	Jester [AW] & Quiksilver
Description: When AO is complete, a chance that OPFOR will counterattack.
*/
private ["_target","_enemiesArray","_nameAO","_positionAO","_defendMessages","_targetStartText","_playersOnlineHint","_selectedType","_group","_inside","_allPlayers"];
_target = _this select 0;
_nameAO = _target select 0;
_positionAO = _target select 1;
_defendMessages = [
	"Враг контратакует! Займите круговую оборону для защиты захваченной территории.",
	"Противник вызвал подкрепление!"
];
_targetStartText = format [
	"<t align='center' size='2.2'>Оборона</t><br/><t size='1.5' align='center' color='#FFC107'>%1</t><br/>____________________<br/>Враг контратакует! Займите оборонительные позиции!",
	_nameAO
];
_enemiesArray = [];
GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
showNotification = ["NewMainDefend", _nameAO]; publicVariable "showNotification";
{_x setMarkerPos _positionAO;} forEach ["aoCircle_2", "aoMarker_2"];
"aoMarker_2" setMarkerText format["Оборона: %1", _nameAO];
sleep 10;
currentAOUp = true; publicVariable "currentAOUp";
radioTowerAlive = false; publicVariable "radioTowerAlive";
_playersOnlineHint = format [
	"<t size='1.5' align='center' color='#F44336'>Контратака</t><br/><br/>____________________<br/>Противник перегруппировал часть своих сил на контратаку захваченной нами точки.",
	_nameAO
];
GlobalHint = _playersOnlineHint; publicVariable "GlobalHint"; hint parseText GlobalHint;
sleep 10;
hqSideChat = selectRandom _defendMessages; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;
_selectedType = selectRandom [1,2,3,4,5];
switch (_selectedType) do {
	case 1 : {
        _group = [_positionAO,3,[3,4],0,[1,0],EAST] call QS_fnc_defendAO;
    };
	case 2 : {
        _group = [_positionAO,2,[1,4],1,[2,8],EAST] call QS_fnc_defendAO;
    };
	case 3 : {
        _group = [_positionAO,3,[2,4],0,[1,0],EAST] call QS_fnc_defendAO;
    };
    case 4 : {
        _group = [_positionAO,3,[1,4],1,[1,12],EAST] call QS_fnc_defendAO;
    };
    case 5 : {
        _group = [_positionAO,1,[0,0],0,[3,8],EAST] call QS_fnc_defendAO;
    };
	default {
        _group = [_positionAO,3,[1,4],1,[1,10],EAST] call QS_fnc_defendAO;
    };
};
_enemiesArray = _enemiesArray + [_group];
hint "Вблизи захваченной территории, обнаружены вражеские силы.";
sleep 5;
hqSideChat = "Обороняйтесь, противник начинает штурм!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
sleep 120;
_inside = false;
_allPlayers = [] call BIS_fnc_listPlayers;
{
    if (!_inside) then {
        if (_positionAO distance2D _x <= 500) then {
            _inside = true;
        };
    };
} forEach _allPlayers;
_aliveBots = 0;
{
	if (side _x == EAST) then {
        {
            if (_positionAO distance2D _x <= 500) then {
                _aliveBots = _aliveBots + 1;
            };
        } forEach (units _x);
	};
} forEach allGroups;
while {_inside && _aliveBots > PARAMS_EnemyLeftThreshhold} do {
    sleep 10;
    _inside = false;
    _allPlayers = [] call BIS_fnc_listPlayers;
    {
        if (!_inside) then {
            if (!captive _x) then {
                if (_positionAO distance2D _x <= 500) then {
                    _inside = true;
                };
            };
        };
    } forEach _allPlayers;
    _aliveBots = 0;
    {
    	if (side _x == EAST) then {
    		{
                if (_positionAO distance2D _x <= 500) then {
                    _aliveBots = _aliveBots + 1;
                };
            } forEach (units _x);
    	};
    } forEach allGroups;
    sleep 10;
    if (!_inside) then {
        hqSideChat = "В зоне БД не осталось наших бойцов! Мы теряем позиции, поторопитесь!";
        publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
        sleep 120;
        _allPlayers = [] call BIS_fnc_listPlayers;
        {
            if (!_inside) then {
                if (!captive _x) then {
                    if (_positionAO distance2D _x <= 500) then {
                        _inside = true;
                    };
                };
            };
        } forEach _allPlayers;
    };
    //[WEST,"HQ"] sideChat format ["inside: %1, bots: %2", _inside, _aliveBots];
};
if (!_inside) then {
	hqSideChat = "Противник захватил наши позиции!";
	showNotification = ["FailedMainDefended", _nameAO]; publicVariable "showNotification";
	DEFEND_AO_VICTORY = false;
} else {
    hqSideChat = "Атака врага отбита, противник отступает!";
	showNotification = ["CompletedMainDefended", _nameAO]; publicVariable "showNotification";
    DEFEND_AO_VICTORY = true;
};
publicVariable "DEFEND_AO_VICTORY";
currentAOUp = false; publicVariable "currentAOUp";
publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
[DEFEND_AO_VEHICLES] call QS_fnc_TBdeleteObjects;
[_enemiesArray] call QS_fnc_TBdeleteObjects;
