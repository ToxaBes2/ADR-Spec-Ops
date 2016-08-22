randomCivilian = {
	_unit = _this select 0;

	_rds_rhs_civilian = [
	"U_BG_Guerilla1_1",
    "U_BG_Guerilla2_1",
    "U_BG_Guerilla2_2",
    "U_BG_Guerilla2_3",
    "U_BG_Guerilla3_1",
    "U_BG_Guerilla3_2",
    "U_BG_Guerilla6_1",
    "U_BG_Guerrilla_6_1",
    "U_BG_leader",
    "U_IG_Guerrilla_6_1",
    "U_IG_leader",
    "U_I_G_resistanceLeader_F",
    "U_OG_Guerilla1_1",
    "U_OG_Guerilla2_1",
    "U_OG_Guerilla2_2",
    "U_OG_Guerilla2_3",
    "U_OG_Guerilla3_1",
    "U_OG_Guerilla3_2",
    "U_OG_Guerrilla_6_1",
    "U_OG_leader"
	] call BIS_fnc_selectRandom;

	_rhsHeadGear = [
	"H_Bandanna_camo",
    "H_Bandanna_cbr",
    "H_Bandanna_gry",
    "H_Bandanna_khk",
    "H_Bandanna_khk_hs",
    "H_Bandanna_mcamo",
    "H_Bandanna_sgg",
    "H_Bandanna_surfer",
    "H_Beret_02",
    "H_Beret_Colonel",
    "H_Beret_blk",
    "H_Beret_blk_POLICE",
    "H_Beret_brn_SF",
    "H_Beret_grn",
    "H_Beret_grn_SF",
    "H_Beret_red",
    "H_Cap_blk",
    "H_Cap_blk_CMMG",
    "H_Cap_blk_ION",
    "H_Cap_blu",
    "H_Cap_grn",
    "H_Cap_grn_BI",
    "H_Cap_headphones",
    "H_Cap_khaki_specops_UK",
    "H_Cap_oli",
    "H_Cap_oli_hs",
    "H_Cap_red",
    "H_Cap_tan",
    "H_Cap_tan_specops_US",
    "H_Hat_brown",
    "H_Hat_camo",
    "H_Hat_checker",
    "H_Hat_grey",
    "H_Hat_tan",
    "H_MilCap_blue",
    "H_MilCap_gry",
    "H_MilCap_mcamo",
    "H_MilCap_rucamo",
    "H_ShemagOpen_khk",
    "H_ShemagOpen_tan",
    "H_Shemag_khk",
    "H_Shemag_olive",
    "H_Shemag_olive_hs",
    "H_Shemag_tan",
    "H_StrawHat",
    "H_StrawHat_dark",
    "H_StrawHat_dark",
    "H_TurbanO_blk",
    "H_Watchcap_blk",
    "H_Watchcap_camo",
    "H_Watchcap_khk",
    "H_Watchcap_sgg"
	] call BIS_fnc_selectRandom;

	_taliFaces = [
	"AfricanHead_01",
    "AfricanHead_02",
    "AfricanHead_03",
    "AsianHead_A3_01",
    "AsianHead_A3_02",
    "AsianHead_A3_03",
    "GreekHead_A3_01",
    "GreekHead_A3_02",
    "GreekHead_A3_03",
    "GreekHead_A3_04",
    "GreekHead_A3_05",
    "GreekHead_A3_06",
    "GreekHead_A3_07",
    "GreekHead_A3_08",
    "GreekHead_A3_09",
    "NATOHead_01",
    "Nikos",
    "PersianHead_A3_01",
    "PersianHead_A3_02",
    "PersianHead_A3_03",
    "WhiteHead_02",
    "WhiteHead_03",
    "WhiteHead_04",
    "WhiteHead_05",
    "WhiteHead_06",
    "WhiteHead_07",
    "WhiteHead_08",
    "WhiteHead_09",
    "WhiteHead_10",
    "WhiteHead_11",
    "WhiteHead_12",
    "WhiteHead_13",
    "WhiteHead_14",
    "WhiteHead_15"
	] call BIS_fnc_selectRandom;

	_stripHim = {
		_it = _this select 0;
			removeAllWeapons _it;
			removeAllItems _it;
			removeAllAssignedItems _it;
			removeUniform _it;
			removeVest _it;
			removeBackpack _it;
			removeHeadgear _it;
			removeGoggles _it;	
	};

	_reclotheHim = {
		_guy = _this select 0;
		_guy forceAddUniform _rds_rhs_civilian;
		if (random 2 > 1) then {
			_guy addHeadgear _rhsHeadGear;
		};

		[[_guy,_taliFaces], "setCustomFace"] call BIS_fnc_MP;
		_guy setVariable ["BIS_noCoreConversations", true];
		
	};

	addBehaviour = {
		group (_this select 0) setBehaviour "CARELESS";
		(_this select 0) disableAI "TARGET";
		(_this select 0) disableAI "AUTOTARGET";
	};

    addKilledEvent = {
        (_this select 0) addMPEventhandler ["MPKilled",
        {
            _killer = _this select 1;
            if (side _killer == west && _killer isKindOf "Man" && isPlayer _killer) then {
                [[[_killer, 300, "STR_PRISON_CIVILIAN"], "scripts\=BTC=_TK_punishment\Prison.sqf"], "BIS_fnc_execVM", true, false, false] call BIS_fnc_MP;
            } else {
                if (side _killer != resistance) then {
                    (vehicle _killer) setFuel 0;
                    if (getDammage _killer < 0.9) then {
                        _killer setDamage 0.9;
                    };
                };
            };
        }];
    };

	[_unit] call _stripHim;
	sleep 0.1;
	[_unit] call _reclotheHim;
    [_unit] spawn addKilledEvent;
    [_unit] call addBehaviour;
};
          