/*
Author: ToxaBes
Description: stop Red Queen AI for defend zone
*/
_txid = _this select 0;
missionNamespace setVariable [format["%1", _txid], nil];
if !(isNil "TRANSACTIONS") then {
    if (typeName TRANSACTIONS == "ARRAY") then {
        _idx = TRANSACTIONS find _txid;
        if (_idx >= 0) then {
            TRANSACTIONS deleteAt _idx; publicVariable "TRANSACTIONS";
        };
    };
};