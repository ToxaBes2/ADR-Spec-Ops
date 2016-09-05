_rewards =
[
	["Ящик с базовым оружием BLUFOR", "Box_T_NATO_Wps_F", false],
    ["Ящик с базовым оружием OPFOR", "Box_T_East_Wps_F", false],
    ["Ящик с базовым оружием Синдиката", "Box_Syndicate_Wps_F", false],
    ["Ящик с базовыми боеприпасами OPFOR", "Box_T_East_Ammo_F", false],
    ["Ящик с базовыми боеприпасами Синдиката", "Box_Syndicate_Ammo_F", false],
    ["Ящик со взрывчаткой СВУ", "Box_IED_Exp_F", false],
    ["Ящик со взрывчаткой OPFOR", "Box_East_AmmoOrd_F", false],
    ["Ящик с гранатометами Синдиката", "Box_Syndicate_WpsLaunch_F", false],
    ["Ящик с гранатами OPFOR", "Box_East_Grenades_F", false],
    ["Ящик с основным оружием BLUFOR", "Box_NATO_Wps_F", false],
    ["Ящик с основным оружием партизан", "Box_IND_Wps_F", false],
    ["Ящик с основными боеприпасами BLUFOR", "Box_NATO_Ammo_F", false],
    ["Ящик с основными боеприпасами OPFOR", "Box_East_Ammo_F", false],
    ["Ящик со специальным оружием BLUFOR", "Box_T_NATO_WpsSpecial_F", false],
    ["Ящик со специальным оружием партизан", "Box_IND_WpsSpecial_F", false],
    ["Ящик со специальным оружием OPFOR", "Box_T_East_WpsSpecial_F", false],
    ["Ящик с припасами BLUFOR", "C_T_supplyCrate_F", false],
    ["Ящик с припасами OPFOR", "O_supplyCrate_F", false],
    ["Ящик с припасами партизан", "IG_supplyCrate_F", false],
    ["Ящик поддержки BLUFOR", "Box_NATO_Support_F", false],
    ["Ящик поддержки OPFOR", "Box_East_Support_F", false],
    ["Ящик поддержки партизан", "Box_IND_Support_F", false],
    ["Пусковые установки BLUFOR", "Box_NATO_WpsLaunch_F", false],
    ["Пусковые установки OPFOR", "Box_East_WpsLaunch_F", false],
    ["Пусковые установки партизан", "Box_IND_WpsLaunch_F", false], 
    ["Ящик со снаряжением BLUFOR", "Box_NATO_Equip_F", false],
    ["Ящик со снаряжением OPFOR", "Box_CSAT_Equip_F", false],
    ["Ящик со снаряжением партизан", "Box_AAF_Equip_F", false],
    ["Ящик с формой партизан", "Box_AAF_Uniforms_F", false],
    ["Вертолет M900", "C_Heli_Light_01_civil_F", false],
    ["Спортивный хэтчбек", "C_Hatchback_01_sport_F", false],
    ["Самолет Caesar BTT", "C_Plane_Civil_01_F", true],
    ["Дартер AR-2", "I_UAV_01_F", false],
    ["Стомпер с гранатометом", "I_UGV_01_rcws_F", false],
    ["Вертолет Хеллкет с оружием", "I_Heli_light_03_F", false],
    ["Страйдер с пулеметом", "I_MRAP_03_hmg_F", false],
    ["Миномет", "I_G_Mortar_01_F", false],
    ["Ифрит с пулеметом", "O_T_MRAP_02_hmg_ghex_F", false],
    ["Вертолет Pawnee", "B_Heli_Light_01_armed_F", false],
    ["Беспилотник KH-3A Fenghuang", "O_T_UAV_04_CAS_F", true],
    ["Беспилотник MQ-12 Falcon", "B_T_UAV_03_F", false]
];

_mode = _this select 0; // 1 - bunker, 2 - radiotower., 3 - side mission, 4 - spec operation
_veh = selectRandom _rewards;
_vehName = _veh select 0;
_vehVarname = _veh select 1;
_useAirfield = _veh select 2;
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
        if (WinRadiotower == resistance && WinBunker == resistance) then {
            _showFailBLUFOR = true;
        };
    }; 
	case 2 : { 
        _completeText = format["<t align='center'><t size='2.2'>Радиовышка</t><br/><t size='1.5' color='#C6FF00'>уничтожена силами партизан</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/><t size='1.1' color='#FFC107'>%1</t</t>", _vehName];    
        showNotification = ["Reward", _vehName, resistance];
        if (WinRadiotower == resistance && WinBunker == resistance) then {
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
if (_showFailBLUFOR) then {
   showNotification = ["TotalFailed", "Партизаны выполнили его раньше", west]; 
   publicVariable "showNotification";
};