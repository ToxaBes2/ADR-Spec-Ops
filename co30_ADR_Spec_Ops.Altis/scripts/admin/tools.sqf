_pathtotools = "scripts\admin\tools\";
_EXECscript1 = '[player] spawn {_this call compile preProcessFileLineNumbers "'+_pathtotools+'%1";}';

adminmenu =
[
	["Инструменты", true],
		["Телепорт", [2], "", -5, [["expression", format[_EXECscript1,"teleport.sqf"]]], "1", "1"],
		["Телепорт игрока ко мне", [3], "", -5, [["expression", format[_EXECscript1,"tptome.sqf"]]], "1", "1"],
		["(separator)",       [3], "", -1, [["expression", ""]], "1", "1"],	// separator line
		["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:adminmenu";