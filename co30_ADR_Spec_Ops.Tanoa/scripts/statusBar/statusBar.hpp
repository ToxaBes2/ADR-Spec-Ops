#define ST_RIGHT 0x01
class statusBar {
	idd = -1;
	onLoad = "uiNamespace setVariable ['statusBar', _this select 0]";
	onUnload = "uiNamespace setVariable ['statusBar', objNull]";
	onDestroy = "uiNamespace setVariable ['statusBar', objNull]";
	fadein = 0;
	fadeout = 0;
	duration = 10e10;
	movingEnable = 0;
	controlsBackground[] = {};
	objects[] = {};
	class controls {
		class statusBarText {
			idc = 51200;
			x = 0.185 * safezoneW + safezoneX;
			y = 0.96 * safezoneH + safezoneY;
			w = 0.65 * safezoneW;
			h = 0.0330033 * safezoneH;
			shadow = 0;
			colorBackground[] = {0, 0, 0, 0};
			font = "PuristaSemibold";
			size = "0.017 * safezoneH";
			type = 13;
			style = 2;
			text= "";
			class Attributes {
				align="center";
				color = "#B3B3B3";
			};
		};
	};
};