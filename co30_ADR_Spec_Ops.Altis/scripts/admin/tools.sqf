_pathtotools = "scripts\admin\tools\";
_EXECscript1 = '[player] spawn {_this call compile preProcessFileLineNumbers "'+_pathtotools+'%1";}';

adminmenu =
[
	["Menu", true],
		["Телепорт", [2], "", -5, [["expression", format[_EXECscript1,"teleport.sqf"]]], "1", "1"],
		["Телепорт игрока ко мне", [3], "", -5, [["expression", format[_EXECscript1,"tptome.sqf"]]], "1", "1"],
		["Лечиться", [4], "", -5, [["expression", format[_EXECscript1,"heal.sqf"]]], "1", "1"],
		["Лечить игрока", [5], "", -5, [["expression", format[_EXECscript1,"healp.sqf"]]], "1", "1"],
		["Неуязвимость вкл", [6], "", -5, [["expression", format[_EXECscript1,"godon.sqf"]]], "1", "1"],
		["Неуязвимость выкл", [7], "", -5, [["expression", format[_EXECscript1,"godoff.sqf"]]], "1", "1"],
		["Невидимость вкл", [8], "", -5, [["expression", format[_EXECscript1,"invisible.sqf"]]], "1", "1"],
		["Невидимость выкл", [9], "", -5, [["expression", format[_EXECscript1,"visible.sqf"]]], "1", "1"],
		["Хочу квадрик", [10], "", -5, [["expression", format[_EXECscript1,"kvadr.sqf"]]], "1", "1"],
		["Выход", [13], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:adminmenu";