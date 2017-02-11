/*
Author: ToxaBes
Description: partizan rewards per mission type
*/
_rewardsMainAO = [
    ["Оружие BLUFOR", ["Box_NATO_Equip_F", "Box_NATO_Wps_F", "Box_NATO_WpsSpecial_F"]],
    ["Припасы BLUFOR", ["Box_NATO_Support_F", "B_supplyCrate_F", "Box_NATO_Ammo_F"]],
    ["Оружие OPFOR", ["Box_CSAT_Equip_F", "Box_East_Wps_F", "Box_East_WpsSpecial_F"]],
    ["Припасы OPFOR", ["Box_East_Support_F", "O_supplyCrate_F", "Box_East_Ammo_F"]],
    ["Оружие партизан", ["Box_AAF_Equip_F", "Box_IND_Wps_F", "Box_IND_WpsSpecial_F"]],
    ["Припасы партизан", ["Box_IND_Support_F", "IG_supplyCrate_F", "Box_IND_Ammo_F"]],
    ["Снаряжение Синдиката", ["Box_Syndicate_Wps_F", "Box_Syndicate_Ammo_F"]],       
    ["Вертолет M900", ["B_Heli_Light_01_stripped_F"]],
    ["Самолет Caesar BTT", ["C_Plane_Civil_01_F"], true]
];
_rewardsSideMission = [
    ["Вооруженная боевая группа", ["bandits"]],
    ["Минно-взрывные средства", ["Box_NATO_AmmoOrd_F", "Box_East_AmmoOrd_F", "Box_IED_Exp_F"]],
    ["Пусковые установки", ["Box_NATO_WpsLaunch_F", "Box_East_WpsLaunch_F", "Box_IND_WpsLaunch_F", "Box_Syndicate_WpsLaunch_F"]],
    ["Противотанковая группа", ["atgroup"]],
    ["Qilin, Strider и Ifrit с пулеметами", ["O_T_LSV_02_armed_F", "I_MRAP_03_hmg_F", "O_MRAP_02_hmg_F"]],
    ["Отряд Viper", ["viper"]],    
    ["Беспилотник MQ-12 Falcon", ["B_T_UAV_03_F"]],
    ["Беспилотник KH-3A Fenghuang", ["O_T_UAV_04_CAS_F"], true],
    ["Стомпер с гранатометом + Дартер AR-2", ["I_UGV_01_rcws_F", "I_UAV_01_F"]],
    ["Отряд Viper", ["viper"]],
    ["Мобильный постановщик электронных помех", ["I_Truck_02_ammo_F", "Land_SatelliteAntenna_01_F"]],
    ["Мобильный Аванпост", ["I_Truck_02_medical_F"]],
    //["Техничка с ПВО средством", ["I_G_Offroad_01_F","I_static_AA_F"]],
    //["Техничка с ПТ средством", ["I_G_Offroad_01_F", "I_static_AT_F"]],
    ["Техничка с гранатометом", ["I_G_Offroad_01_F", "I_GMG_01_high_F"]],
    //["Техничка с пулеметом", ["I_G_Offroad_01_armed_F"]],
    //["Техничка с минометом", ["I_G_Offroad_01_F", "I_G_Mortar_01_F"]], 
    ["Отделение тяжелого оружия", ["heavyweapon"]],
    ["Вертолет Pawnee", ["B_Heli_Light_01_armed_F"]],     
    ["Вертолет Хеллкет (вооруженный)", ["I_Heli_light_03_F"]]
];
_rewards = _rewardsMainAO;
_mode = _this select 0; // 1 - bunker, 2 - radiotower., 3 - side mission, 4 - special operation
switch (_mode) do { 
    case 3 : { _rewards = _rewardsSideMission; }; 
    case 4 : { _rewards = _rewardsSideMission; }; 
};

_veh = selectRandom _rewards;
_vehName = _veh select 0;
_vehVarname = _veh select 1;
_useAirfield = false;
if (count _veh > 2) then {
    _useAirfield = _veh select 2;
};
_completeText = "";
_showFailBLUFOR = false;

PARTIZAN_REWARDS_LIST pushBack [_vehName, _vehVarname, _useAirfield]; publicVariable "PARTIZAN_REWARDS_LIST";
if !(isNil "sideMarkerText") then {
    if (typename sideMarkerText == "ARRAY") then {
        sideMarkerText = sideMarkerText select 0;
    };
};
switch (_mode) do { 
	case 1 : {
        _completeText = format["<t align='center'><t size='2.2'>Командный пункт</t><br/><t size='1.5' color='#C6FF00'>захвачен силами партизан</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];
        showNotification = ["Reward", _vehName, resistance];
        if (WinRadiotower isEqualTo resistance && WinBunker isEqualTo resistance) then {
            _showFailBLUFOR = true;
        };
    }; 
	case 2 : { 
        _completeText = format["<t align='center'><t size='2.2'>Радиовышка</t><br/><t size='1.5' color='#C6FF00'>уничтожена силами партизан</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];    
        showNotification = ["Reward", _vehName, resistance];
        if (WinRadiotower isEqualTo resistance && WinBunker isEqualTo resistance) then {
            _showFailBLUFOR = true;
        };
	}; 
	case 3 : { 
        _completeText = format["<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#C6FF00'>выполнено силами партизан</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];    
        showNotification = ["CompletedSideMission", sideMarkerText];
        _showFailBLUFOR = true;
	};
	case 4 : { 
        _completeText = format["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#C6FF00'>выполнена силами партизан</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];    
        showNotification = ["CompletedSpecMission", sideMarkerText]; 
        _showFailBLUFOR = true;
	};
};
publicVariable "showNotification";
GlobalSideHint = [resistance, _completeText]; publicVariable "GlobalSideHint"; 
(parseText _completeText) remoteExec ["hint", resistance]; 

_diplomacyPartizan = partizan_ammo getVariable ['DIPLOMACY', 0];
_diplomacyBlufor = base_arsenal_infantry getVariable ["DIPLOMACY", 0];
if (_diplomacyPartizan == 0 || _diplomacyBlufor == 0) then {
    if (_showFailBLUFOR) then {
        showNotification = ["TotalFailed", "Партизаны выполнили его раньше", west]; 
        publicVariable "showNotification";
    };
};
