/*
Author: ToxaBes
Description: prepare units for grab uniform.
Format: [] spawn QS_fnc_prepareUniform;
*/
while {true} do {
    sleep 60;
    {
        if (side _x == east) then {
            _applied = _x getVariable ["grab_action", false];
            if (!_applied) then {
                _x addEventHandler ["killed", {
                    (_this select 0) addAction ["<t color='#E944CB'><img image='\a3\ui_f\data\map\VehicleIcons\iconBackpack_ca.paa' size='1.0'/> Одеть форму противника</t>","scripts\misc\getEnemyUniform.sqf",[],21,true,true,"",'((vehicle player) == player && side player == resistance)', 5];
                }];
                _x setVariable ["grab_action", true];
            };        
        };
    } forEach allUnits;
    sleep 120;
};
