/*
	Name: cTab_fnc_updateLists
	
	Author(s):
		Gundy, Riouken

	Description:
		Update lists of cTab units and vehicles
		Lists updated:
			cTabBFTgroups
			cTabBFTvehicles
			cTabUAVlist
			cTabHcamlist
		
		List format (all except cTabHcamlist):
			Index 0: Unit object
			Index 1: Path to icon A
			Index 2: Path to icon B (either group size or wingmen)
			Index 3: Text to display
			Index 4: String of group index
	
	Parameters:
		NONE
	
	Returns:
		BOOLEAN - Always TRUE
	
	Example:
		call cTab_fnc_updateLists;
*/

private ["_cTabBFTgroups","_cTabBFTvehicles","_cTabUAVlist","_cTabHcamlist","_validSides","_playerEncryptionKey","_playerVehicle","_playerGroup","_updateInterface"];

_cTabBFTgroups = []; // other groups
_cTabBFTvehicles = []; // all vehicles
_cTabUAVlist =  []; // all remote controllable UAVs
_cTabHcamlist = [];  // units with a helmet cam

_validSides = call cTab_fnc_getPlayerSides;
_playerVehicle = vehicle player;
_playerGroup = group player;

/*
cTabUAVlist --- UAVs
*/
{
	if (side _x in _validSides) then {
		if (_x distance2D player < 1000) then {
		    0 = _cTabUAVlist pushBack _x;
	    };
	};
} count allUnitsUav;

/*
cTabHcamlist --- HELMET CAMS
Units on our side, that have either helmets that have been specified to include a helmet cam, or ItemCTabHCAM in their inventory.
*/
{
	if (side _x in _validSides) then {
		if (_x distance2D player < 1000) then {
		    if (headgear _x in cTab_helmetClass_has_HCam || {[_x,["ItemcTabHCam"]] call cTab_fnc_checkGear}) then {
		    	0 = _cTabHcamlist pushBack _x;
		    };
	    };
	};
} count units player;

// array to hold interface update commands
_updateInterface = [];

// replace the global list arrays in the end so that we avoid them being empty unnecessarily
cTabBFTgroups = [] + _cTabBFTgroups;
cTabBFTvehicles = [] + _cTabBFTvehicles;
if !(cTabUAVlist isEqualTo _cTabUAVlist) then {
	cTabUAVlist = [] + _cTabUAVlist;
	_updateInterface pushBack ["uavListUpdate",true];
};
if !(cTabHcamlist isEqualTo _cTabHcamlist) then {
	cTabHcamlist = [] + _cTabHcamlist;
	_updateInterface pushBack ["hCamListUpdate",true];
};

// call interface updates
if (count _updateInterface > 0) then {
	[_updateInterface] call cTab_fnc_updateInterface;
};

true