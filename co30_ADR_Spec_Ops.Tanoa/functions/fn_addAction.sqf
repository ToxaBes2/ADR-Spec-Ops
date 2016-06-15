/*
Author: Quiksilver
*/

_this addAction ["<t color='#ff1111'>Захватить разведданые</t>", "mission\side\actions\recover.sqf", [], 21, true, true, "", "(cursorTarget distance player) < 5"];
_this addAction ["<t color='#ff1111'>Взять в плен</t>", "mission\side\actions\surrender.sqf", [], 21, true, true, "", "(cursorTarget distance player) < 25"];