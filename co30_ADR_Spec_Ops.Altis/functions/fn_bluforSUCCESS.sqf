/*
Author: ToxaBes
Description: blufor rewards per mission type
*/
_rewardsMainAO = [
    //["Qilin с пулеметом", ["O_T_LSV_02_armed_F"]],
    //["Страйдер с пулеметом", ["I_MRAP_03_hmg_F"]],
    //["Ифрит с пулеметом", ["O_MRAP_02_hmg_F"]],   
    //["Беспилотник MQ-12 Falcon", ["B_T_UAV_03_F"]],
    //["То-199 «Неофрон» (штурмовик)", ["O_Plane_CAS_02_F"]],
    //["А-164 «Вайпаут» (штурмовик)", ["B_Plane_CAS_01_F"]],
    //["Отряд CTRG", ["ctrg"]],
    //["M5 РСЗО «Сэндсторм»", ["B_MBT_01_mlrs_F"]],
    ["AH-99 «Блэкфут»", ["B_Heli_Attack_01_F"]],
    ["ПО-30 «Касатка»", ["O_Heli_Light_02_F"]],
    ["Беспилотник KH-3A Fenghuang", ["O_T_UAV_04_CAS_F"]],    
    ["AFV-4 «Горгона»", ["I_APC_Wheeled_03_cannon_F"]],
    ["БТР-К «Камыш»", ["O_APC_Tracked_02_cannon_F"]],
    ["ЗСУ-39 «Тигр»", ["O_APC_Tracked_02_AA_F"]],
    ["IFV-6a «Гепард»", ["B_APC_Tracked_01_AA_F"]],
    ["FV-720 «Мора»", ["I_APC_tracked_03_cannon_F"]],
    ["MSE-3 «Марид» с НУРС", ["O_APC_Wheeled_02_rcws_F"]],
    ["Ми-48 «Кайман»", ["O_Heli_Attack_02_black_F"]],
    ["Y-32 Xi'an", ["O_T_VTOL_02_vehicle_F"]],
    ["T-100 «Варсук»", ["O_MBT_02_cannon_F"]],
    ["MBT-52 «Кума»", ["I_MBT_03_cannon_F"]],   
    ["M2A1 «Сламмер»", ["B_MBT_01_cannon_F"]],
    ["M2A4 «Сламмер» UP", ["B_MBT_01_TUSK_F"]],
    ["V-44 X Blackfish", ["B_T_VTOL_01_armed_F"]],
    ["M4 «Скорчер»", ["B_MBT_01_arty_F"]]
];
_rewardsSideMission = [
    ["AH-99 «Блэкфут»", ["B_Heli_Attack_01_F"]],
    ["ПО-30 «Касатка»", ["O_Heli_Light_02_F"]],
    ["Беспилотник KH-3A Fenghuang", ["O_T_UAV_04_CAS_F"]],    
    ["AFV-4 «Горгона»", ["I_APC_Wheeled_03_cannon_F"]],
    ["БТР-К «Камыш»", ["O_APC_Tracked_02_cannon_F"]],
    ["ЗСУ-39 «Тигр»", ["O_APC_Tracked_02_AA_F"]],
    ["IFV-6a «Гепард»", ["B_APC_Tracked_01_AA_F"]],
    ["FV-720 «Мора»", ["I_APC_tracked_03_cannon_F"]],
    ["MSE-3 «Марид» с НУРС", ["O_APC_Wheeled_02_rcws_F"]],
    ["Ми-48 «Кайман»", ["O_Heli_Attack_02_black_F"]],
    ["Y-32 Xi'an", ["O_T_VTOL_02_vehicle_F"]],
    ["T-100 «Варсук»", ["O_MBT_02_cannon_F"]],
    ["MBT-52 «Кума»", ["I_MBT_03_cannon_F"]],   
    ["M2A1 «Сламмер»", ["B_MBT_01_cannon_F"]],
    ["M2A4 «Сламмер» UP", ["B_MBT_01_TUSK_F"]],
    ["V-44 X Blackfish", ["B_T_VTOL_01_armed_F"]],
    ["M4 «Скорчер»", ["B_MBT_01_arty_F"]]
];
_rewards = _rewardsMainAO;
_mode = _this select 0; // 1 - bunker + radiotower, 2 - defend AO, 3 - side mission, 4 - special operation
switch (_mode) do { 
    case 3 : { _rewards = _rewardsSideMission; }; 
    case 4 : { _rewards = _rewardsSideMission; }; 
};

_veh = selectRandom _rewards;
_vehName = _veh select 0;
_vehVarname = _veh select 1;
_completeText = "";
_showFailBLUFOR = false;

BLUFOR_REWARDS_LIST pushBack [_vehName, _vehVarname]; publicVariable "BLUFOR_REWARDS_LIST";
if !(isNil "sideMarkerText") then {
    if (typename sideMarkerText == "ARRAY") then {
        sideMarkerText = sideMarkerText select 0;
    };
};
switch (_mode) do { 
	case 1 : {
        _completeText = format["<t align='center'><t size='2.2'>Основное задание</t><br/><t size='1.5' color='#C6FF00'>выполненно регулярной армией</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];
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
