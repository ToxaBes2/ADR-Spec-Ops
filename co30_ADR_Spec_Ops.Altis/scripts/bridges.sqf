/*
Authors: Liveandletdie, 1911
Description: Add Bridge Structures	
*/
private ["_bridge", "_bridgeAddition", "_bridgeAdditions", "_bridgeSection", "_bridgeSections", "_marker_b", "_object", "_pos"];

_marker_b = CreateMarker ["marker_bridge", [13794.1,10348.3]];
_marker_b setMarkerShape "RECTANGLE";
_marker_b setMarkerBrush "SolidFull";
_marker_b setMarkerDir 330.4;
_marker_b setMarkerSize [1050,3];
_marker_b setMarkerColor "ColorWhite";
_marker_b setMarkerAlpha 1;

_bridge = [
	["Land_AirstripPlatform_01_F",[12893.5,9836.94,0.72],330.4,0,-8],
	["Land_AirstripPlatform_01_F",[12909.415,9845.9824,2],330.4],
	["Land_AirstripPlatform_01_F",[12926.912,9855.9248,2],330.4],
	["Land_AirstripPlatform_01_F",[12944.417,9865.8711,2],330.4],
	["Land_AirstripPlatform_01_F",[12961.917,9875.8155,2],330.4],
	["Land_AirstripPlatform_01_F",[12979.417,9885.7599,2],330.4],
	["Land_AirstripPlatform_01_F",[12996.917,9895.7043,2],330.4],
	["Land_AirstripPlatform_01_F",[13014.417,9905.6487,2],330.4],
	["Land_AirstripPlatform_01_F",[13031.917,9915.5931,2],330.4],
	["Land_AirstripPlatform_01_F",[13049.417,9925.5375,2],330.4],
	["Land_AirstripPlatform_01_F",[13066.917,9935.4819,2],330.4],
	["Land_AirstripPlatform_01_F",[13084.417,9945.4263,2],330.4],
	["Land_AirstripPlatform_01_F",[13101.917,9955.3707,2],330.4],
	["Land_AirstripPlatform_01_F",[13119.417,9965.3151,2],330.4],
	["Land_AirstripPlatform_01_F",[13136.917,9975.2595,2],330.4],
	["Land_AirstripPlatform_01_F",[13154.417,9985.2039,2],330.4],
	["Land_AirstripPlatform_01_F",[13171.917,9995.1483,2],330.4],
	["Land_AirstripPlatform_01_F",[13189.417,10005.0927,2],330.4],
	["Land_AirstripPlatform_01_F",[13206.917,10015.0371,2],330.4],
	["Land_AirstripPlatform_01_F",[13224.417,10024.9815,2],330.4],
	["Land_AirstripPlatform_01_F",[13241.917,10034.9259,2],330.4],
	["Land_AirstripPlatform_01_F",[13259.417,10044.8703,2],330.4],
	["Land_AirstripPlatform_01_F",[13276.917,10054.8147,2],330.4],
	["Land_AirstripPlatform_01_F",[13294.417,10064.7591,2],330.4],
	["Land_AirstripPlatform_01_F",[13311.917,10074.7035,2],330.4],
	["Land_AirstripPlatform_01_F",[13329.417,10084.6479,2],330.4],
	["Land_AirstripPlatform_01_F",[13346.917,10094.5923,2],330.4],
	["Land_AirstripPlatform_01_F",[13364.417,10104.5367,2],330.4],
	["Land_AirstripPlatform_01_F",[13381.917,10114.4811,2],330.4],
	["Land_AirstripPlatform_01_F",[13399.417,10124.4255,2],330.4],
	["Land_AirstripPlatform_01_F",[13416.917,10134.3699,2],330.4],
	["Land_AirstripPlatform_01_F",[13434.417,10144.3143,2],330.4],
	["Land_AirstripPlatform_01_F",[13451.917,10154.2587,2],330.4],
	["Land_AirstripPlatform_01_F",[13469.417,10164.2031,2],330.4],
	["Land_AirstripPlatform_01_F",[13486.917,10174.1475,2],330.4],
	["Land_AirstripPlatform_01_F",[13504.417,10184.0919,2],330.4],
	["Land_AirstripPlatform_01_F",[13521.917,10194.0363,2],330.4],
	["Land_AirstripPlatform_01_F",[13539.417,10203.9807,2],330.4],
	["Land_AirstripPlatform_01_F",[13556.917,10213.9251,2],330.4],
	["Land_AirstripPlatform_01_F",[13574.417,10223.8695,2],330.4],
	["Land_AirstripPlatform_01_F",[13591.917,10233.8139,2],330.4],
	["Land_AirstripPlatform_01_F",[13609.417,10243.7583,2],330.4],
	["Land_AirstripPlatform_01_F",[13626.917,10253.7027,2],330.4],
	["Land_AirstripPlatform_01_F",[13644.417,10263.6471,2],330.4],
	["Land_AirstripPlatform_01_F",[13661.917,10273.5915,2],330.4],
	["Land_AirstripPlatform_01_F",[13679.417,10283.5359,2],330.4],
	["Land_AirstripPlatform_01_F",[13696.917,10293.4803,2],330.4],
	["Land_AirstripPlatform_01_F",[13714.417,10303.4247,2],330.4],
	["Land_AirstripPlatform_01_F",[13731.917,10313.3691,2],330.4],
	["Land_AirstripPlatform_01_F",[13749.417,10323.3135,2],330.4],
	["Land_AirstripPlatform_01_F",[13766.917,10333.2579,2],330.4],
	["Land_AirstripPlatform_01_F",[13784.417,10343.2023,2],330.4],
	["Land_Sidewalk_01_8m_F",[13798.634,10346.6767,7],150.4],
	["Land_Sidewalk_01_8m_F",[13803.904,10349.6767,7.01],150.4],
	["Land_Sidewalk_01_8m_F",[13809.174,10352.6767,7],150.4],
	["Land_Sidewalk_01_8m_F",[13796.647,10350.1467,7],150.4],
	["Land_Sidewalk_01_8m_F",[13801.917,10353.1467,7.01],150.4],
	["Land_Sidewalk_01_8m_F",[13807.187,10356.1467,7],150.4],
	["Land_Sidewalk_01_8m_F",[13794.66,10353.6167,7],150.4],
	["Land_Sidewalk_01_8m_F",[13799.93,10356.6167,7.01],150.4],
	["Land_Sidewalk_01_8m_F",[13805.20,10359.6167,7],150.4],
	["Land_Sidewalk_01_8m_F",[13798.634,10346.6777,6.7],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13803.904,10349.6777,6.69],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13809.174,10352.6777,6.7],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13796.647,10350.1467,6.7],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13801.917,10353.1467,6.69],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13807.187,10356.1467,6.7],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13794.66,10353.6157,6.7],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13799.93,10356.6157,6.69],150.4,0,180],
	["Land_Sidewalk_01_8m_F",[13805.20,10359.6157,6.7],150.4,0,180],
	["Land_AirstripPlatform_01_F",[13819.417,10363.0911,2],330.4],
	["Land_AirstripPlatform_01_F",[13836.917,10373.0355,2],330.4],
	["Land_AirstripPlatform_01_F",[13854.417,10382.9799,2],330.4],
	["Land_AirstripPlatform_01_F",[13871.917,10392.9243,2],330.4],
	["Land_AirstripPlatform_01_F",[13889.417,10402.8687,2],330.4],
	["Land_AirstripPlatform_01_F",[13906.917,10412.8131,2],330.4],
	["Land_AirstripPlatform_01_F",[13924.417,10422.7575,2],330.4],
	["Land_AirstripPlatform_01_F",[13941.917,10432.7019,2],330.4],
	["Land_AirstripPlatform_01_F",[13959.417,10442.6463,2],330.4],
	["Land_AirstripPlatform_01_F",[13976.917,10452.5907,2],330.4],
	["Land_AirstripPlatform_01_F",[13994.417,10462.5351,2],330.4],
	["Land_AirstripPlatform_01_F",[14011.917,10472.4795,2],330.4],
	["Land_AirstripPlatform_01_F",[14029.417,10482.4239,2],330.4],
	["Land_AirstripPlatform_01_F",[14046.917,10492.3683,2],330.4],
	["Land_AirstripPlatform_01_F",[14064.417,10502.3127,2],330.4],
	["Land_AirstripPlatform_01_F",[14081.917,10512.2571,2],330.4],
	["Land_AirstripPlatform_01_F",[14099.417,10522.2015,2],330.4],
	["Land_AirstripPlatform_01_F",[14116.917,10532.1459,2],330.4],
	["Land_AirstripPlatform_01_F",[14134.417,10542.0903,2],330.4],
	["Land_AirstripPlatform_01_F",[14151.917,10552.0347,2],330.4],
	["Land_AirstripPlatform_01_F",[14169.417,10561.9791,2],330.4],
	["Land_AirstripPlatform_01_F",[14186.917,10571.9235,2],330.4],
	["Land_AirstripPlatform_01_F",[14204.417,10581.8679,2],330.4],
	["Land_AirstripPlatform_01_F",[14221.917,10591.8123,2],330.4],
	["Land_AirstripPlatform_01_F",[14239.417,10601.7567,2],330.4],
	["Land_AirstripPlatform_01_F",[14256.917,10611.7011,2],330.4],
	["Land_AirstripPlatform_01_F",[14274.417,10621.6455,2],330.4],
	["Land_AirstripPlatform_01_F",[14291.917,10631.5899,2],330.4],
	["Land_AirstripPlatform_01_F",[14309.417,10641.5343,2],330.4],
	["Land_AirstripPlatform_01_F",[14326.917,10651.4787,2],330.4],
	["Land_AirstripPlatform_01_F",[14344.417,10661.4231,2],330.4],
	["Land_AirstripPlatform_01_F",[14361.917,10671.3675,2],330.4],
	["Land_AirstripPlatform_01_F",[14379.417,10681.3119,2],330.4],
	["Land_AirstripPlatform_01_F",[14396.917,10691.2563,2],330.4],
	["Land_AirstripPlatform_01_F",[14414.417,10701.2007,2],330.4],
	["Land_AirstripPlatform_01_F",[14431.917,10711.1451,2],330.4],
	["Land_AirstripPlatform_01_F",[14449.417,10721.0895,2],330.4],
	["Land_AirstripPlatform_01_F",[14466.917,10731.0339,2],330.4],
	["Land_AirstripPlatform_01_F",[14484.417,10740.9783,2],330.4],
	["Land_AirstripPlatform_01_F",[14501.917,10750.9227,2],330.4],
	["Land_AirstripPlatform_01_F",[14519.417,10760.8671,2],330.4],
	["Land_AirstripPlatform_01_F",[14536.917,10770.8115,2],330.4],
	["Land_AirstripPlatform_01_F",[14554.417,10780.7559,2],330.4],
	["Land_AirstripPlatform_01_F",[14571.917,10790.7003,2],330.4],
	["Land_AirstripPlatform_01_F",[14589.417,10800.6447,2],330.4],
	["Land_AirstripPlatform_01_F",[14606.917,10810.5891,2],330.4],
	["Land_AirstripPlatform_01_F",[14624.417,10820.5335,2],330.4],
	["Land_AirstripPlatform_01_F",[14641.917,10830.4779,2],330.4],
	["Land_AirstripPlatform_01_F",[14659.417,10840.4223,2],330.4],
	["Land_AirstripPlatform_01_F",[14676.917,10850.3667,2],330.4],
	["Land_AirstripPlatform_01_F",[14694.417,10860.3111,2],330.4],
	["Land_AirstripPlatform_01_F",[14709.95,10869.14,0.45],330.4,0,10]
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
	_pos = [13801.917,10353.1467,2];
	_object = createVehicle ["Land_AirstripPlatform_01_F", _pos, [], 0, "CAN_COLLIDE"];
	_object setDir 330.4;
	_object setPosASL _pos;
	_object enableSimulationGlobal false;

	_bridgeSections = _pos nearObjects ["Land_AirstripPlatform_01_F", 1040];
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
