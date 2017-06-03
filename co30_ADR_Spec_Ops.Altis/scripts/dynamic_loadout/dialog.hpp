/*
Author: Grumpy Old Man
*/
#define GUI_GRID_X      (0)
#define GUI_GRID_Y      (0)
#define GUI_GRID_W      (0.025)
#define GUI_GRID_H      (0.04)
#define GUI_GRID_WAbs   (1)
#define GUI_GRID_HAbs   (1)

class GOM_dialog_aircraftLoadout {
    idd = 66;
    movingEnable = 0;
    class controls {
        class GOMRscStructuredText_1100: GOMRscStructuredText
        {
        	idc = 1100;
        	text = "<t align='center'>"; 
        	x = 1 * GUI_GRID_W + GUI_GRID_X;
        	y = 2 * GUI_GRID_H + GUI_GRID_Y;
        	w = 38 * GUI_GRID_W;
        	h = 7 * GUI_GRID_H;
        	colorBackground[] = {0,0,0,0.7};
        };
        class GOMRscStructuredText_1101: GOMRscStructuredText
        {
        	idc = 1101;
        	text = "<t align='center'>Перевооружение авиации";
        	x = 1 * GUI_GRID_W + GUI_GRID_X;
        	y = 0 * GUI_GRID_H + GUI_GRID_Y;
        	w = 38 * GUI_GRID_W;
        	h = 2 * GUI_GRID_H;
        	colorBackground[] = {0,0,0,0.7};
        };
        class GOMRscListbox_1500: GOMRscListBox
        {
        	idc = 1500;
        	x = 1 * GUI_GRID_W + GUI_GRID_X;
        	y = 11 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6 * GUI_GRID_W;
        	h = 12 * GUI_GRID_H;
        };
        class GOMRscListbox_1501: GOMRscListBox
        {
        	idc = 1501;
        	x = 8 * GUI_GRID_W + GUI_GRID_X;
        	y = 11 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6 * GUI_GRID_W;
        	h = 12 * GUI_GRID_H;
        };
        class GOMRscListbox_1502: GOMRscListBox
        {
        	idc = 1502;
        	x = 15 * GUI_GRID_W + GUI_GRID_X;
        	y = 11 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6 * GUI_GRID_W;
        	h = 12 * GUI_GRID_H;
        };
        class GOMRscStructuredText_1102: GOMRscStructuredText
        {
        	idc = 1102;
        	text = "<t align='center'>Техника"; 
        	x = 1 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        	colorBackground[] = {0,0,0,0.7};
        };
        class GOMRscStructuredText_1103: GOMRscStructuredText
        {
        	idc = 1103;
        	text = "<t align='center'>Подвеска"; 
        	x = 8 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        	colorBackground[] = {0,0,0,0.7};
        };
        class GOMRscStructuredText_1104: GOMRscStructuredText
        {
        	idc = 1104;
        	text = "<t align='center'>Оружие"; 
        	x = 15 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        	colorBackground[] = {0,0,0,0.7};
        };
        class GOMRscButton_1600: GOMRscButton
        {
        	idc = 1600;
        	text = "Установить"; 
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscButton_1601: GOMRscButton
        {
        	idc = 1601;
        	text = "Очистить подвески"; 
        	x = 32 * GUI_GRID_W + GUI_GRID_X;
        	y = 23 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscStructuredText_1105: GOMRscStructuredText
        {
        	idc = 1105;
        	text = "<t align='center'>Количество:"; 
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        	colorBackground[] = {0,0,0,0.7};
        };
        class GOMRscEdit_1400: GOMRscEdit
        {
        	idc = 1400;
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 11 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscButton_1602: GOMRscButton
        {
        	idc = 1602;
        	text = "Ремонт"; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 10 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscButton_1603: GOMRscButton
        {
        	idc = 1603;
        	text = "Заправка"; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscButton_1604: GOMRscButton
        {
        	idc = 1604;
        	text = "Перезарядка"; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 13 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscCheckbox_2800: GOMRscCheckBox
        {
        	idc = 2800;
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 17 * GUI_GRID_H + GUI_GRID_Y;
        	w = 1 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscCheckbox_2801: GOMRscCheckBox
        {
        	idc = 2801;
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 1 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscCheckbox_2802: GOMRscCheckBox
        {
        	idc = 2802;
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 20 * GUI_GRID_H + GUI_GRID_Y;
        	w = 1 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscText_1003: GOMRscText
        {
        	idc = 1003;
        	text = "Сообщать данные"; 
        	x = 23 * GUI_GRID_W + GUI_GRID_X;
        	y = 17 * GUI_GRID_H + GUI_GRID_Y;
        	w = 8.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscText_1004: GOMRscText
        {
        	idc = 1004;
        	text = "Получать данные"; 
        	x = 23 * GUI_GRID_W + GUI_GRID_X;
        	y = 18.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 8.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscText_1005: GOMRscText
        {
        	idc = 1005;
        	text = "Местоположение"; 
        	x = 23 * GUI_GRID_W + GUI_GRID_X;
        	y = 20 * GUI_GRID_H + GUI_GRID_Y;
        	w = 9 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscFrame_1800: GOMRscFrame
        {
        	idc = 1800;
        	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 0 * GUI_GRID_H + GUI_GRID_Y;
        	w = 39 * GUI_GRID_W;
        	h = 24 * GUI_GRID_H;
        	colorBackground[] = {-1,-1,-1,0.3};
        	colorActive[] = {0,0,0,1};
        };
        class GOMRscText_1009: GOMRscText
        {
        	idc = 1009;
        	text = "Исп: Пилот"; 
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 14 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscButton_1605: GOMRscButton
        {
        	idc = 1605;
        	text = "передать: Стрелку"; 
        	x = 22 * GUI_GRID_W + GUI_GRID_X;
        	y = 15.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscCombo_2100: GOMRscCombo
        {
        	idc = 2100;
        	text = "Ливрея"; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscFrame_1801: GOMRscFrame
        {
        	idc = 1801;
        	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7 * GUI_GRID_W;
        	h = 14 * GUI_GRID_H;
        };
        class GOMRscFrame_1802: GOMRscFrame
        {
        	idc = 1802;
        	x = 7.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7 * GUI_GRID_W;
        	h = 14 * GUI_GRID_H;
        };
        class GOMRscFrame_1803: GOMRscFrame
        {
        	idc = 1803;
        	x = 14.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7 * GUI_GRID_W;
        	h = 14 * GUI_GRID_H;
        };
        class GOMRscFrame_1804: GOMRscFrame
        {
        	idc = 1804;
        	x = 21.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7.5 * GUI_GRID_W;
        	h = 4.5 * GUI_GRID_H;
        };
        class GOMRscFrame_1805: GOMRscFrame
        {
        	idc = 1805;
        	x = 21.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 14 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7.5 * GUI_GRID_W;
        	h = 3 * GUI_GRID_H;
        };
        class GOMRscFrame_1806: GOMRscFrame
        {
        	idc = 1806;
        	x = 21.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 17 * GUI_GRID_H + GUI_GRID_Y;
        	w = 10.5 * GUI_GRID_W;
        	h = 4 * GUI_GRID_H;
        };
        class GOMRscFrame_1807: GOMRscFrame
        {
        	idc = 1807;
        	x = 0.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 0 * GUI_GRID_H + GUI_GRID_Y;
        	w = 39 * GUI_GRID_W;
        	h = 9.5 * GUI_GRID_H;
        };
        class GOMRscCombo_2101: GOMRscCombo
        {
        	idc = 2101;
        	text = "Шаблон"; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 16 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscFrame_1808: GOMRscFrame
        {
        	idc = 1808;
        	x = 32 * GUI_GRID_W + GUI_GRID_X;
        	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7.5 * GUI_GRID_W;
        	h = 6.5 * GUI_GRID_H;
        };
        class GOMRscEdit_1401: GOMRscEdit
        {
        	idc = 1401;
        	text = "Ваш шаблон"; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscButton_1606: GOMRscButton
        {
        	idc = 1606;
        	text = "Сохр."; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 21 * GUI_GRID_H + GUI_GRID_Y;
        	w = 3 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscButton_1607: GOMRscButton
        {
        	idc = 1607;
        	text = "Удалить"; 
        	x = 36 * GUI_GRID_W + GUI_GRID_X;
        	y = 21 * GUI_GRID_H + GUI_GRID_Y;
        	w = 3 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        class GOMRscFrame_1809: GOMRscFrame
        {
        	idc = 1809;
        	x = 32 * GUI_GRID_W + GUI_GRID_X;
        	y = 16 * GUI_GRID_H + GUI_GRID_Y;
        	w = 7.5 * GUI_GRID_W;
        	h = 6.5 * GUI_GRID_H;
        };
        class GOMRscButton_1608: GOMRscButton
        {
        	idc = 1608;
        	text = "Загрузить шаблон"; 
        	x = 32.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 17.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.5 * GUI_GRID_W;
        	h = 1 * GUI_GRID_H;
        };
        //class GOMRscButton_1609: GOMRscButton
        //{
        //	idc = 1609;
        //
        //	text = "Показать ресурсы"; 
        //	x = 22 * GUI_GRID_W + GUI_GRID_X;
        //	y = 22 * GUI_GRID_H + GUI_GRID_Y;
        //	w = 6.5 * GUI_GRID_W;
        //	h = 1 * GUI_GRID_H;
        //};
    };
};
