/*
  ArmA 3 TAW View Distance Management
*/

#define ST_LEFT               0x00
#define ST_MULTI              0x10
#define GUI_GRID_CENTER_WAbs  ((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_CENTER_HAbs  (GUI_GRID_CENTER_WAbs / 1.2)
#define GUI_GRID_CENTER_W     (GUI_GRID_CENTER_WAbs / 40)
#define GUI_GRID_CENTER_H     (GUI_GRID_CENTER_HAbs / 25)
#define GUI_GRID_CENTER_X     (safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y     (safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)

class TAWVD_Checkbox
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
class TAWVD_RscShortcutButton
{
  idc = -1;
  style = 0;
  default = 0;
  shadow = 1;
  w = 0.183825; h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
  color[] = {1,1,1,1.0};
  colorFocused[] = {1,1,1,1.0};
  color2[] = {0.95,0.95,0.95,1};
  colorDisabled[] = {1,1,1,0.25};
  colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
  colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
  colorBackground2[] = {1,1,1,1};
  animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
  animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
  animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
  animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
  animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
  animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
  periodFocus = 1.2;
  periodOver = 0.8;
  class HitZone
  {
    left = 0.0;
    top = 0.0;
    right = 0.0;
    bottom = 0.0;
  };
  class ShortcutPos
  {
    left = 0;
    top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
    w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
    h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  };
  class TextPos
  {
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
  soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
  soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
  soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
  action = "";
  class Attributes
  {
    font = "PuristaMedium";
    color = "#E5E5E5";
    align = "left";
    shadow = "true";
  };
  class AttributesImage
  {
    font = "PuristaMedium";
    color = "#E5E5E5";
    align = "left";
  };
};

class TAWVD_RscText
{
  x = 0; y = 0;
  w = 0.3; h = 0.037;
  type = 0;
  style = 0;
  shadow = 1;
  colorShadow[] = {0, 0, 0, 0.5};
  font = "PuristaMedium";
  SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  text = "";
  colorText[] = {1, 1, 1, 1.0};
  colorBackground[] = {0, 0, 0, 0};
  linespacing = 1;
};

class TAWVD_RscTitle : TAWVD_RscText
{
  style = 0;
  shadow = 0;
  sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  colorText[] = {0.95, 0.95, 0.95, 1};
};

class TAWVD_RscButtonMenu : TAWVD_RscShortcutButton
{
  idc = -1;
  type = 16;
  style = "0x02 + 0xC0";
  default = 0;
  shadow = 0;
  x = 0; y = 0;
  w = 0.095589; h = 0.039216;
  animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
  animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
  animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
  colorBackground[] = {0,0,0,0.8};
  colorBackgroundFocused[] = {1,1,1,1};
  colorBackground2[] = {0.75,0.75,0.75,1};
  color[] = {1,1,1,1};
  colorFocused[] = {0,0,0,1};
  color2[] = {0,0,0,1};
  colorText[] = {1,1,1,1};
  colorDisabled[] = {1,1,1,0.25};
  period = 1.2;
  periodFocus = 1.2;
  periodOver = 1.2;
  size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
  tooltipColorText[] = {1,1,1,1};
  tooltipColorBox[] = {1,1,1,1};
  tooltipColorShade[] = {0,0,0,0.65};
  class TextPos
  {
    left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
    top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
    right = 0.005;
    bottom = 0.0;
  };
  class Attributes
  {
    font = "PuristaLight";
    color = "#E5E5E5";
    align = "left";
    shadow = "false";
  };
  class ShortcutPos
  {
    left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
    top = 0.005;
    w = 0.0225; h = 0.03;
  };
  soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
  soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
  soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
  textureNoShortcut = "";
};

class TAWVD_RscXSliderH
{
  style = 1024;
  type = 43;
  shadow = 2;
  x = 0; y = 0;
  w = 0.400000; h = 0.029412;
  color[] = {1, 1, 1, 0.7};
  colorActive[] = {1, 1, 1, 1};
  colorDisabled[] = {1, 1, 1, 0.500000};
  arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
  arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
  border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
  thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
};

class TAWVD_activeText
{
  idc = -1;
  type = 11;
  style = 0;
  x = 0; y = 0;
  w = 0.3; h = 0.037;
  sizeEx = 0.040;
  font = "PuristaLight";
  color[] = {1, 1, 1, 1};
  colorActive[] = {1, 0.2, 0.2, 1};
  colorDisabled[] = {1, 1, 1, 0.500000};
  soundEnter[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\CfgNotifications\taskCreated",0.0,0};
  soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.07,1};
  soundEscape[] = {"\A3\ui_f\data\sound\ReadOut\ReadoutHideClick1",0.09,1};
  action = "";
  text = "";
};

class TAW_VD
{
  idd = 2900;
  name= "taw_vd";
  movingEnable = false;
  enableSimulation = true;

  class controlsBackground
  {
    class TAWVD_RscTitleBackground:TAWVD_RscText
    {
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
      idc = -1;
      x = 0.3; y = 0.2;
      w = 0.5; h = (1 / 25);
    };

    class MainBackground : TAWVD_RscText
    {
      colorBackground[] = {0, 0, 0, 0.7};
      idc = -1;
      x = 0.3; y = 0.2 + (11 / 250);
      w = 0.5; h = 0.67 - (22 / 250);
    };

    class VDonFoot : TAWVD_RscText
    {
      idc = -1;
      text = "Пешком";
      x = 0.32; y = 0.258;
      w = 0.275; h = 0.04;
    };

    class VDinCar : TAWVD_RscText
    {
      idc = -1;
      text = "Машины";
      x = 0.32; y = 0.305;
      w = 0.275; h = 0.04;
    };

    class VDinAir : TAWVD_RscText
    {
      idc = -1;
      text = "Авиация";
      x = 0.32; y = 0.355;
      w = 0.275; h = 0.04;
    };

    class VDObject : VDinAir
    {
      text = "Объекты";
      y = 0.655;
    };

    class VDTerrSet : TAWVD_RscText
    {
      idc = -1;
      text = "Настройка травы";
      shadow = 0;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
      x = 0.30; y = 0.45;
      w = 0.5; h = (1 / 25);
    };

    class VDObjectSet : VDTerrSet
    {
      text = "Настройка объектов";
      y = 0.55;
    };

    class VDColorSet : TAWVD_RscText
    {
      idc = -1;
      text = "Цветокоррекция";
      shadow = 0;
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
      x = 0.30; y = 0.72;
      w = 0.5; h = (1 / 25);
    };
  };

  class controls
  {
    class Title : TAWVD_RscTitle
    {
      colorBackground[] = {0, 0, 0, 0};
      idc = -1;
      text = "Управление дальностью отображения";
      x = 0.3; y = 0.2;
      w = 0.8; h = (1 / 25);
    };

    class VD_onfoot_slider : TAWVD_RscXSliderH
    {
      idc = 2901;
      text = "";
      onSliderPosChanged = "[0,_this select 1] call TAWVD_fnc_onSliderChange;";
      tooltip = "Дальность видимости пешеходом";
      x = 0.42; y = 0.30 - (1 / 25);
      w = "9 * (((safezoneW / safezoneH) min 1.2) / 40)";
      h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };

    class VD_onfoot_value : TAWVD_RscText
    {
      idc = 2902;
      text = "";
      x = 0.70; y = 0.258;
      w = 0.275; h = 0.04;
    };

    class VD_car_slider : TAWVD_RscXSliderH
    {
      idc = 2911;
      text = "";
      onSliderPosChanged = "[1,_this select 1] call TAWVD_fnc_onSliderChange;";
      tooltip = "Дальность видимости находясь в наземной технике";
      x = 0.42; y = 0.35 - (1 / 25);
      w = "9 * (((safezoneW / safezoneH) min 1.2) / 40)";
      h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };

    class VD_car_value : TAWVD_RscText
    {
      idc = 2912;
      text = "";
      x = 0.70; y = 0.31;
      w = 0.275; h = 0.04;
    };

    class VD_air_slider : TAWVD_RscXSliderH
    {
      idc = 2921;
      text = "";
      onSliderPosChanged = "[2,_this select 1] call TAWVD_fnc_onSliderChange;";
      tooltip = "Дальность видимости находясь в воздушной технике";
      x = 0.42; y = 0.40 - (1 / 25);
      w = "9 * (((safezoneW / safezoneH) min 1.2) / 40)";
      h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };

    class VD_air_value : TAWVD_RscText
    {
      idc = 2922;
      text = "";
      x = 0.70; y = 0.36;
      w = 0.275; h = 0.04;
    };

    class ObjectSyncCheckbox : TAWVD_Checkbox
    {
      idc = 2931;
      x = 0.32; y = 0.6;
      tooltip = "Синхронизировать прорисовку объектов с дальностью прорисовки вида";
      onCheckedChanged = "if((_this select 1) == 1) then {tawvd_syncObject = true;ctrlEnable [2941,false];} else {tawvd_syncObject = false; ctrlEnable [2941,true];};";
    };

    class ObjectSyncText : TAWVD_RscText
    {
      idc = -1;
      text = "Синхронно с Пешком";
      x = 0.345; y = 0.596;
      w = 0.35; h = 0.04;
    };

    class VD_object_slider : VD_air_slider
    {
      idc = 2941;
      onSliderPosChanged = "[3,_this select 1] call TAWVD_fnc_onSliderChange;";
      tooltip = "Дальность прорисовки объектов";
      y = 0.70 - (1 / 25);
    };

    class VD_Object_Value : VD_air_value
    {
      idc = 2942;
      y = 0.656;
    };

    //class VD_terr_none : TAWVD_activeText
    //{
    //  idc = -1;
    //  text = "Нет";
    //  action = "['none'] call TAWVD_fnc_onTerrainChange;";
    //  sizeEx = 0.04;
    //  x = 0.38; y = 0.50;
    //  w = 0.275; h = 0.04;
    //};

    class VD_terr_low : TAWVD_activeText
    {
      idc = -1;
      text = "Мало";
      action = "['low'] call TAWVD_fnc_onTerrainChange;";
      sizeEx = 0.04;
      x = 0.42; y = 0.50;
      w = 0.275; h = 0.04;
    };

    class VD_terr_normal : TAWVD_activeText
    {
      idc = -1;
      text = "Средне";
      action = "['norm'] call TAWVD_fnc_onTerrainChange;";
      sizeEx = 0.04;
      x = 0.51; y = 0.50;
      w = 0.275; h = 0.04;
    };

    class VD_terr_high : TAWVD_activeText
    {
      idc = -1;
      text = "Много";
      action = "['high'] call TAWVD_fnc_onTerrainChange;";
      sizeEx = 0.04;
      x = 0.62; y = 0.50;
      w = 0.275; h = 0.04;
    };


    class VD_color_low : TAWVD_activeText
    {
      idc = -1;
      text = "Мало";
      action = "['None', 0, false] call BIS_fnc_setPPeffectTemplate;";
      tooltip = "Без цветокоррекции";
      sizeEx = 0.04;
      x = 0.42; y = 0.77;
      w = 0.275; h = 0.04;
    };

    class VD_color_normal : TAWVD_activeText
    {
      idc = -1;
      text = "Средне";
      action = "['Mediterranean', 0, false] call BIS_fnc_setPPeffectTemplate;";
      tooltip = "Средиземноморье";
      sizeEx = 0.04;
      x = 0.51; y = 0.77;
      w = 0.275; h = 0.04;
    };

    class VD_color_high : TAWVD_activeText
    {
      idc = -1;
      text = "Много";
      action = "['EastWind', 0, false] call BIS_fnc_setPPeffectTemplate;";
      tooltip = "Восточный ветер";
      sizeEx = 0.04;
      x = 0.62; y = 0.77;
      w = 0.275; h = 0.04;
    };

    class ButtonClose : TAWVD_RscButtonMenu
    {
      idc = -1;
      text = "Закрыть";
      onButtonClick = "closeDialog 0;";
      x = 0.48; y = 0.89 - (1 / 25);
      w = (6.25 / 40); h = (1 / 25);
    };
  };
};
