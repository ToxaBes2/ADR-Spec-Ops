/*
  Author: ToxaBes
  Description: server rules dialog
*/
class TG_SXRscText {
    idc = -1;
    type = 0;
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
class TG_RscBG: TG_SXRscText {
    idc = -1;
    type = 0;
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
class TG_RscShortcutButtonDOM {
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

class TG_XD_ButtonBase: TG_RscShortcutButtonDOM {
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

class TG_RscListNBox {
    style = 16;
    type=102;
    shadow = 0;
    font = "PuristaMedium";
    sizeEx = "(         (           (           ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    color[] = {0.95, 0.95, 0.95, 1};
    colorText[] = {1, 1, 1, 1.0};
    colorDisabled[] = {1, 1, 1, 0.25};
    colorScrollbar[] = {0.95, 0.95, 0.95, 1};
    colorSelect[] = {0, 0, 0, 1};
    colorSelect2[] = {0, 0, 0, 1};
    colorSelectBackground[] = {0.95, 0.95, 0.95, 1};
    colorSelectBackground2[] = {1, 1, 1, 0.5};
    period = 1.2;

    class ScrollBar {
        color[] = {1, 1, 1, 0.6};
        colorActive[] = {1, 1, 1, 1};
        colorDisabled[] = {1, 1, 1, 0.3};
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    };
};

class TEHGAM_RULES {
    idd = 1511;
    name= "tehgam_rules";
    movingEnable = true;
    enableSimulation = true;
    onLoad = "uiNamespace setVariable ['TEHGAM_Rules_Display', (_this select 0)]; _null = [] spawn {_this call compile preProcessFileLineNumbers 'scripts\rules\info.sqf';};";
    onUnLoad = "_uid = getPlayerUID player;_rules = missionNamespace getVariable ['TEHGAM_RULES',[]]; if (!(_uid in _rules)) then {_rules set [count _rules, _uid];missionNamespace setVariable ['TEHGAM_RULES', _rules];};";
    class controlsBackground {
        class TG_BackGround : TG_RscBG {
            x = "SafeZoneXAbs";
            y = "SafeZoneY";
            w = "safeZoneWAbs";
            h = "SafeZoneH";
            colorBackground[] = {0.149, 0.196, 0.219, 0.95};
        };
    };

    class controls {
        class TG_MainCaption {
            colorBackground[] = {1, 1, 1, 0};
            colorText[] = {1, 1, 1, 1};
            idc = 7778;
            text = "$STR_VAS_Info_Title";
            x = "SafeZoneX";
            y = "SafeZoneY + 0.01";
            w = "SafeZoneW";
            h = 0.13;
            sizeEx = 0.1;
            style = 2;
            shadow = 0;
            type = 0;
            colorShadow[] = {0,0,0,0.5};
            font = "PuristaMedium";
            linespacing = 1;
        };

        class Dom2 : TG_MainCaption {
            idc = -1;
            x = "SafeZoneX + 0.05";
            y = "SafeZoneY + SafeZoneH - 0.1";
            colorText[] = {1, 1, 1, 1};
            text = "";
        };
    
        class TG_XD_CloseButton: TG_XD_ButtonBase {
            idc = 9999;
            text = "$STR_VAS_Main_btnClose"; 
            action = "closeDialog 0";
            default = true;
            x = "SafeZoneX + SafeZoneW - 0.3";
            y = "SafeZoneY + SafeZoneH - 0.07";
            colorFocused[] = { 1, 1, 1, 1 };
            colorBackgroundFocused[] = { 1, 1, 1, 0 };
        };    

        class Table: TG_RscListNBox {
            idc = 7777;
            type = 102;
            style = 16;
            columns[] = {0.005,0.025,0.06};
            drawSideArrows = 0;
            idcLeft = -1; 
            idcRight = -1;
            maxHistoryDelay = 1;
            rowHeight = 0.05;
            x = 0;
            y = 0;
            w = "SafeZoneW - 0.05";
            h = "SafeZoneH - 0.3";
            font = "PuristaLight";
            sizeEx = 0.03921;
            soundSelect[] = {"", 0.1, 1}; 
            colorBackground[] = {0.149, 0.196, 0.219, 0.9};
            colorPicture[] = {1,1,1,1};
            colorPictureSelected[] = {1,1,1,1};
            colorPictureDisabled[] = {1,1,1,1};
            class ListScrollBar {
                width = 0.7; 
                height = 0.7;
                scrollSpeed = 0.01;
                arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
                arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
                border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
                thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
                color[] = {1,1,1,1};
            };              
        };
    };
};
