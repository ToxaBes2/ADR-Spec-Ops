/*
Authors: ToxaBes
Description: Add Bridge Structures	
*/
private ["_bridge", "_bridgeAddition", "_bridgeAdditions", "_bridgeSection", "_bridgeSections", "_marker_b", "_object", "_pos"];

_marker_b = CreateMarker ["marker_bridge", [8902.63,3780.22,0]];
_marker_b setMarkerShape "RECTANGLE";
_marker_b setMarkerBrush "SolidFull";
_marker_b setMarkerDir 0;
_marker_b setMarkerSize [420,3];
_marker_b setMarkerColor "ColorWhite";
_marker_b setMarkerAlpha 1;

_bridge = [
    ["Land_AirstripPlatform_01_F",[8481.75,3780,0.19],0,0,-8.181],
    ["Land_AirstripPlatform_01_F",[8500,3780,1.51285],0],
    ["Land_AirstripPlatform_01_F",[8520.15,3780,1.52033],0],
    ["Land_AirstripPlatform_01_F",[8540.25,3780.01,1.5097],0],
    ["Land_AirstripPlatform_01_F",[8560.39,3780,1.48769],0],
    ["Land_AirstripPlatform_01_F",[8580.54,3780,1.4981],0],
    ["Land_AirstripPlatform_01_F",[8600.65,3780.01,1.51818],0],
    ["Land_AirstripPlatform_01_F",[8620.72,3780,1.51832],0],
    ["Land_AirstripPlatform_01_F",[8640.87,3780,1.52873],0],
    ["Land_AirstripPlatform_01_F",[8660.97,3780.01,1.5539],0],
    ["Land_AirstripPlatform_01_F",[8681.11,3780,1.55919],0],
    ["Land_AirstripPlatform_01_F",[8701.26,3780,1.55354],0],
    ["Land_AirstripPlatform_01_F",[8721.36,3780.01,1.53957],0],
    ["Land_AirstripPlatform_01_F",[8741.49,3780,1.546],0],
    ["Land_AirstripPlatform_01_F",[8761.64,3780,1.55641],0],
    ["Land_AirstripPlatform_01_F",[8781.74,3780.01,1.58158],0],
    ["Land_AirstripPlatform_01_F",[8801.88,3780,1.57742],0],
    ["Land_AirstripPlatform_01_F",[8822.03,3780,1.5778],0],
    ["Land_AirstripPlatform_01_F",[8842.13,3780.01,1.56725],0],
    ["Land_AirstripPlatform_01_F",[8862.21,3780,1.58939],0],
    ["Land_AirstripPlatform_01_F",[8882.35,3780,1.57939],0],
    ["Land_AirstripPlatform_01_F",[8902.46,3780.01,1.59007],0],
    ["Land_AirstripPlatform_01_F",[8922.6,3780,1.58994],0],
    ["Land_AirstripPlatform_01_F",[8942.75,3780,1.59566],0],
    ["Land_AirstripPlatform_01_F",[8962.85,3780.01,1.59881],0],
    ["Land_AirstripPlatform_01_F",[8982.94,3780,1.5937],0],
    ["Land_AirstripPlatform_01_F",[9003.09,3780,1.58874],0],
    ["Land_AirstripPlatform_01_F",[9023.2,3780.01,1.55253],0],
    ["Land_AirstripPlatform_01_F",[9043.32,3780,1.57716],0],
    ["Land_AirstripPlatform_01_F",[9063.47,3780,1.59098],0],
    ["Land_AirstripPlatform_01_F",[9083.57,3780.01,1.60559],0],
    ["Land_AirstripPlatform_01_F",[9103.71,3780,1.60877],0],
    ["Land_AirstripPlatform_01_F",[9123.86,3780,1.60488],0],
    ["Land_AirstripPlatform_01_F",[9143.97,3780.01,1.62457],0],
    ["Land_AirstripPlatform_01_F",[9164.04,3780,1.60228],0],
    ["Land_AirstripPlatform_01_F",[9184.19,3780,1.5785],0],
    ["Land_AirstripPlatform_01_F",[9204.29,3780.01,1.5839],0],
    ["Land_AirstripPlatform_01_F",[9224.43,3780,1.57997],0],
    ["Land_AirstripPlatform_01_F",[9244.58,3780,1.59672],0],
    ["Land_AirstripPlatform_01_F",[9264.68,3780.01,1.58378],0],
    ["Land_AirstripPlatform_01_F",[9284.82,3780,1.59954],0],
    ["Land_AirstripPlatform_01_F",[9304.93,3780.01,1.60381],0],
    ["Land_AirstripPlatform_01_F",[9323.16,3780.01,0.27],0,0,8.3]
];

_bridgeAdditions = [
	["Land_CrashBarrier_01_8m_F",[-6.1,-5.75,12.85],180],
	["Land_CrashBarrier_01_8m_F",[0,-5.75,12.85],180],
	["Land_CrashBarrier_01_8m_F",[6.1,-5.75,12.85],180],
	["Land_CrashBarrier_01_8m_F",[-6.1,5.75,12.85],0],
	["Land_CrashBarrier_01_8m_F",[0,5.75,12.85],0],
	["Land_CrashBarrier_01_8m_F",[6.1,5.75,12.85],0],
	["Land_LampHarbour_F",[0,-5.55,15.4],0],
	["Land_LampHarbour_F",[0,5.55,15.4],180]
];

BuildBridge = {
	{
		_object = createVehicle [_x select 0, _x select 1, [], 0, "CAN_COLLIDE"];
		_object setDir (_x select 2);
		_object setPosASL (_x select 1);
		if ((count _x) > 3) then {[_object, _x select 3, _x select 4] call BIS_fnc_setPitchBank};
		_object enableSimulationGlobal false;
	} forEach _this;
};

BuildBridgeAdditions = {
	_pos = [8902.63,3780.22,2];
    _object = createVehicle ["Land_AirstripPlatform_01_F", _pos, [], 0, "CAN_COLLIDE"];
	_object setDir 0;
	_object setPosASL _pos;
	_object enableSimulationGlobal false;

	_bridgeSections = _pos nearObjects ["Land_AirstripPlatform_01_F", 410];
	{
		_bridgeSection = _x;
		{
			_bridgeAddition = createVehicle [_x select 0, getPos _bridgeSection, [], 0, "CAN_COLLIDE"];
			_bridgeAddition attachTo [_bridgeSection,_x select 1];
			detach _bridgeAddition;
			_bridgeAddition setDir (getDir _bridgeSection + (_x select 2));
			_bridgeAddition allowDamage false;
		} forEach _this;
	} forEach _bridgeSections;

	deleteVehicle _object;
};

(_bridge) call BuildBridge;
(_bridgeAdditions) call BuildBridgeAdditions;
