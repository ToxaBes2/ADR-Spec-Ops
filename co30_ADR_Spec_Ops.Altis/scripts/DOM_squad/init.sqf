// Init functions
call Compile preprocessFileLineNumbers "scripts\DOM_squad\x_netinit.sqf";
if (!isDedicated) then {
	call Compile preprocessFileLineNumbers "scripts\DOM_squad\x_uifuncs.sqf";
};
