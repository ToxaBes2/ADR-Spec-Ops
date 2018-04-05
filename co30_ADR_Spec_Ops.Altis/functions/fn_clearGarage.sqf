/*
Author: ToxaBes
Description: remove all blufor rewards
*/
_player = _this select 0;
if !(side _player == resistance) exitWith {};
BLUFOR_REWARDS_LIST = [];
publicVariable "BLUFOR_REWARDS_LIST";