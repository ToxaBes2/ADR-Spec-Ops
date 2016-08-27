commandermenu =
[
	["Поддержка", true],
		["Арт. удар: дымовые", [2], "", -5, [["expression", '["6Rnd_155mm_Mo_smoke"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
		["Арт. удар: управляемые", [3], "", -5, [["expression", '["2Rnd_155mm_Mo_guided"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
		["Арт. удар: фугасные", [4], "", -5, [["expression", '["32Rnd_155mm_Mo_shells"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],		
		["Запрос боеприпасов", [5], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\supplydrop_select.sqf";}']], "1", "1"],
		["(separator)",       [6], "", -1, [["expression", ""]], "1", "1"],	// separator line
		["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:commandermenu";
