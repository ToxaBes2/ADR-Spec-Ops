zbe_aiCacheDist				= 1600;
zbe_debug					= false;
zbe_cachedGroups   			= [];
call compileFinal preprocessFileLineNumbers "scripts\zbe_cache\zbe_functions.sqf";
[] spawn  {
	while {true} do {
		sleep 15;
		{
		    if (side _x == EAST) then {
			    _disable = _x getVariable ["zbe_cacheDisabled", false];
			    if (!_disable && !(_x in zbe_cachedGroups)) then {
			    	zbe_cachedGroups = zbe_cachedGroups + [_x];
			    	[zbe_aiCacheDist, _x] execFSM "scripts\zbe_cache\zbe_aiCaching.fsm";
			    };
		    };
		} forEach allGroups;
	};
};
if (zbe_debug) then {   
	ZBE_DEBUG = true; publicVariable "ZBE_DEBUG";
    [] spawn {	
		while {true} do {			
			uiSleep 15;
			if (ZBE_DEBUG) then {
			    {
                    if (getplayeruid _x == "76561198114622790") then {
                        _null = [round diag_fps] remoteExec ["QS_fnc_cacheDebug", (owner _x)];
                    };
                } count allPlayers;
            };
		};
	};
};