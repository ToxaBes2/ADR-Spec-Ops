#define ReadAndWrite		0
#define ReadAndCreate		1
#define ReadOnly		2
#define ReadOnlyVerified		3

#define VSoft		0
#define VArmor		1
#define VAir		2

#define true	1
#define false	0

#define private		0
#define protected		1
#define public		2

class cTab_keys {
	class if_main {
		key = 35;
		ctrl = 0;
		shift = 0;
		alt = 0;
	};
	
	class if_secondary {
		key = 35;
		ctrl = 1;
		shift = 0;
		alt = 0;
	};
	
	class if_tertiary {
		key = 35;
		ctrl = 0;
		shift = 0;
		alt = 1;
	};
	
	class zoom_in {
		key = 201;
		ctrl = 1;
		shift = 1;
		alt = 0;
	};
	
	class zoom_out {
		key = 209;
		ctrl = 1;
		shift = 1;
		alt = 0;
	};
};

class cTab_Marker_RscCheckBox
{
  access = 0; //Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
  idc = -1; //Control identification (without it, the control won't be displayed)
  type = 77; //Type
  style = ST_LEFT + ST_MULTI; // Style
  default = 0; //Control selected by default (only one within a display can be used)
  blinkingPeriod = 0; //Time in which control will fade out and back in. Use 0 to disable the effect.
  x = 0; y = 0;
  w = 1 * GUI_GRID_CENTER_W; h = 1 * GUI_GRID_CENTER_H;

  //Colors
  color[] = { 1, 1, 1, 0.7 };         //Texture color
  colorFocused[] = { 1, 1, 1, 1 };    //Focused texture color
  colorHover[] = { 1, 1, 1, 1 };      //Mouse over texture color
  colorPressed[] = { 1, 1, 1, 1 };    //Mouse pressed texture color
  colorDisabled[] = { 1, 1, 1, 0.2 }; //Disabled texture color

  //Background colors
  colorBackground[] = { 0, 0, 0, 0 };         //Fill color
  colorBackgroundFocused[] = { 0, 0, 0, 0 };  //Focused fill color
  colorBackgroundHover[] = { 0, 0, 0, 0 };    //Mouse hover fill color
  colorBackgroundPressed[] = { 0, 0, 0, 0 };  //Mouse pressed fill color
  colorBackgroundDisabled[] = { 0, 0, 0, 0 }; //Disabled fill color

  //Textures
  textureChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
  textureUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
  textureFocusedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
  textureFocusedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
  textureHoverChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
  textureHoverUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
  texturePressedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
  texturePressedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
  textureDisabledChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
  textureDisabledUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";

  //Tooltip properties
  tooltip = ""; //Text
  tooltipColorShade[] = { 0, 0, 0, 1 }; //Background color
  tooltipColorText[] = { 1, 1, 1, 1 };  //Text color
  tooltipColorBox[] = { 1, 1, 1, 1 };   //Frame color

  //Sounds
  soundClick[] = { "\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1 };   //Control is activated in format {file, volume, pitch}
  soundEnter[] = { "\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1 };   //Mouse cursor enters the control
  soundPush[] = { "\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1 };     //Control is pushed down
  soundEscape[] = { "\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1 }; //Control is released after pushing down

};

class cTab_RscText {
	access = ReadAndWrite;
	type = VSoft;
	idc = -1;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = true;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
};

class cTab_RscStructuredText {
	access = ReadAndWrite;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] = {1, 1, 1, 1};
	
	class Attributes {
		font = "PuristaMedium";
		color = "#ffffff";
		align = "left";
		shadow = true;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = true;
};

class cTab_RscPicture {
	access = ReadAndWrite;
	type = VSoft;
	idc = -1;
	style = 48;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = false;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
};

class cTab_RscEdit {
	access = ReadAndWrite;
	type = VAir;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0, 0, 0, 1};
	colorText[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
	autocomplete = "";
	text = "";
	size = 0.2;
	style = 0x00 + 0x40;
	font = "PuristaMedium";
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	canModify = 1;
};


class cTab_RscCombo {
	access = ReadAndWrite;
	type = 4;
	colorSelect[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0, 0, 0, 1};
	colorScrollbar[] = {1, 0, 0, 1};
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect", 0.1, 1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand", 0.1, 1};
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse", 0.1, 1};
	maxHistoryDelay = 1;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		shadow = false;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};

    class ComboScrollBar {
    	color[] = {1,1,1,0.6};
    	colorActive[] = {1,1,1,1};
    	colorDisabled[] = {1,1,1,0.3};
    	shadow = 0;
    	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };

	style = 16;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = false;
	colorSelectBackground[] = {1, 1, 1, 0.7};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {1, 1, 1, 1};
	colorActive[] = {1, 0, 0, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};

class cTab_RscCombo2: cTab_RscCombo {
	access = ReadAndWrite;
	colorSelect[] = {0,0,0,1};
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,1};
    colorScrollbar[] = {1,1,1,1};

	colorSelectBackground[] = {1, 1, 1, 1};
	color[] = {1, 1, 1, 1};
	colorActive[] = {0, 0, 0, 1};
	colorDisabled[] = {1, 1, 1, 0.25};

    class ComboScrollBar {
    	color[] = {1,1,1,0.6};
    	colorActive[] = {0,0,0,1};
    	colorDisabled[] = {1,1,1,0.3};
    	shadow = 0;
    	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
};

class cTab_RscListBox {
	access = ReadAndWrite;
	type = 5;
	w = 0.4;
	h = 0.4;
	rowHeight = 0;
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorScrollbar[] = {1, 0, 0, 0};
	colorSelect[] = {0, 0, 0, 1};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground2[] = {1, 1, 1, 0.5};
	colorBackground[] = {0, 0, 0, 0.3};
	colorPicture[] = {1, 1, 1, 1};
	colorPictureDisabled[] = {1, 1, 1, 0.25};
	colorPictureRight[] = {1, 1, 1, 1};
	colorPictureRightDisabled[] = {1, 1, 1, 0.25};
	colorPictureRightSelected[] = {1, 1, 1, 1};
	colorPictureSelected[] = {1, 1, 1, 1};
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.09, 1};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		shadow = false;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	style = 16;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = false;
	colorShadow[] = {0, 0, 0, 0.5};
	color[] = {1, 1, 1, 1};
	period = 1.2;
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	class listScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		shadow = false;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

class cTab_RscButton {
	access = ReadAndWrite;
	type = VArmor;
	text = "";
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {0.4, 0.4, 0.4, 1};
	colorBackground[] = {0.118, 0.118, 0.118, 0.7};
	colorBackgroundDisabled[] = {0.95, 0.95, 0.95, 1};
	colorBackgroundActive[] = {0.118, 0.118, 0.118, 1};
	colorFocused[] = {0.118, 0.118, 0.118, 1};
	colorShadow[] = {0, 0, 0, 1};
	colorBorder[] = {0, 0, 0, 1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};

class cTab_ActiveText {
	access = ReadAndWrite;
	type = 11;
	style = 0;
	text = "";
	color[] = {1, 1, 1, 1};
	colorActive[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {0.4, 0.4, 0.4, 1};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 0.7};
	colorBackgroundDisabled[] = {0.95, 0.95, 0.95, 1};
	colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
	colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
	colorShadow[] = {0, 0, 0, 1};
	colorBorder[] = {0, 0, 0, 1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};

class cTab_HTML {
	access = ReadAndWrite;
	style = 0;
	default = 0;
	blinkingPeriod = 0;
	colorBackground[] = {0.2, 0.2, 0.2, 1};
	colorText[] = {1, 1, 1, 1};
	colorBold[] = {1, 1, 1, 1};
	colorLink[] = {1, 1, 1, 1};
	colorLinkActive[] = {1, 0.5, 0, 1};
	colorPicture[] = {1, 1, 1, 1};
	colorPictureBorder[] = {0, 0, 0, 0};
	colorPictureLink[] = {1, 1, 1, 1};
	colorPictureSelected[] = {1, 1, 1, 1};
	prevPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa";
	nextPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa";
};

class cTab_RscButtonInv {
	access = ReadAndWrite;
	type = VArmor;
	text = "";
	colorText[] = {0, 0, 0, 0};
	colorDisabled[] = {0.4, 0.4, 0.4, 0};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 0};
	colorBackgroundDisabled[] = {0.95, 0.95, 0.95, 0};
	colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 0};
	colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 0};
	colorShadow[] = {0, 0, 0, 0};
	colorBorder[] = {0, 0, 0, 0};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};

class cTab_RscShortcutButton {
	type = 16;
	x = 0.1;
	y = 0.1;
	
	class HitZone {
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
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
		bottom = 0;
	};
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {1, 1, 1, 1};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
	colorBackground2[] = {1, 1, 1, 1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};
	
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	idc = -1;
	style = 0;
	default = 0;
	shadow = true;
	w = 0.183825;
	h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	action = "";
	
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};

class cTab_RscShortcutButtonMain {
	idc = -1;
	style = 0;
	default = 0;
	w = 0.313726;
	h = 0.104575;
	color[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	
	class HitZone {
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	
	class ShortcutPos {
		left = 0.0145;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	};
	
	class TextPos {
		left = "(((safezoneW / safezoneH) min 1.2) / 32) * 1.5";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)*2 - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		right = 0.005;
		bottom = 0;
	};
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\disabled_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\down_ca.paa";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	period = 0.5;
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	text = "";
	action = "";
	
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "false";
	};
};

class cTab_RscFrame {
	type = VSoft;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	font = "PuristaMedium";
	sizeEx = 0.02;
	text = "";
};

class cTab_RscSlider {
	access = ReadAndWrite;
	type = 3;
	style = 1024;
	w = 0.3;
	color[] = {1, 1, 1, 0.8};
	colorActive[] = {1, 1, 1, 1};
	shadow = false;
	h = 0.025;
};

class cTab_IGUIBack {
	type = VSoft;
	idc = 124;
	style = 128;
	text = "";
	colorText[] = {0, 0, 0, 0};
	font = "PuristaMedium";
	sizeEx = 0;
	shadow = false;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])", "(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])", "(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};
};

class cTab_RscCheckbox {
	idc = -1;
	type = 7;
	style = 0;
	x = "LINE_X(XVAL)";
	y = LINE_Y;
	w = "LINE_W(WVAL)";
	h = 0.029412;
	colorText[] = {1, 0, 0, 1};
	color[] = {0, 0, 0, 0};
	colorBackground[] = {0, 0, 1, 1};
	colorTextSelect[] = {0, 0.8, 0, 1};
	colorSelectedBg[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])", 1};
	colorSelect[] = {0, 0, 0, 1};
	colorTextDisable[] = {0.4, 0.4, 0.4, 1};
	colorDisable[] = {0.4, 0.4, 0.4, 1};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	rows = 1;
	columns = 1;
	strings[] = {UNCHECKED};
	checked_strings[] = {CHECKED};
};

class cTab_RscButtonMenu {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = false;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	colorBackground[] = {0, 0, 0, 0.8};
	colorBackground2[] = {1, 1, 1, 0.5};
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	
	class HitZone {
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	
	class TextPos {
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0;
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
	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush", 0.09, 1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick", 0.09, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape", 0.09, 1};
};

class cTab_RscButtonMenuOK {
	idc = 1;
	shortcuts[] = {0x00050000 + 0, 28, 57, 156};
	default = 1;
	text = "OK";
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenuOK\soundPush", 0.09, 1};
};

class cTab_RscButtonMenuCancel {
	idc = 2;
	shortcuts[] = {0x00050000 + 1};
	text = "Cancel";
};

class cTab_RscControlsGroup {
	class VScrollbar {
		color[] = {1, 1, 1, 1};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = false;
	};
	
	class HScrollbar {
		color[] = {1, 1, 1, 1};
		height = 0.028;
		shadow = false;
	};
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		shadow = false;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	
	class Controls {};
	type = 15;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = false;
	style = 16;
};

class cTab_RscMapControl {
	access = ReadAndWrite;
	idc = -1;
	type = 101;
	style = 48;
	x = 0.1;
	y = 0.1;
	w = 0.8;
	h = 0.6;
	moveOnEdges = 1;
	showMarkers = true;
	shadow = false;
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
	scaleMax = 1;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 0.35;
	alphaFadeEndScale = 0.4;
  
    colorCountlines[] = {0.65, 0.45, 0.27, 0.50};
    colorMainCountlines[] = {0.65, 0.45, 0.27, 1.00};
    colorCountlinesWater[] = {0.00, 0.53, 1.00, 0.50};
    colorMainCountlinesWater[] = {0.00, 0.53, 1.00, 1.00};  
    //colorMainCountlines[] = {1, 0, 0, 1};
	//colorCountlines[] = {1, 0, 0, 0.5};
	//colorMainCountlinesWater[] = {0.491, 0.577, 0.702, 0.6};
	//colorCountlinesWater[] = {0.491, 0.577, 0.702, 0.3};
	colorBackground[] = {0.969, 0.957, 0.949, 1};
	colorSea[] = {0.467, 0.631, 0.851, 0.5};
	colorForest[] = {0.4, 1, 0.4, 0.3};
	colorForestBorder[] = {0, 0, 0, 0};
	colorRocks[] = {0, 0, 0, 0.3};
	colorRocksBorder[] = {0, 0, 0, 0};
	colorLevels[] = {0, 0, 0, 1};	
	colorPowerLines[] = {0.1, 0.1, 0.1, 1};
	colorRailWay[] = {0.8, 0.2, 0, 1};
	colorNames[] = {0, 0, 0, 1};
	colorInactive[] = {1, 1, 1, 0.5};
	colorOutside[] = {0, 0, 0, 1};
	colorTracks[] = {0.84, 0.76, 0.65, 1};
	colorTracksFill[] = {0.84, 0.76, 0.65, 1};
	colorRoads[] = {1, 0.8, 0, 1};
	colorRoadsFill[] = {1, 0.8, 0, 1};
	colorMainRoads[] = {1, 0.6, 0.4, 1};
	colorMainRoadsFill[] = {1, 0.6, 0.4, 1};
	colorGrid[] = {0.1, 0.1, 0.1, 0.6};
	colorGridMap[] = {0.1, 0.1, 0.1, 0.6};

	fontLabel = "PuristaMedium";
	sizeExLabel = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "PuristaMedium";
	sizeExNames = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "PuristaMedium";
	sizeExInfo = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	colorText[] = {1, 1, 1, 1};
	font = "PuristaMedium";
	text = "#(argb,8,8,3)color(1,1,1,1)";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

	class Legend {
		x = "SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "PuristaMedium";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[] = {1, 1, 1, 0.5};
		color[] = {0, 0, 0, 1};
	};
	
	class Task {
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCreated[] = {1, 1, 1, 1};
		colorCanceled[] = {0.7, 0.7, 0.7, 1};
		colorDone[] = {0.7, 1, 0.3, 1};
		colorFailed[] = {1, 0.3, 0.2, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class Waypoint {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {0, 0, 0, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class WaypointCompleted {
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		color[] = {0, 0, 0, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	
	class CustomMark {
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};
	
	class Command {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class Bush {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 14/2;
		importance = 0.2 * 14 * 0.05 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Rock {
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[] = {0.1, 0.1, 0.1, 0.8};
		size = 12;
		importance = 0.5 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class SmallTree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.6 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class Tree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.9 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};
	
	class busstop {
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class fuelstation {
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class hospital {
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class church {
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class lighthouse {
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class power {
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class powersolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class powerwave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class powerwind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class quay {
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class shipwreck {
		icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class transmitter {
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class watertower {
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	
	class Cross {
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};
	
	class Chapel {
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};
	
	class Bunker {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = 1.5 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};
	
	class Fortress {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};
	
	class Fountain {
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = 1 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};
	
	class Ruin {
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = 1.2 * 16 * 0.05;
		coefMin = 1;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};
	
	class Stack {
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};
	
	class Tourism {
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.7;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};
	
	class ViewTower {
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};
	
	class ActiveMarker {
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};

	class LineMarker {
        lineWidthThin = 0.008;
        lineWidthThick = 0.014;
        lineDistanceMin = 3e-005;
        lineLengthMin = 5;
    };
};

class cTab_MenuItem : cTab_ActiveText {
	colorActive[] = {255/255, 165/255, 0/255, 1};
};

class cTab_MenuExit : cTab_MenuItem {
	color[] = {1, 1, 1, 0.75};
};

class cTab_RscText_Tablet : cTab_RscText {
	style = 2;
	w = "(((((1341)) - (10) * 8) / 7)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(((42) - (10))) / 2048  * 	(safezoneH * 1.2)";
	font = "EtelkaMonospacePro";
	colorText[] = {1, 1, 1, 1};
	sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
	colorBackground[] = {0, 0, 0, 0};
	shadow = false;
};

class cTab_RscListbox_Tablet : cTab_RscListBox {
	sizeEx = "((27) * 1.2) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_RscEdit_Tablet : cTab_RscEdit {
	sizeEx = "((27) * 1.2) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_RscButton_Tablet : cTab_RscButton {
	font = "EtelkaMonospacePro";
	sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_background : cTab_RscPicture {
	idc = 1200;
	text = "";
	//text = "scripts\cTab\img\tablet_background_ca.paa";
	x = "(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(	(safezoneH * 1.2) * 3/4)";
	h = "(safezoneH * 1.2)";
};

class cTab_tablet_header : cTab_RscPicture {
	idc = 1;
	text = "#(argb,8,8,3)color(0,0,0,1)";
	x = "((257)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "((491)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "((1341)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "((42)) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_OSD_battery : cTab_RscPicture {
	idc = 2;
	text = "scripts\cTab\img\icon_battery_ca.paa";
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (1 - 1))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "((491) + ((42) - (35)) / 2) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "((35)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "((35)) / 2048  * 	(safezoneH * 1.2)";
	colorText[] = {1, 1, 1, 1};
};

class cTab_Tablet_OSD_time : cTab_RscText_Tablet {
	idc = 2613;
	style = 2;
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (4 - 1))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "((491) + ((42) - (27)) / 2) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
};

class cTab_Tablet_OSD_signalStrength : cTab_Tablet_OSD_battery {
	idc = 3;
	text = "scripts\cTab\img\icon_signalStrength_ca.paa";
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (7 - 1)) + ((((1341)) - (10) * 8) / 7) - (35) * 2) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	colorText[] = {1, 1, 1, 1};
};

class cTab_Tablet_OSD_satellite : cTab_Tablet_OSD_battery {
	idc = 4;
	text = "\a3\ui_f\data\map\Diary\signal_ca.paa";
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (7 - 1)) + ((((1341)) - (10) * 8) / 7) - (35)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	colorText[] = {1, 1, 1, 1};
};

class cTab_Tablet_OSD_dirDegree : cTab_Tablet_OSD_time {
	idc = 2615;
	style = 0;
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (2 - 1))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_OSD_grid : cTab_Tablet_OSD_dirDegree {
	idc = 2612;
	style = 1;
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (6 - 1))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_OSD_dirOctant : cTab_Tablet_OSD_dirDegree {
	idc = 2616;
	style = 1;
	x = "((((10) + ((257))) + ((10) + ((((1341)) - (10) * 8) / 7)) * (1 - 1))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_window_back_TL : cTab_RscPicture {
	text = "scripts\cTab\img\window.jpg";
	x = "((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_window_back_BL : cTab_Tablet_window_back_TL {
	y = "((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
};

class cTab_Tablet_window_back_TR : cTab_Tablet_window_back_TL {
	x = "((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_window_back_BR : cTab_Tablet_window_back_TR {
	y = "((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
};

class cTab_Tablet_btnF1 : cTab_RscButtonInv {
	x = "(506) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(1545) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(52) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(52) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_btnF2 : cTab_Tablet_btnF1 {
	x = "(569) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnF3 : cTab_Tablet_btnF1 {
	x = "(639) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnF4 : cTab_Tablet_btnF1 {
	x = "(703) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnF5 : cTab_Tablet_btnF1 {
	x = "(768) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnF6 : cTab_Tablet_btnF1 {
	x = "(833) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnFn : cTab_Tablet_btnF1 {
	x = "(970) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnPower : cTab_Tablet_btnFn {
	x = "(1034) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnBrtDn : cTab_Tablet_btnFn {
	x = "(1100) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnBrtUp : cTab_Tablet_btnFn {
	x = "(1163) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
};

class cTab_Tablet_btnTrackpad : cTab_Tablet_btnFn {
	x = "(1262) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(1550) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(48) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(43) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_btnMode : cTab_Tablet_btnFn {
	x = "(1350) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(1550) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(30) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(30) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_btnMouse : cTab_Tablet_btnFn {
	x = "(1401) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	w = "(91) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
};

class cTab_Tablet_btnHome : cTab_Tablet_btnMouse {
	x = "(897) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(1534) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(61) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(49) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_notificationLight {
	x = "(1353) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(1557) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(28) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(28) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_OSD_hookGrid : cTab_RscText_Tablet {
	idc = 2617;
	style = 2;
	x = "(((-(10) + ((257)) + ((1341))) - ((((1341)) - (10) * 8) / 7))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "((-(0) + (491) + (993)) - (10) - ((42) - (10)) * 4) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	colorText[] = {1, 1, 1, 0.5};
	colorBackground[] = {0, 0, 0, 0.25};
};

class cTab_Tablet_OSD_hookElevation : cTab_Tablet_OSD_hookGrid {
	idc = 2620;
	y = "((-(0) + (491) + (993)) - (10) - ((42) - (10)) * 3) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
};

class cTab_Tablet_OSD_hookDst : cTab_Tablet_OSD_hookGrid {
	idc = 2619;
	y = "((-(0) + (491) + (993)) - (10) - ((42) - (10)) * 2) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
};

class cTab_Tablet_OSD_hookDir : cTab_Tablet_OSD_hookGrid {
	idc = 2618;
	y = "((-(0) + (491) + (993)) - (10) - ((42) - (10))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
};

class cTab_Tablet_loadingtxt : cTab_RscText_Tablet {
	idc = 1000;
	style = 2;
	text = "Loading";
	x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
	colorBackground[] = {0.2, 0.431, 0.647, 1};
};

class cTab_Tablet_movingHandle_T : cTab_RscText_Tablet {
	idc = 5;
	moving = 0;
	colorBackground[] = {0, 0, 0, 0};
	x = "(0) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(0) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(2048 ) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "((491)) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_movingHandle_B : cTab_Tablet_movingHandle_T {
	idc = 6;
	y = "((491) + (993)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	h = "(2048  - ((491) + (993))) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_movingHandle_L : cTab_Tablet_movingHandle_T {
	idc = 7;
	y = "((491)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "((257)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "((993)) / 2048  * 	(safezoneH * 1.2)";
};

class cTab_Tablet_movingHandle_R : cTab_Tablet_movingHandle_L {
	idc = 8;
	x = "((257) + (1341)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	w = "(2048  - ((257) + (1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
};

class cTab_Tablet_brightness : cTab_RscText_Tablet {
	idc = 1005;
	x = "((257)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "((491)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "((1341)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "((993)) / 2048  * 	(safezoneH * 1.2)";
	colorBackground[] = {0, 0, 0, 0};
};

class cTab_Tablet_RscMapControl : cTab_RscMapControl {
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
	maxSatelliteAlpha = 10000;
	alphaFadeStartScale = 10;
	alphaFadeEndScale = 10;
	ptsPerSquareSea = "8 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareTxt = "8 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareCLn = "8 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareExp = "8 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareCost = "8 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareFor = "3 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareForEdge = "100 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareRoad = "1.5 / (0.86 / 	(safezoneH * 1.2))";
	ptsPerSquareObj = "4 / (0.86 / 	(safezoneH * 1.2))";
};

class cTab_Tablet_notification : cTab_RscText_Tablet {
	idc = 1620;
	x = "(((257)) + (((1341)) * 0.5) / 2) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	y = "(((491) + (42)) + ((993) - (42) - (0)) - 2 * (27)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	w = "(((1341)) * 0.5) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	colorBackground[] = {0, 0, 0, 1};
};

class cTab_Tablet_dlg {
	idd = 1775154;
	movingEnable = false;
	onLoad = "_this call cTab_fnc_onIfOpen;";
	onUnload = "[] call cTab_fnc_onIfclose;";
	onKeyDown = "_this call cTab_fnc_onIfKeyDown;";
	objects[] = {};
	
	class controlsBackground {
		class windowsBG : cTab_RscPicture {
			idc = 1210;
			//text = "#(argb,8,8,3)color(0.2,0.431,0.647,1)";
			text = "#(argb,8,8,3)color(0.239,0.267,0.133,1)";
			x = "((257)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "((491)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "((1341)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "((993)) / 2048  * 	(safezoneH * 1.2)";
		};

		class logoBG : cTab_RscPicture {
			idc = 1212;
			text = "scripts\cTab\img\logo.jpg";
			x = "((257)) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "((491)) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "((1341)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "((993)) / 2048  * 	(safezoneH * 1.2)";
		};
		
		class windowsBar : cTab_RscPicture {
			idc = 1211;
			text = "scripts\cTab\img\desktop_bar.jpg";
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (993) - (((1341)) / (1024) * (28)))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "((((1341)) / (1024) * (28))) / 2048  * 	(safezoneH * 1.2)";
		};
		
		class MiniMapBG : cTab_Tablet_window_back_BL {
			idc = 1218;
		};
		
		class cTabUavMap : cTab_Tablet_RscMapControl {
			idc = 1774;
			x = "(((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(safezoneH * 1.2)";
			onDraw = "nop = _this call cTabOnDrawUAV;";
		};

		
		class cTabHcamMap : cTabUavMap {
			idc = 1220;
			onDraw = "nop = _this call cTabOnDrawHCam;";
		};
		
		class screen : cTab_Tablet_RscMapControl {
			idc = 1201;
			onDraw = "nop = _this call cTabOnDrawbft;";
			onMouseButtonDblClick = "_ok = [3300,_this] execVM 'scripts\cTab\shared\cTab_markerMenu_load.sqf';";
			onMouseMoving = "cTabCursorOnMap = _this select 3;cTabMapCursorPos = _this select 0 ctrlMapScreenToWorld [_this select 1,_this select 2];";
		};
		
		class screenTopo : screen {
			idc = 1202;
			maxSatelliteAlpha = 0;
		};

		class support : cTab_Tablet_RscMapControl {
			idc = 1255;
			onDraw = "nop = _this call cTabOnDrawSupport;";
			onMouseButtonDblClick = "_ok = [4656,_this] execVM 'scripts\cTab\shared\cTab_markerMenu_load.sqf';";
		};

		class supportTopo : support {
			idc = 1256;
			maxSatelliteAlpha = 0;
		};

		class ballistic : cTab_RscPicture {
			idc = 1265;
            x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	        y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	        w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	        h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
	        text = "#(argb,8,8,3)color(0,0,0,1)";
		};

		class group : cTab_RscPicture {
			idc = 1285;
            x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
	        y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
	        w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
	        h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
	        text = "#(argb,8,8,3)color(0,0,0,1)";
		};
	};
	
	class controls {
		class header : cTab_tablet_header {};
		
		class battery : cTab_Tablet_OSD_battery {};
		
		class time : cTab_Tablet_OSD_time {};
		
		class signalStrength : cTab_Tablet_OSD_signalStrength {};
		
		class satellite : cTab_Tablet_OSD_satellite {};
		
		class dirDegree : cTab_Tablet_OSD_dirDegree {};
		
		class grid : cTab_Tablet_OSD_grid {};
		
		class dirOctant : cTab_Tablet_OSD_dirOctant {};
		
		class hookGrid : cTab_Tablet_OSD_hookGrid {};
		
		class hookElevation : cTab_Tablet_OSD_hookElevation {};
		
		class hookDst : cTab_Tablet_OSD_hookDst {};
		
		class hookDir : cTab_Tablet_OSD_hookDir {};
        		
		class Desktop : cTab_RscControlsGroup {
			idc = 4610;
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
			
			class VScrollbar {};
			
			class HScrollbar {};
			
			class Scrollbar {};
			
			class controls {


				class actBFTtxt : cTab_ActiveText {
					style = 48;
					idc = 1001;
					text = "scripts\cTab\img\map.jpg";
					x = "(((((257)) + (25)) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((491) + (42)) + (25)) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "((100)) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "((100)) / 2048  * 	(safezoneH * 1.2)";
					action = "['cTab_Tablet_dlg',[['mode','BFT']]] call cTab_fnc_setSettings;";
					toolTip = "Карта";
				};
				
				class actUAVtxt : actBFTtxt {
					idc = 1002;
					text = "scripts\cTab\img\uav.jpg";
					y = "(((((491) + (42)) + (25) * 2 + (100)) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					action = "['cTab_Tablet_dlg',[['mode','UAV']]] call cTab_fnc_setSettings;";
					toolTip = "БПЛА";
				};
				
				class actVIDtxt : actBFTtxt {
					idc = 1003;
					text = "scripts\cTab\img\camera.jpg";
					y = "(((((491) + (42)) + (25) * 3 + (100) * 2) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					action = "['cTab_Tablet_dlg',[['mode','HCAM']]] call cTab_fnc_setSettings;";
					toolTip = "Видео";
				};
				
				class actMSGtxt : actBFTtxt {
					idc = 1004;
					text = "scripts\cTab\img\support.jpg";
					y = "(((((491) + (42)) + (25) * 4 + (100) * 3) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					action = "['cTab_Tablet_dlg',[['mode','SUPPORT']]] call cTab_fnc_setSettings;";
					toolTip = "Поддержка";
				};

				class actGRPtxt : actBFTtxt {
					idc = 1005;
					text = "scripts\cTab\img\group.jpg";
					y = "(((((491) + (42)) + (25) * 5 + (100) * 4) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					action = "['cTab_Tablet_dlg',[['mode','GROUP']]] call cTab_fnc_setSettings;";
					toolTip = "Отряд";
				};

				class actBALtxt : actBFTtxt {
					idc = 1006;
					text = "scripts\cTab\img\ballistic.jpg";
					y = "(((((491) + (42)) + (25) * 6 + (100) * 5) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					action = "['cTab_Tablet_dlg',[['mode','BALLISTIC']]] call cTab_fnc_setSettings;";
					toolTip = "Баллистический Компьютер";
				};
			};
		};
		
		class UAV : cTab_RscControlsGroup {
			idc = 4630;
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
			
			class VScrollbar {};
			
			class HScrollbar {};
			
			class Scrollbar {};
			
			class controls {
				class UAVListBG : cTab_Tablet_window_back_TL {
					idc = 9;
					x = "((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3)) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3)) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
				};
				
				class UAVVidBG1 : cTab_Tablet_window_back_TR {
					idc = 10;
					x = "((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2)) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3)) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
				};
				
				class UAVVidBG2 : cTab_Tablet_window_back_BR {
					idc = 11;
					x = "((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2)) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2)) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
				};
				
				class cTabUAVlist : cTab_RscListbox_Tablet {
					idc = 1776;
					x = "(((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(safezoneH * 1.2)";
					onLBSelChanged = "if (!cTabIfOpenStart && (_this select 1 != -1)) then {['cTab_Tablet_dlg',[['uavCam',(_this select 0) lbData (_this select 1)]]] call cTab_fnc_setSettings;};";
				};
				
				class cTabUAVdisplay : cTab_RscPicture {
					idc = 1773;
					text = "#(argb,512,512,1)r2t(rendertarget8,1.1896551724)";
					x = "(((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(safezoneH * 1.2)";
				};
				
				class cTabUAV2nddisplay : cTab_RscPicture {
					idc = 1775;
					text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
					x = "(((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3 * 2) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(safezoneH * 1.2)";
				};
			};
		};

		class cTabUAVFull : cTab_RscPicture {
			idc = 1246;
			text = "#(argb,512,512,1)r2t(rendertarget14,1.3096153846)";
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
		};

		class cTabUAVFull2 : cTab_RscPicture {
			idc = 1247;
			text = "#(argb,512,512,1)r2t(rendertarget15,1.3096153846)";
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
		};
		
		class HCAM : cTab_RscControlsGroup {
			idc = 4640;
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
			
			class VScrollbar {};
			
			class HScrollbar {};
			
			class Scrollbar {};
			
			class controls {
				class HcamListBG : cTab_Tablet_window_back_TL {
					idc = 12;
					x = "((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3)) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3)) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
				};
				
				class HcamVidBG : cTab_Tablet_window_back_TR {
					idc = 13;
					x = "((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2)) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3)) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
				};
				
				class cTabHcamList : cTab_RscListbox_Tablet {
					idc = 1230;
					x = "(((((((257)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(safezoneH * 1.2)";
					onLBSelChanged = "if (!cTabIfOpenStart && (_this select 1 != -1)) then {['cTab_Tablet_dlg',[['hCam',(_this select 0) lbData (_this select 1)]]] call cTab_fnc_setSettings;};";
				};
				
				class cTabHcamDisplay : cTab_RscPicture {
					idc = 1240;
					text = "#(argb,512,512,1)r2t(rendertarget12,1.1896551724)";
					x = "(((((((257)) + ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) + (((1341)) - 2 * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 3 * 2) + ((9) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))))) - ((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4))";
					y = "(((((((491) + (42)) + (((993) - (42) - (0)) - (((1341)) / (1024) * (28)) - 2 * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)) / 3) + ((30) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) - ((491) + (42))) / 2048  * 	(safezoneH * 1.2))";
					w = "(((276) / (293) * ((293) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49)))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
					h = "(((232) / (272) * ((((993) - (42) - (0)) - (((1341)) / (1024) * (28))) * 0.49))) / 2048  * 	(safezoneH * 1.2)";
				};
			};
		};

		class BallisticGroup : cTab_RscControlsGroup {
			idc = 4670;
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";			
			
			class VScrollbar {};
			
			class HScrollbar {};
			
			class Scrollbar {};
			
			class controls {

                class mapBallistic : cTab_Tablet_RscMapControl {
                    idc = 1401;
                    x = "(((257))) / 2048  *    (   (safezoneH * 1.2) * 3/4) +  (safezoneX + (safezoneW -   (   (safezoneH * 1.2) * 3/4)) / 2 + (   (   (safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
                    y = "(((491) + (42))) / 2048  *     (safezoneH * 1.2) +     (safezoneY + (safezoneH -   (safezoneH * 1.2)) / 2)";
                    w = "(((1341))) / 2048  *   (   (safezoneH * 1.2) * 3/4) / 1.5";
                    h = "(((993) - (42) - (0))) / 2048  *   (safezoneH * 1.2)"; 
                    onDraw = "nop = _this call cTabOnDrawBallistic;";
                    onMouseButtonClick = "_this call cTab_fnc_useMapCoords;";
                    onMouseMoving = "cTabCursorOnMapBallistic = _this select 3;cTabMapCursorPosBallistic = _this select 0 ctrlMapScreenToWorld [_this select 1,_this select 2];";
                };
                
                class batteryCoordsText: cTab_RscText
                {
                    idc = -1;
                    x = 0.8; 
                    y = 0;
                    w = 0.25;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "Координаты Орудия";
                };
                               
                class batteryCoordsXText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.05;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "X:";
                };

                class batteryCoordsX: cTab_RscEdit
                {
                    idc = 1410;
                    x = 0.76; 
                    y = 0.05;
                    w = 0.12;
                    h = 0.05; 
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    style = ST_LEFT;
                    text = "";
                };

                class batteryCoordsYText: cTab_RscText
                {
                    idc = -1;
                    x = 0.89; 
                    y = 0.05;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "Y:";
                };


                class batteryCoordsY: cTab_RscEdit
                {
                    idc = 1411;
                    x = 0.93; 
                    y = 0.05;
                    w = 0.12;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    style = ST_LEFT;
                    text = "";
                };

                class batteryCoordsMap: cTab_RscButton
                {
                    idc = 1412;
                    text = "Указать на карте";
                    x = 0.73; 
                    y = 0.11;
                    w = 0.16;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "[1] call cTab_fnc_mapCoords;";
                };

                class batteryCoordsOwn: cTab_RscButton
                {
                    idc = 1430;
                    text = "Свои координаты";
                    x = 0.9; 
                    y = 0.11;
                    w = 0.16;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "call cTab_fnc_ownCoords;";
                };

                class targetCoordsText: cTab_RscText
                {
                    idc = -1;
                    x = 0.8; 
                    y = 0.18;
                    w = 0.25;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "Координаты Цели";
                };
                               
                class targetCoordsXText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.23;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "X:";
                };

                class targetCoordsX: cTab_RscEdit
                {
                    idc = 1413;
                    x = 0.76; 
                    y = 0.23;
                    w = 0.12;
                    h = 0.05; 
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    style = ST_LEFT;
                    text = "";
                };

                class targetCoordsYText: cTab_RscText
                {
                    idc = -1;
                    x = 0.89; 
                    y = 0.23;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "Y:";
                };

                class targetCoordsY: cTab_RscEdit
                {
                    idc = 1414;
                    x = 0.93; 
                    y = 0.23;
                    w = 0.12;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    style = ST_LEFT;
                    text = "";
                };
                
                class targetCoordsMap: cTab_RscButton
                {
                    idc = 1415;
                    text = "Указать на карте";
                    x = 0.8; 
                    y = 0.29;
                    w = 0.2;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "[0] call cTab_fnc_mapCoords;";
                };

                class weaponText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.37;
                    w = 0.1;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "Орудие:";
                };

                class weaponType: cTab_RscCombo2
                {
                    idc = 1416;                 
                    x = 0.8; 
                    y = 0.37;
                    w = 0.25;
                    h = 0.05;       
                    onLoad = "[_this select 0] call cTab_fnc_initBattery;";     
                    onLBSelChanged = "[_this select 0, _this select 1] call cTab_fnc_onChangeAmmo;";                    
                };

                class ammoText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.43;
                    w = 0.1;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "Тип БК:";
                };

                class ammoType: cTab_RscCombo2
                {
                    idc = 1417;                 
                    x = 0.8; 
                    y = 0.43;
                    w = 0.25;
                    h = 0.05;   
                    onLoad = "[_this select 0] call cTab_fnc_changeAmmo;"; 
                };

                class modeText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.49;
                    w = 0.1;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "Режим:";
                };

                class modeType: cTab_RscCombo2
                {
                    idc = 1426;                 
                    x = 0.8; 
                    y = 0.49;
                    w = 0.25;
                    h = 0.05;
                    onLoad = "[_this select 0] call cTab_fnc_initBatteryModes;";  
                };

                class calcSolution: cTab_RscButton
                {
                    idc = 1418;
                    text = "ВЫЧИСЛИТЬ";
                    x = 0.8; 
                    y = 0.55;
                    w = 0.2;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "[] call cTab_fnc_calculate";
                };

                class solutionText: cTab_RscText
                {
                    idc = -1;
                    x = 0.84; 
                    y = 0.65;
                    w = 0.25;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "ВАРИАНТЫ";
                };

                class solution1Text: cTab_RscText
                {
                    idc = -1;
                    x = 0.79; 
                    y = 0.7;
                    w = 0.25;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "LOW";
                    tooltip = "Низкая траектория";
                };

                class solution2Text: cTab_RscText
                {
                    idc = -1;
                    x = 0.95; 
                    y = 0.7;
                    w = 0.25;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "HIGH";
                    tooltip = "Высокая траектория";
                };

                class solution1ELVText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.75;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "ELV:";
                    tooltip = "Возвышение";
                };

                class solution1ELVValue: cTab_RscText
                {
                    idc = 1420;
                    x = 0.77; 
                    y = 0.75;
                    w = 0.08;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "000.00";
                };

                class solution1DIRText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.8;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "DIR:";
                    tooltip = "Направление";
                };

                class solution1DIRValue: cTab_RscText
                {
                    idc = 1421;
                    x = 0.77; 
                    y = 0.8;
                    w = 0.08;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "000.00";
                };

                class solution1ETAText: cTab_RscText
                {
                    idc = -1;
                    x = 0.715; 
                    y = 0.85;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "ETA:";
                    tooltip = "Время полета";
                };

                class solution1ETAValue: cTab_RscText
                {
                    idc = 1422;
                    x = 0.77; 
                    y = 0.85;
                    w = 0.08;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "000.00";
                };                

                class solution2ELVText: cTab_RscText
                {
                    idc = -1;
                    x = 0.87; 
                    y = 0.75;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "ELV:";
                    tooltip = "Возвышение";
                };

                class solution2ELVValue: cTab_RscText
                {
                    idc = 1423;
                    x = 0.925; 
                    y = 0.75;
                    w = 0.08;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "000.00";
                };                

                class solution2DIRText: cTab_RscText
                {
                    idc = -1;
                    x = 0.87; 
                    y = 0.8;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "DIR:";
                    tooltip = "Направление";
                };

                class solution2DIRValue: cTab_RscText
                {
                    idc = 1424;
                    x = 0.925; 
                    y = 0.8;
                    w = 0.08;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "000.00";
                };

                class solution2ETAText: cTab_RscText
                {
                    idc = -1;
                    x = 0.87; 
                    y = 0.85;
                    w = 0.05;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "ETA:";
                    tooltip = "Время полета";
                };

                class solution2ETAValue: cTab_RscText
                {
                    idc = 1425;
                    x = 0.925; 
                    y = 0.85;
                    w = 0.08;
                    h = 0.05; 
                    style = ST_LEFT;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";               
                    text = "000.00";
                };                

                class chat1: cTab_RscButton
                {
                    idc = 1416;
                    text = "Отправить";
                    x = 0.76; 
                    y = 0.94;
                    w = 0.12;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "[0] call cTab_fnc_sendCoords;";
                };

                class chat2: cTab_RscButton
                {
                    idc = 1419;
                    text = "Отправить";
                    x = 0.92; 
                    y = 0.94;
                    w = 0.12;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "[1] call cTab_fnc_sendCoords;";
                };

			};
		};

		class GroupGroup : cTab_RscControlsGroup {
			idc = 4680;
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";			
			
			class VScrollbar {};
			
			class HScrollbar {};
			
			class Scrollbar {};
			
			class controls {

                class mapGroup : cTab_Tablet_RscMapControl {
                    idc = 1501;
                    x = "(((257))) / 2048  *    (   (safezoneH * 1.2) * 3/4) +  (safezoneX + (safezoneW -   (   (safezoneH * 1.2) * 3/4)) / 2 + (   (   (safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
                    y = "(((491) + (42))) / 2048  *     (safezoneH * 1.2) +     (safezoneY + (safezoneH -   (safezoneH * 1.2)) / 2)";
                    w = "(((1341))) / 2048  *   (   (safezoneH * 1.2) * 3/4) / 1.5";
                    h = "(((993) - (42) - (0))) / 2048  *   (safezoneH * 1.2)"; 
                    onDraw = "nop = _this call cTabOnDrawGroup;";
                    onMouseButtonDblClick = "_this call cTab_fnc_createWaypoint;";
                    onMouseMoving = "cTabCursorOnMapGroup = _this select 3;cTabMapCursorPosGroup = _this select 0 ctrlMapScreenToWorld [_this select 1,_this select 2];";
                };               
                
                class wpText: cTab_RscText
                {
                    idc = -1;
                    x = 0.85; 
                    y = 0;
                    w = 0.25;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
                    text = "Команды";
                };
                               
                class wp: cTab_RscListBox
                {
                    idc = 1510;
                    x = 0.74; 
                    y = 0.05;
                    w = 0.3;
                    h = 0.62; 
                    style = ST_LEFT;
                    onLoad = "[_this select 0] call cTab_fnc_initGroup;";
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
                };

                class warmodeText: cTab_RscText
                {
                    idc = -1;
                    x = 0.72;
                    y = 0.7;
                    w = 0.15;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
                    text = "Режим:";
                    tooltip = "Определяет, как и когда группа будет атаковать вражеские цели";
                };

                class warmode: cTab_RscCombo2
                {
                	idc = 1513;                	
			        x = 0.84;
				    y = 0.7;
				    w = 0.22;
			        h = 0.05;	  
	                SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 	
	                onLoad = "[_this select 0] call cTab_fnc_initWarMode;";
                };

                class behaviorText: cTab_RscText
                {
                    idc = -1;
                    x = 0.72;
                    y = 0.76;
                    w = 0.15;
                    h = 0.05;                     
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
                    text = "Поведение:";
                    tooltip = "Модель поведения группы";
                };

                class behavior: cTab_RscCombo2
                {
                	idc = 1514;                	
			        x = 0.84;
				    y = 0.76;
				    w = 0.22;
			        h = 0.05;  
			        wholeHeight = 0.3;
	                SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 	
	                onLoad = "[_this select 0] call cTab_fnc_initBehaviour;";
                };

                class speedText: cTab_RscText
                {
                    idc = -1;
                    x = 0.72;
                    y = 0.82;
                    w = 0.15;
                    h = 0.05; 
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
                    text = "Скорость:";
                    tooltip = "Скорость передвижения группы";
                };

                class speed: cTab_RscCombo2
                {
                	idc = 1515;                	
			        x = 0.84;
				    y = 0.82;
				    w = 0.22;
			        h = 0.05;
	                SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 	
	                onLoad = "[_this select 0] call cTab_fnc_initSpeed;";
                };

                class apply: cTab_RscButton
                {
                    idc = 1511;
                    text = "Применить";
                    x = 0.76; 
                    y = 0.94;
                    w = 0.12;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "call cTab_fnc_applyWaypoints;";
                };

                class clear: cTab_RscButton
                {
                    idc = 1512;
                    text = "Очистить";
                    x = 0.92; 
                    y = 0.94;
                    w = 0.12;
                    h = 0.05;
                    size = 0.1;
                    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)"; 
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};
                    colorBackgroundActive[] = {0.145, 0.153, 0.098, 0.8};
                    colorFocused[] = {0.145, 0.153, 0.098, 0.8};
                    action = "call cTab_fnc_clearWaypoints;";
                };
			};
		};
				
		class cTabHcamFull : cTab_RscPicture {
			idc = 1245;
			text = "#(argb,512,512,1)r2t(rendertarget13,1.3096153846)";
			x = "(((257))) / 2048  * 	(	(safezoneH * 1.2) * 3/4) + 	(safezoneX + (safezoneW - 	(	(safezoneH * 1.2) * 3/4)) / 2 + (	(	(safezoneH * 1.2) * 3/4) * 96.5 / 2048))";
			y = "(((491) + (42))) / 2048  * 	(safezoneH * 1.2) + 	(safezoneY + (safezoneH - 	(safezoneH * 1.2)) / 2)";
			w = "(((1341))) / 2048  * 	(	(safezoneH * 1.2) * 3/4)";
			h = "(((993) - (42) - (0))) / 2048  * 	(safezoneH * 1.2)";
		};
		
		class notification : cTab_Tablet_notification {};
		
		class loadingtxt : cTab_Tablet_loadingtxt {};
		
		class brightness : cTab_Tablet_brightness {};

		class supportSubmenu : cTab_RscControlsGroup {
			idc = 4656;
			x = "safeZoneXAbs + safeZoneWAbs";
			y = "safeZoneY + safeZoneH";
			w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
			h = "(7 + 0.5) * ((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
			
			class controls {
				class mainbg : cTab_IGUIBack {
					idc = 2200;
					x = 0;
					y = 0;
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "(7 + 0.5) * ((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
				};
				
				class bkbtn : cTab_MenuItem {
					idc = -1;
					text = "Боеприпасы";
					toolTip = "Вызов ящика с боеприпасами на указанную точку";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (1 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[1] call cTab_fnc_userMenuSelect;";
				};
				
				class modbtn : cTab_MenuItem {
					idc = 2001;
					text = "Модули";
					toolTip = "Вызов модулей техники";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (2 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[100] call cTab_fnc_userMenuSelect;";
				};
				
				class artbtn : cTab_MenuItem {
					idc = 2002;
					text = "Арт. удар";
					toolTip = "Вызов артиллерийского удара по указанной позиции";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (3 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[200] call cTab_fnc_userMenuSelect;";
				};
				
				class aviabtn : cTab_MenuItem {
					idc = -1;
					text = "Авиаподдержка";
					toolTip = "Вызов авиаподдержки";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (4 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[2] call cTab_fnc_userMenuSelect;";
				};

				class descentbtn : cTab_MenuItem {
					idc = -1;
					text = "Десант";
					toolTip = "Вызов десанта на указанноую позицию";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (5 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[3] call cTab_fnc_userMenuSelect;";
				};

				class carbtn : cTab_MenuItem {
					idc = -1;
					text = "Техника";
					toolTip = "Вызов техники на указанноую позицию";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (6 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[10] call cTab_fnc_userMenuSelect;";
				};
				
				class exit : cTab_MenuExit {
					idc = -1;
					text = "Выход";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (7 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "ctrlShow [4656, false];";
				};
			};
		};

		class supportSubmenu2 : cTab_RscControlsGroup {
			idc = 4657;
			x = "safeZoneXAbs + safeZoneWAbs";
			y = "safeZoneY + safeZoneH";
			w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
			h = "(4 + 0.5) * ((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
			
			class controls {
				class mainbg : cTab_IGUIBack {
					idc = 2200;
					x = 0;
					y = 0;
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "(4 + 0.5) * ((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
				};
				
				class bkbtn : cTab_MenuItem {
					idc = -1;
					text = "Ремонтный";
					toolTip = "Вызов ремонтоного модуля для техники";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (1 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[4] call cTab_fnc_userMenuSelect;";
				};
				
				class modbtn : cTab_MenuItem {
					idc = 2001;
					text = "Топливный";
					toolTip = "Вызов топливного модуля для техники";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (2 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[5] call cTab_fnc_userMenuSelect;";
				};
				
				class artbtn : cTab_MenuItem {
					idc = 2002;
					text = "Боеприпасы";
					toolTip = "Вызов модуля с боеприпасами для техники";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (3 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[6] call cTab_fnc_userMenuSelect;";
				};								
				
				class exit : cTab_MenuExit {
					idc = -1;
					text = "Выход";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (4 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "ctrlShow [4657, false];";
				};
			};
		};

		class supportSubmenu3 : cTab_RscControlsGroup {
			idc = 4658;
			x = "safeZoneXAbs + safeZoneWAbs";
			y = "safeZoneY + safeZoneH";
			w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
			h = "(4 + 0.5) * ((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
			
			class controls {
				class mainbg : cTab_IGUIBack {
					idc = 2200;
					x = 0;
					y = 0;
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "(4 + 0.5) * ((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
				};
				
				class bkbtn : cTab_MenuItem {
					idc = -1;
					text = "Дымовые";
					toolTip = "Вызов дымовой завесы по указанной позиции";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (1 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[7] call cTab_fnc_userMenuSelect;";
				};
				
				class modbtn : cTab_MenuItem {
					idc = 2001;
					text = "Управляемые";
					toolTip = "Вызов артудара управляемыми снарядами";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (2 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[8] call cTab_fnc_userMenuSelect;";
				};
				
				class artbtn : cTab_MenuItem {
					idc = 2002;
					text = "Фугасные";
					toolTip = "Вызов артудара фугасными снарядами";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (3 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "[9] call cTab_fnc_userMenuSelect;";
				};								
				
				class exit : cTab_MenuExit {
					idc = -1;
					text = "Выход";
					x = 0;
					y = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8 * (4 - 1)";
					w = "(12  + 1.5) * ((27)) / 2048  * 	(safezoneH * 1.2) * 3/4 * 0.5";
					h = "((27)) / 2048  * 	(safezoneH * 1.2) / 0.8";
					sizeEx = "((27)) / 2048  * 	(safezoneH * 1.2)";
					action = "ctrlShow [4658, false];";
				};
			};
		};
		
		class background : cTab_Tablet_background {};
		
		class movingHandle_T : cTab_Tablet_movingHandle_T {};
		
		class movingHandle_B : cTab_Tablet_movingHandle_B {};
		
		class movingHandle_L : cTab_Tablet_movingHandle_L {};
		
		class movingHandle_R : cTab_Tablet_movingHandle_R {};
		
		class btnF1 : cTab_Tablet_btnF1 {
			idc = 1600;
			tooltip = "Карта (F1)";
			action = "['cTab_Tablet_dlg',[['mode','BFT']]] call cTab_fnc_setSettings;";
		};
		
		class btnF2 : cTab_Tablet_btnF2 {
			idc = 1601;
			tooltip = "БПЛА (F2)";
			action = "['cTab_Tablet_dlg',[['mode','UAV']]] call cTab_fnc_setSettings;";
		};
		
		class btnF3 : cTab_Tablet_btnF3 {
			idc = 1602;
			tooltip = "Видео (F3)";
			action = "['cTab_Tablet_dlg',[['mode','HCAM']]] call cTab_fnc_setSettings;";
		};
		
		class btnF4 : cTab_Tablet_btnF4 {
			idc = 1603;
			tooltip = "Поддержка (F4)";
			action = "['cTab_Tablet_dlg',[['mode','SUPPORT']]] call cTab_fnc_setSettings;";
		};
		
		class btnF5 : cTab_Tablet_btnF5 {
			idc = 1604;
			tooltip = "Отряд (F5)";
			//action = "ctrlShow [2222,true];";
			action = "['cTab_Tablet_dlg',[['mode','GROUP']]] call cTab_fnc_setSettings;";
		};
		
		class btnF6 : cTab_Tablet_btnF6 {
			idc = 1605;
			tooltip = "Баллистический компьютер (F6)";
			action = "['cTab_Tablet_dlg',[['mode','BALLISTIC']]] call cTab_fnc_setSettings;";
		};
		
		class btnF7 : cTab_Tablet_btnTrackpad {
			idc = 1612;
			action = "['cTab_Tablet_dlg'] call cTab_fnc_centerMapOnPlayerPosition;";
			tooltip = "Центрирование карты";
		};
		
		class btnMain : cTab_Tablet_btnHome {
			idc = 1606;
			tooltip = "Рабочий стол";
			action = "['cTab_Tablet_dlg',[['mode','DESKTOP']]] call cTab_fnc_setSettings;";
		};
		
		class btnFN : cTab_Tablet_btnFn {
			idc = 1607;
			tooltip = "Инструменты карты";
			action = "['cTab_Tablet_dlg'] call cTab_fnc_toggleMapTools;";
		};
		
		class btnOFF : cTab_Tablet_btnPower {
			idc = 1608;
			action = "closeDialog 0;";
			tooltip = "Закрыть планшет";
		};
		
		class btnUP : cTab_Tablet_btnBrtUp {
			idc = 1609;
			action = "['cTab_Tablet_dlg', 1] call cTab_fnc_changeVisualMode;";
			tooltip = "Следующий режим";
		};
		
		class btnDWN : cTab_Tablet_btnBrtDn {
			idc = 1610;
			action = "['cTab_Tablet_dlg', -1] call cTab_fnc_changeVisualMode;";
			tooltip = "Предыдущий режим";
		};
				
        class btnMode : cTab_Tablet_btnMode {
			idc = 16;
			action = "['cTab_Tablet_dlg'] call cTab_fnc_changeMode;";
			tooltip = "Переключение вида";
		};

		class btnACT : cTab_Tablet_btnMouse {
			idc = 1611;
			action = "_null = [] call cTab_Tablet_btnACT;";
			tooltip = "Подтвердить";
		};


        // insert marker controls
        class MainSubmenu : cTab_RscControlsGroup {
			idc = 3300;
			x = "safeZoneXAbs + safeZoneWAbs";
			y = "safeZoneY + safeZoneH";
			w = "0.192 * safezoneH";
			h = "0.11 * safezoneH";
            onload = "[_this select 0] call cTab_fnc_loadMarkerData;";
			class controls {
				class mainbg: cTab_IGUIBack {
					idc = 2200;
					x = 0;
					y = 0;
					w = "0.192 * safezoneH";
			        h = "0.11 * safezoneH";
			        colorBackground[] = {0, 0, 0, 0.6};
				};				
				class header: cTab_RscText
                {
                    idc = -1;
                    x = 0; 
                    y = 0;
                    w = "0.192 * safezoneH";
                    h = 0.04;	
                    colorBackground[] = {0.145, 0.153, 0.098, 0.8};                    
                    text = "ВСТАВИТЬ МАРКЕР";
                };
                class Color: cTab_RscCombo2
                {
                	idc = 2000;                	
			        x = 0.005;
				    y = 0.05;
				    w = "0.04 * safezoneH";
			        h = "0.02 * safezoneH";	   	
                };
                class Type: cTab_RscCombo2
                {
                	idc = 2001;
                	x = 0.085;
				    y = 0.05;
				    w = "0.04 * safezoneH";
			        h = "0.02 * safezoneH";	
                };                
                class Channel: cTab_RscCombo2
                {
                	idc = 2002;
                	x = 0.16;
				    y = 0.05;
				    w = "0.1 * safezoneH";
			        h = "0.02 * safezoneH";
                };
                class Name: cTab_RscEdit
                {
                	idc = 2003;
                	x = 0.005;
				    y = 0.1;
				    w = "0.185 * safezoneH";
			        h = "0.025 * safezoneH";
			        size = 0.15;
			        text = "";
                };
                class Ok: cTab_RscButton
                {
                	idc = 2005;
                	text = "OK";
                	x = 0.005;
				    y = 0.15;
				    w = "0.07 * safezoneH";
			        h = "0.02 * safezoneH";
			        action = "call cTab_fnc_createMarker;ctrlShow [3300,false];";
                };
                class Cancel: cTab_RscButton
                {
                	idc = 2006;
                	text = "ОТМЕНА";
                	x = 0.215;
				    y = 0.15;
				    w = "0.07 * safezoneH";
			        h = "0.02 * safezoneH";
			        action = "ctrlShow [3300,false];";
                };
			};
		}; 

		class Error : cTab_RscControlsGroup {
            idc = 2222;
			x = "0.5 * safezoneW + safezoneX - (0.18 * safezoneH) / 2";
    	    y = "0.5 * safezoneH + safezoneY - (0.12 * safezoneH) / 2";
		    w = "0.18 * safezoneH";
			h = "0.12 * safezoneH";

			class VScrollbar {};
			
			class HScrollbar {};
			
			class Scrollbar {};
			
			class controls {
                class window : cTab_RscPicture {
		        	idc = 9;
		        	text = "scripts\cTab\img\error.jpg";
		        	x = 0;
		        	y = 0;
		        	w = "0.18 * safezoneH";
			        h = "0.12 * safezoneH";
		        };
                class close : cTab_Tablet_btnMouse {
		        	idc = 10;
		        	x = 0.24;
				    y = 0.17;
				    w = "0.04 * safezoneH";
			        h = "0.02 * safezoneH";
			        action = "ctrlShow [2222,false];";
		        };
            };
        };       
	};
};
