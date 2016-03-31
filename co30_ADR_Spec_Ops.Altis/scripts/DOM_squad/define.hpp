#define CT_STATIC			0
#define CT_BUTTON			1
#define CT_EDIT				2
#define CT_SLIDER			3
#define CT_COMBO			4
#define CT_LISTBOX			5
#define CT_TOOLBOX			6
#define CT_CHECKBOXES		7
#define CT_PROGRESS			8
#define CT_HTML				9
#define CT_STATIC_SKEW		10
#define CT_ACTIVETEXT		11
#define CT_TREE				12
#define CT_STRUCTURED_TEXT	13 
#define CT_3DSTATIC			20
#define CT_3DACTIVETEXT		21
#define CT_3DLISTBOX		22
#define CT_3DHTML			23
#define CT_3DSLIDER			24
#define CT_3DEDIT			25
#define CT_OBJECT			80
#define CT_OBJECT_ZOOM		81
#define CT_OBJECT_CONTAINER	82
#define CT_OBJECT_CONT_ANIM	83
#define CT_USER				99
#define ST_HPOS				0x0F
#define ST_LEFT				0
#define ST_RIGHT			1
#define ST_CENTER			2
#define ST_UP				3
#define ST_DOWN				4
#define ST_VCENTER			5
#define ST_TYPE				0xF0
#define ST_SINGLE			0
#define ST_MULTI			16
#define ST_TITLE_BAR		32
#define ST_PICTURE			48
#define ST_FRAME			64
#define ST_BACKGROUND		80
#define ST_GROUP_BOX		96
#define ST_GROUP_BOX2		112
#define ST_HUD_BACKGROUND	128
#define ST_TILE_PICTURE		144
#define ST_WITH_RECT		160
#define ST_LINE				176
#define ST_SHADOW			256
#define ST_NO_RECT			512
#define ST_KEEP_ASPECT_RATIO  0x800
#define ST_TITLE			ST_TITLE_BAR + ST_CENTER
#define FontHTML			"PuristaMedium"
#define FontM				"PuristaMedium"
#define Dlg_ROWS			36
#define Dlg_COLS			90
#define Dlg_CONTROLHGT		((100/Dlg_ROWS)/100)
#define Dlg_COLWIDTH		((100/Dlg_COLS)/100)
#define Dlg_TEXTHGT_MOD		0.9
#define Dlg_ROWSPACING_MOD	1.3
#define Dlg_ROWHGT			(Dlg_CONTROLHGT*Dlg_ROWSPACING_MOD)
#define Dlg_TEXTHGT			(Dlg_CONTROLHGT*Dlg_TEXTHGT_MOD)
#define UILEFT				0
#define UICOMBO				4
#define DEFAULTFONT			"PuristaMedium"

#define XCTextBlack			colorText[] = {1, 1, 1, 1}
//#define XCTextBI			colorText[] = {0.543, 0.5742, 0.4102, 1}
#define XCTextBI			colorText[] = {1, 1, 1, 1}
#define XCTextHud			colorText[] = {0.543, 0.5742, 0.4102, 0.9}
//#define XCMainCapt			colorText[] = {0.543, 0.5742, 0.4102, 1.0}
#define XCMainCapt			colorText[] = {1, 1, 1, 1}
#define __GUI_BCG_RGB {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"}
#define __GUI_TXT_RGB {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1}

class SXRscText {
	idc = -1;
	type = CT_STATIC;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
};
class RscBG: SXRscText {
	/*type = CT_STATIC;
	idc = -1;
	style = ST_LEFT;
	colorBackground[] = {0.02, 0.11, 0.27, 0.7};
	colorText[] = {1, 1, 1, 0};
	font = FontM;
	sizeEx = 0.015;
	text = "";*/
	
	idc = -1;
	type = CT_STATIC;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	text = "";
};
class RscButtonDOM {
	idc = -1;
	type = CT_BUTTON;
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "PuristaMedium";
	sizeEx = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1";
	colorText[] = {1,1,1,1.0};
	colorDisabled[] = {0.4,0.4,0.4,1};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.7};
	colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
	colorBackgroundDisabled[] = {0.95,0.95,0.95,1};
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
	colorShadow[] = {0,0,0,1};
	colorBorder[] = {0,0,0,1};
	borderSize = 0.0;
	soundEnter[] = {"", 0.09,1};
	soundPush[] = {"", 0.0, 1};
	soundClick[] = {"", 0.07, 1};
	soundEscape[] = {"", 0.09, 1};
	default = false;
};
class RscNavButton:RscButtonDOM {
	w = 0.1; h = 0.04;
	x = 0.90;
};
class SXRscListBox {
	type = 5;
	style = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0.3};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorText[] = {1,1,1,1.0};
	colorDisabled[] = {1,1,1,0.25};
	font = "PuristaMedium";
	sizeEx = 0.029;
	//sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	rowHeight = 0.03;
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 10;
	w = 0.275;
	h = 0.04;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	colorScrollbar[] = {0.95,0.95,0.95,1};
	shadow = 2;
	period = 1;
	default = false;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	class ScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = __UI_Path_Scrollbar(thumb_ca.paa);
		arrowFull = __UI_Path_Scrollbar(arrowFull_ca.paa);
		arrowEmpty = __UI_Path_Scrollbar(arrowEmpty_ca.paa);
		border = __UI_Path_Scrollbar(border_ca.paa);
	};

	class ListScrollBar : ScrollBar
	{
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};

};
class XD_RscPicture {
	type = CT_STATIC;
	idc = -1;
	style = ST_PICTURE;
	x = 0.1; y = 0.1;
	w = 0.4; h = 0.2;
	sizeEx = Dlg_TEXTHGT;
	colorBackground[] = {0, 0, 0, 0};
	XCTextBlack;
	font = FontM;
	text = "";
};
class XD_RscMapControl {
	type = 101;
	style = 48;
	font = "PuristaMedium";
	sizeEx = 0.04;
	moveOnEdges = 1;
	x = "SafeZoneXAbs";
	y = "SafeZoneY + 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "SafeZoneWAbs";
	h = "SafeZoneH - 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 3;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1.0;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 0.35;
	alphaFadeEndScale = 0.4;
	colorBackground[] = {0.969,0.957,0.949,1.0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0.0,0.0,0.0,0.0};
	colorRocks[] = {0.0,0.0,0.0,0.3};
	colorRocksBorder[] = {0.0,0.0,0.0,0.0};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorPowerLines[] = {0.1,0.1,0.1,1.0};
	colorRailWay[] = {0.8,0.2,0.0,1.0};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorInactive[] = {1.0,1.0,1.0,0.5};
	colorOutside[] = {0.0,0.0,0.0,1.0};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1.0};
	colorRoads[] = {0.7,0.7,0.7,1.0};
	colorRoadsFill[] = {1.0,1.0,1.0,1.0};
	colorMainRoads[] = {0.9,0.5,0.3,1.0};
	colorMainRoadsFill[] = {1.0,0.6,0.4,1.0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	colorText[] = {0, 0, 0, 1};
	fontLabel = "PuristaMedium";
	sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "PuristaMedium";
	sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "PuristaMedium";
	sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	class Legend {
		x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "PuristaMedium";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[] = {1,1,1,0.5};
		color[] = {0,0,0,1};
	};
	class Task {
		icon = __UI_Path_Map(taskIcon_CA.paa);
		iconCreated = __UI_Path_Map(taskIconCreated_CA.paa);
		iconCanceled = __UI_Path_Map(taskIconCanceled_CA.paa);
		iconDone = __UI_Path_Map(taskIconDone_CA.paa);
		iconFailed = __UI_Path_Map(taskIconFailed_CA.paa);
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCreated[] = {1,1,1,1};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Waypoint {
		icon = __UI_Path_Map(waypoint_ca.paa);
		color[] = {0,0,0,1};
		size = 20;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class WaypointCompleted {
		icon = __UI_Path_Map(waypointCompleted_ca.paa);
		color[] = {0,0,0,1};
		size = 20;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class CustomMark {
		icon = __UI_Path_Map(custommark_ca.paa);
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0,0,0,1};
	};
	class Command {
		icon = __UI_Path_Map(waypoint_ca.paa);
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class Bush {
		icon = __UI_Path_Map(bush_ca.paa);
		color[] = {0.45,0.64,0.33,0.4};
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Rock {
		icon = __UI_Path_Map(rock_ca.paa);
		color[] = {0.1,0.1,0.1,0.8};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree {
		icon = __UI_Path_Map(bush_ca.paa);
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Tree {
		icon = __UI_Path_Map(bush_ca.paa);
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class busstop {
		icon = __UI_Path_Map(busstop_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class fuelstation {
		icon = __UI_Path_Map(fuelstation_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class hospital {
		icon = __UI_Path_Map(hospital_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class church {
		icon = __UI_Path_Map(church_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class lighthouse {
		icon = __UI_Path_Map(lighthouse_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class power {
		icon = __UI_Path_Map(power_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powersolar {
		icon = __UI_Path_Map(powersolar_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwave {
		icon = __UI_Path_Map(powerwave_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwind {
		icon = __UI_Path_Map(powerwind_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class quay {
		icon = __UI_Path_Map(quay_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class shipwreck {
		icon = __UI_Path_Map(shipwreck_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class transmitter {
		icon = __UI_Path_Map(transmitter_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class watertower {
		icon = __UI_Path_Map(watertower_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class Cross {
		icon = __UI_Path_Map(Cross_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Chapel {
		icon = __UI_Path_Map(Chapel_CA.paa);
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Bunker {
		icon = __UI_Path_Map(bunker_ca.paa);
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fortress {
		icon = __UI_Path_Map(bunker_ca.paa);
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fountain {
		icon = __UI_Path_Map(fountain_ca.paa);
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Ruin {
		icon = __UI_Path_Map(ruin_ca.paa);
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Stack {
		icon = __UI_Path_Map(stack_ca.paa);
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Tourism {
		icon = __UI_Path_Map(tourism_ca.paa);
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class ViewTower {
		icon = __UI_Path_Map(viewtower_ca.paa);
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class ActiveMarker {
		color[] = {0,0,0,0};
		size = 1;
	};
};
class GVAR(Dummy_Map) {
	idc = -1;
	type=100;
	style=48;
	x = 0;y = 0;w = 1;h = 1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0,0,0,0};
	colorSea[] = {0,0,0,0};
	colorForest[] = {0,0,0,0};
	colorRocks[] = {0,0,0,0};
	colorCountlines[] = {0,0,0,0};
	colorMainCountlines[] = {0,0,0,0};
	colorCountlinesWater[] = {0,0,0,0};
	colorMainCountlinesWater[] = {0,0,0,0};
	colorForestBorder[] = {0,0,0,0};
	colorRocksBorder[] = {0,0,0,0};
	colorPowerLines[] = {0,0,0,0};
	colorNames[] = {0,0,0,0};
	colorInactive[] = {0,0,0,0};
	colorLevels[] = {0,0,0,0};
	colorRailWay[] = {0,0,0,0};
	colorOutside[] = {0,0,0,0};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1.0};
	colorRoads[] = {0.7,0.7,0.7,1.0};
	colorRoadsFill[] = {1.0,1.0,1.0,1.0};
	colorMainRoads[] = {0.9,0.5,0.3,1.0};
	colorMainRoadsFill[] = {1.0,0.6,0.4,1.0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	font = "TahomaB";
	sizeEx = 0.00;
	stickX[] = {0.0,{"Gamma", 1, 1}};
	stickY[] = {0.0,{"Gamma", 1, 1}};
	ptsPerSquareSea = 0;
	ptsPerSquareTxt = 0;
	ptsPerSquareCLn = 0;
	ptsPerSquareExp = 0;
	ptsPerSquareCost = 0;
	ptsPerSquareFor = "0f";
	ptsPerSquareForEdge = "0f";
	ptsPerSquareRoad = 0;
	ptsPerSquareObj = 0;
	fontLabel = "PuristaMedium";
	sizeExLabel = 0.0;
	fontGrid = "PuristaMedium";
	sizeExGrid = 0.0;
	fontUnits = "PuristaMedium";
	sizeExUnits = 0.0;
	fontNames = "PuristaMedium";
	sizeExNames = 0.0;
	fontInfo = "PuristaMedium";
	sizeExInfo = 0.0;
	fontLevel = "PuristaMedium";
	sizeExLevel = 0.0;
	scaleMax = 1;
	scaleMin = 0.125;
	text = "";
	maxSatelliteAlpha = 0;
	alphaFadeStartScale = 1;
	alphaFadeEndScale = 1.0;
	showCountourInterval=1;
	scaleDefault = 2;
	#define __UIClearEmpty icon = "\A3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"
    class Task {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 1;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		iconCreated = "";
		iconCanceled = "";
		iconDone = "";
		iconFailed = "";
		colorCreated[] = {0,0,0,0};
		colorCanceled[] = {0,0,0,0};
		colorDone[] = {0,0,0,0};
		colorFailed[] = {0,0,0,0};
	};
	class CustomMark {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 1;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Legend {
		x = "SafeZoneX";
		y = "SafeZoneY";
		w = 0.340000;
		h = 0.152000;
		font = "PuristaMedium";
		sizeEx = 0.039210;
		colorBackground[] = {0,0,0,0};
		color[] = {0,0,0,0};
	};
	class Bunker {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Bush {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 14;
		importance = "0.2 * 14 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class BusStop {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 12;
		importance = "1 * 10 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Command {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Cross {
		__UIClearEmpty;
		size = 16;
		color[] = {0,0,0,0};
		importance = "0.7 * 16 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Fortress {
		__UIClearEmpty;
		size = 16;
		color[] = {0,0,0,0};
		importance = "2 * 16 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Fuelstation {
		__UIClearEmpty;
		size = 16;
		color[] = {0,0,0,0};
		importance = "2 * 16 * 0.05";
		coefMin = 0.750000;
		coefMax = 4;
	};
	class Fountain {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Hospital {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};
	class Chapel {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};
	class Church {
		__UIClearEmpty;
		size = 16;
		color[] = {0,0,0,0};
		importance = "2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};
	class Lighthouse {
		__UIClearEmpty;
		size = 14;
		color[] = {0,0,0,0};
		importance = "3 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};
	class Quay {
		__UIClearEmpty;
		size = 16;
		color[] = {0,0,0,0};
		importance = "2 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};
	class Rock {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Ruin {
		__UIClearEmpty;
		size = 16;
		color[] = {0,0,0,0};
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
	};
	class SmallTree {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Stack {
		__UIClearEmpty;
		size = 20;
		color[] = {0,0,0,0};
		importance = "2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};
	class Tree {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.250000;
		coefMax = 4;
	};
	class Tourism {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.700000;
		coefMax = 4;
	};
	class Transmitter {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};
	class ViewTower {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};
	class Watertower {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 20;
		importance = "1.2 * 16 * 0.05";
		coefMin = 0.900000;
		coefMax = 4;
	};
	class Waypoint {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};
	class WaypointCompleted {
		__UIClearEmpty;
		color[] = {0,0,0,0};
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.500000;
		coefMax = 4;
	};
	class ActiveMarker {
		color[] = {0,0,0,0};
		size = 1;
	};
};

class RscShortcutButtonDOM {
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1,1,1,1.0};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
	colorBackground2[] = {1,1,1,1};
	textureNoShortcut = "";
	animTextureDefault = __UI_Path_ShortcutButton(normal_ca.paa);
	animTextureNormal = __UI_Path_ShortcutButton(normal_ca.paa);
	animTextureDisabled = __UI_Path_ShortcutButton(normal_ca.paa);
	animTextureOver = __UI_Path_ShortcutButton(over_ca.paa);
	animTextureFocused = __UI_Path_ShortcutButton(focus_ca.paa);
	animTexturePressed = __UI_Path_ShortcutButton(down_ca.paa);
	periodFocus = 1.2;
	periodOver = 0.8;
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos {
		left = 0;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos {
		left = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"",0.09,1};
	soundPush[] = {"",0.0,0};
	soundClick[] = {"",0.07,1};
	soundEscape[] = {"",0.09,1};
	action = "";
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};
class XD_ButtonBase: RscShortcutButtonDOM {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackground2[] = {1,1,1,0.5};
	color[] = {1,1,1,1};
	color2[] = {1,1,1,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	class TextPos {
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	class Attributes {
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos {
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
};

class XD_ButtonBase2: XD_ButtonBase {
	colorBackground[] = __GUI_BCG_RGB;
	colorBackground2[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
};

class XD_LinkButtonBase {
	idc = -1;
	type = CT_BUTTON;
	style = ST_CENTER;
	default = false;
	font = "PuristaMedium";
	sizeEx = 0.029;
	XCTextBlack;
	colorFocused[] = {1, 1, 1, 0};
	colorDisabled[] = {0, 0, 1, 0.7};
	colorBackground[] = {1, 1, 1, 0};
	colorBackgroundDisabled[] = {1, 1, 1, 0.5};
	colorBackgroundActive[] = {1, 1, 1, 0};
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = {1, 1, 1, 0};
	colorBorder[] = {1, 1, 1, 0};
	borderSize = 0;
	soundEnter[] = {"",0.09,1};
	soundPush[] = {"",0.0,0};
	soundClick[] = {"",0.07,1};
	soundEscape[] = {"",0.09,1};
	x = 0.06; y = 0.11;
	w = 0.15; h = 0.1;
	text = "";
	action = "";
	shadow = 2;
};

class XD_UIList {
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	color[] = {1,1,1,1};
	colorText[] = {1,1,1,1.0};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {1,0,0,0};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	period = 1.2;
	colorBackground[] = {0,0,0,0.3};
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	class ScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = __UI_Path_Scrollbar(thumb_ca.paa);
		arrowFull = __UI_Path_Scrollbar(arrowFull_ca.paa);
		arrowEmpty = __UI_Path_Scrollbar(arrowEmpty_ca.paa);
		border = __UI_Path_Scrollbar(border_ca.paa);
	};

	class ListScrollBar : ScrollBar
	{
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};

};
class RscComboDOM {
	style = 16;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	colorSelect[] = {0,0,0,1};
	colorText[] = {0.95,0.95,0.95,1};
	colorBackground[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorScrollbar[] = {1,0,0,1};
	arrowEmpty = __UI_Path_Combo(arrow_combo_ca.paa);
	arrowFull = __UI_Path_Combo(arrow_combo_active_ca.paa);
	wholeHeight = 0.45;
	color[] = {1,1,1,1};
	colorActive[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	class ScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = __UI_Path_Scrollbar(thumb_ca.paa);
		arrowFull = __UI_Path_Scrollbar(arrowFull_ca.paa);
		arrowEmpty = __UI_Path_Scrollbar(arrowEmpty_ca.paa);
		border = __UI_Path_Scrollbar(border_ca.paa);
	};

	class ListScrollBar : ScrollBar
	{
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};

};
class XD_UIComboBox: RscComboDOM {
	type = UICOMBO;
	//style = 0;
	idc = -1;
	sizeEx = 0.025;
	wholeHeight = 0.3;
	colorText[] = {1,1,1,1};
};
class XC_RscText {
	type = CT_STATIC;
	idc = -1;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	text = "";
};
class X3_RscStructText {
	idc = -1;
	type = CT_STRUCTURED_TEXT;
	style = ST_LEFT;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	x = 0.1;
	y = 0.1;
	w = 0.3;
	h = 0.1;
	//size = 0.023;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	sizeEx = 0.023;
	shadow = 1;
	class Attributes {
		font = "PuristaMedium";
		color = "#ffffff";
		align = "left";
		valign = "middle";
		shadow = true;
		shadowColor = "#ff0000";
		size = "1";
	};
};
class XC_SliderH {
	type = 43;
	idc = -1;
	style = "0x400	+ 0x10";
	shadow = 2;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	color[] = {1,1,1,0.4};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	arrowEmpty = __UI_Path_Slider(arrowEmpty_ca.paa);
	arrowFull = __UI_Path_Slider(arrowFull_ca.paa);
	border = __UI_Path_Slider(border_ca.paa);
	thumb = __UI_Path_Slider(thumb_ca.paa);
};

class XD_RscControlsGroup {
	type = 15;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	style = 16;
	class VScrollbar {
		color[] = {1,1,1,1};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = 0;
	};
	class HScrollbar {
		color[] = {1,1,1,1};
		height = 0.028;
		shadow = 0;
	};
	class ScrollBar {
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		shadow = 0;
		thumb = __UI_Path_Scrollbar(thumb_ca.paa);
		arrowFull = __UI_Path_Scrollbar(arrowFull_ca.paa);
		arrowEmpty = __UI_Path_Scrollbar(arrowEmpty_ca.paa);
		border = __UI_Path_Scrollbar(border_ca.paa);
	};


	class ListScrollBar : ScrollBar
	{
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};

	class Controls{};
};