_pathtotools = "scripts\admin\tools\";
_EXECscript1 = '[player] spawn {_this call compile preProcessFileLineNumbers "'+_pathtotools+'%1";}';

adminmenu =
[
	["Menu", true],
		["Телепорт", [1], "", -5, [["expression", format[_EXECscript1,"teleport.sqf"]]], "1", "1"],
		["Телепорт игрока ко мне", [2], "", -5, [["expression", format[_EXECscript1,"tptome.sqf"]]], "1", "1"],		
		["Неуязвимость вкл", [3], "", -5, [["expression", format[_EXECscript1,"godon.sqf"]]], "1", "1"],
		["Неуязвимость выкл", [4], "", -5, [["expression", format[_EXECscript1,"godoff.sqf"]]], "1", "1"],
		["Выход", [5], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:adminmenu";