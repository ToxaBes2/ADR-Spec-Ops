if (!hasInterface && !isDedicated) exitWith {};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\DOM_squad\init.sqf"};
[] spawn {_this call compile preProcessFileLineNumbers "scripts\time.sqf"};
call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";
if (isDedicated) exitWith { 
	"addToScore" addPublicVariableEventHandler { 
	    ((_this select 1) select 0) addScore ((_this select 1) select 1); 
    };
};