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
							if (_x > _dmgMax) then {
								_dmgMax = _x;
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
