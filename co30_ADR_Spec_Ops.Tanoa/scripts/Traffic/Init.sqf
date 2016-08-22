call compile preprocessFileLineNumbers "scripts\Traffic\Common\Common.sqf";
call compile preprocessFileLineNumbers "scripts\Traffic\Common\Debug.sqf";

ENGIMA_TRAFFIC_instanceIndex = -1;
ENGIMA_TRAFFIC_areaMarkerNames = [];
ENGIMA_TRAFFIC_roadSegments = [];
ENGIMA_TRAFFIC_edgeTopLeftRoads = [];
ENGIMA_TRAFFIC_edgeTopRightRoads = [];
ENGIMA_TRAFFIC_edgeBottomRightRoads = [];
ENGIMA_TRAFFIC_edgeBottomLeftRoads = [];
ENGIMA_TRAFFIC_edgeRoadsUseful = [];

if (isServer) then {
	call compile preprocessFileLineNumbers "scripts\Traffic\Server\randomCivilian.sqf";
	call compile preprocessFileLineNumbers "scripts\Traffic\Server\Functions.sqf";
	call compile preprocessFileLineNumbers "scripts\Traffic\ConfigAndStart.sqf";
};
