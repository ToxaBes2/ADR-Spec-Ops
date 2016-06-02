// Author: malashin
// Helicopter or plane field repair add action condition

private ["_c"];
_v = cursorTarget;
_c = false;

if (!(vehicle_repaired)) then {
	if ((vehicle player) == player) then {
		if (alive _v) then {
			if (_v isKindOf "Air") then {
				if ((player distance _v) < 7) then {
					if (("ToolKit" in (items player)) or ("ToolKit" in (itemCargo _v))) then {
						_dmgList = getAllHitPointsDamage _v;
						_dmgMax = 0;
						{
							if !((_dmgList select 0) select _forEachIndex in ["HitFuel","Glass_1_hitpoint","Glass_2_hitpoint","Glass_3_hitpoint","Glass_4_hitpoint","Glass_5_hitpoint","Glass_6_hitpoint","Glass_7_hitpoint","Glass_8_hitpoint","Glass_9_hitpoint","Glass_10_hitpoint","Glass_11_hitpoint","Glass_12_hitpoint","Glass_13_hitpoint","Glass_14_hitpoint","Glass_15_hitpoint","Glass_16_hitpoint","Glass_17_hitpoint","Glass_18_hitpoint","Glass_19_hitpoint","Glass_20_hitpoint","Glass_Pod_01_hitpoint","Glass_Pod_02_hitpoint","Glass_Pod_03_hitpoint","Glass_Pod_04_hitpoint","Glass_Pod_05_hitpoint","Glass_Pod_06_hitpoint","Glass_Pod_07_hitpoint","Glass_Pod_08_hitpoint","Glass_Pod_09_hitpoint","HitGlass1","HitGlass2","HitGlass3","HitGlass4","HitGlass5","HitGlass6","HitGlass7","HitGlass8","HitGlass9","HitGlass10","HitGlass11","HitGlass12","HitGlass13","HitGlass14","HitGlass15","HitLGlass","HitRGlass"]) then {
								if (_x > _dmgMax) then {
									_dmgMax = _x;
								};
							};
						} forEach (_dmgList select 2);

						if (_dmgMax > 0.64) then {
							_c = true;
						};
					};
				};
			};
		};
	};
};
_c;
