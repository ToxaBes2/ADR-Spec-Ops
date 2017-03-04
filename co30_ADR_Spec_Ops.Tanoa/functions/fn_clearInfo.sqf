/*
Author: ToxaBes
Description: clear information about finished mission in DB
*/
["clearInfo",[], 0] remoteExec ["sqlServerCall", 2];

// update current time in DB
_hour = floor (date select 3);
["setTime",[_hour], 0] remoteExec ["sqlServerCall", 2];

// update current diplomacy status in DB
_diplomacyPartizan = partizan_ammo getVariable ['DIPLOMACY', 0];
_diplomacyBlufor = base_arsenal_infantry getVariable ["DIPLOMACY", 0];
if (_diplomacyPartizan == 1 && _diplomacyBlufor == 1) then {
    ["setDiplomacy",[1], 0] remoteExec ["sqlServerCall", 2];
};