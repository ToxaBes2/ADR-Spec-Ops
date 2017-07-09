/*
Author: ToxaBes
Description: send debug cache info to admin via MP environment
*/
zbe_serverFPS = _this select 0;
zbe_cachedUnits = 0;
zbe_totalUnits = 0;
{
    if (side _x == EAST) then {
    	if !(simulationEnabled _x) then {
            zbe_cachedUnits = zbe_cachedUnits + 1;
    	};
    	zbe_totalUnits = zbe_totalUnits + 1;
    };
} forEach allUnits;		
hintSilent parseText format ["
   <t color='#FFFFFF' size='1.5'>Cache Debug</t><br/><br/>
   <t color='#A1A4AD' align='left'>All units:</t><t color='#FFFFFF' align='right'>%1</t><br/>
   <t color='#A1A4AD' align='left'>Cached units:</t><t color='#39a0ff' align='right'>%2</t><br/>
   <t color='#A1A4AD' align='left'>FPS:</t><t color='#FFFFFF' align='right'>%3</t><br/><br/>
", zbe_totalUnits, zbe_cachedUnits, zbe_serverFPS];