/*
Author: ToxaBes
Description: spawn blufor reward
*/
if (!isNil "SELECTED_REWARD" && {count SELECTED_REWARD == 2}) then {
    disableSerialization;
    _idx = SELECTED_REWARD select 1;
    SELECTED_REWARD = nil; publicVariable "SELECTED_REWARD";
    _data = BLUFOR_REWARDS_LIST deleteAt _idx;
    publicVariable "BLUFOR_REWARDS_LIST";
    _display = uiNamespace getVariable['VAS_Reward_Display_Blufor', displayNull];
    _ctrl = _display displayCtrl 7777;
    _ctrl lnbDeleteRow _idx;
    _vehs = _data select 1;    
    _vehName = _vehs select 0;    
    hqSideChat = "Наградная техника будет доставлена через несколько минут..."; 
    publicVariable "hqSideChat"; 
    [WEST, "HQ"] sideChat hqSideChat;
    [_vehName] remoteExec ["QS_fnc_spawnReward", 2];
} else {
    hint "Выберите награду!";
};