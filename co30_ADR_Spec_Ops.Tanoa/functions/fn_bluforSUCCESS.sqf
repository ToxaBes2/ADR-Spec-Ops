/*
Author: ToxaBes
Description: blufor rewards per mission type
*/
_rewards = [
    ["То-199 «Неофрон»", ["O_Plane_CAS_02_dynamicLoadout_F"]],
    ["А-164 «Вайпаут»", ["B_Plane_CAS_01_dynamicLoadout_F"]],
    ["AH-99 «Блэкфут»", ["B_Heli_Attack_01_dynamicLoadout_F"]],
    ["ПО-30 «Касатка»", ["O_Heli_Light_02_dynamicLoadout_F"]],
    ["Беспилотник KH-3A Fenghuang", ["O_T_UAV_04_CAS_F"]],    
    ["AFV-4 «Горгона»", ["I_APC_Wheeled_03_cannon_F"]],
    ["БТР-К «Камыш»", ["O_APC_Tracked_02_cannon_F"]],
    ["ЗСУ-39 «Тигр»", ["O_APC_Tracked_02_AA_F"]],
    ["IFV-6a «Гепард»", ["B_APC_Tracked_01_AA_F"]],
    ["FV-720 «Мора»", ["I_APC_tracked_03_cannon_F"]],
    ["MSE-3 «Марид» с НУРС", ["O_APC_Wheeled_02_rcws_F"]],
    ["Ми-48 «Кайман»", ["O_Heli_Attack_02_dynamicLoadout_F"]],
    ["Y-32 Xi'an", ["O_T_VTOL_02_infantry_dynamicLoadout_F"]],
    ["T-100 «Варсук»", ["O_MBT_02_cannon_F"]],
    ["MBT-52 «Кума»", ["I_MBT_03_cannon_F"]],   
    ["M2A1 «Сламмер»", ["B_MBT_01_cannon_F"]],
    ["M2A4 «Сламмер» UP", ["B_MBT_01_TUSK_F"]],
    ["V-44 X Blackfish", ["B_T_VTOL_01_armed_F"]],
    ["M4 «Скорчер»", ["B_MBT_01_arty_F"]],
    ["Беспилотник Sentinel", ["B_UAV_05_F"]], 
    ["F/A-181 «Черная Оса 2»", ["B_Plane_Fighter_01_F"]], 
    ["F/A-181 «Черная Оса 2» стелс", ["B_Plane_Fighter_01_Stealth_F"]], 
    ["To-201 «Шикра»", ["O_Plane_Fighter_02_F"]], 
    ["To-201 «Шикра» стелс", ["O_Plane_Fighter_02_Stealth_F"]], 
    ["А-149 «Грифон»", ["I_Plane_Fighter_04_F"]]
];
_mode = _this select 0; // 1 - bunker + radiotower, 2 - defend AO, 3 - side mission, 4 - special operation
_vehName = "";
_vehVarname = "";
if (_mode > 2) then {
    _veh = selectRandom _rewards;
    _vehName = _veh select 0;
    _vehVarname = _veh select 1;
    BLUFOR_REWARDS_LIST pushBack [_vehName, _vehVarname]; publicVariable "BLUFOR_REWARDS_LIST";
};
_completeText = "";
_showFailBLUFOR = false;
if !(isNil "sideMarkerText") then {
    if (typename sideMarkerText == "ARRAY") then {
        sideMarkerText = sideMarkerText select 0;
    };
};
switch (_mode) do { 
    case 1 : {
        BLUFOR_BASE_SCORE = BLUFOR_BASE_SCORE + 1; publicVariable "BLUFOR_BASE_SCORE";
        [BLUFOR_BASE_SCORE] call QS_fnc_setBaseBlufor;       
        _completeText = format["<t align='center'><t size='2.2'>Основное задание</t><br/><t size='1.5' color='#C6FF00'>выполненно регулярной армией</t><br/>____________________<br/>Уровень базы регулярной армии увеличился на 1.<br/><br/><t size='1.1' color='#FFC107'>Новый уровень: %1</t</t>", BLUFOR_BASE_SCORE];
        showNotification = ["Reward", _vehName, resistance];
    }; 
    case 3 : { 
        _completeText = format["<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#C6FF00'>выполненно регулярной армией</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];    
        showNotification = ["CompletedSideMission", sideMarkerText];
    };
    case 4 : { 
        _completeText = format["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#C6FF00'>выполнена регулярной армией</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];    
        showNotification = ["CompletedSpecMission", sideMarkerText]; 
    };
};

GlobalSideHint = [west, _completeText]; publicVariable "GlobalSideHint"; (parseText _completeText) remoteExec ["hint", west];
publicVariable "showNotification"; 
showNotification = ["Reward", _vehName, west]; publicVariable "showNotification";