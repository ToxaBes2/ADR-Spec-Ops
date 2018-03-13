partizanmenu =
[
    ["Поддержка", true],
        ["(separator)", [2], "", -1, [["expression", ""]], "1", "1"], // separator line
        ["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
];

// Commander #1
if (PARTIZAN_BASE_SCORE > 2) then {  
    partizanmenu =
    [
    	["Поддержка", true],
    		["Блокпост", [2], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\checkpoint_select.sqf";}']], "1", "1"],
    		["(separator)", [3], "", -1, [["expression", ""]], "1", "1"],	// separator line
    		["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

// Commander #2
if (BPARTIZAN_BASE_SCORE > 11) then {  
    partizanmenu =
    [
        ["Поддержка", true],
            ["Блокпост", [2], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\checkpoint_select.sqf";}']], "1", "1"],
            ["Патруль", [3], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\patrol_select.sqf";}']], "1", "1"],            
            ["(separator)", [4], "", -1, [["expression", ""]], "1", "1"], // separator line
            ["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

// Commander #3
if (BLUFOR_BASE_SCORE > 20) then {  
    partizanmenu =
    [
        ["Поддержка", true],
            ["Блокпост", [2], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\checkpoint_select.sqf";}']], "1", "1"],
            ["Патруль", [3], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\patrol_select.sqf";}']], "1", "1"],            
            ["Технички", [4], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\technical_select.sqf";}']], "1", "1"],                        
            ["(separator)", [5], "", -1, [["expression", ""]], "1", "1"], // separator line
            ["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

// Commander #4
if (BLUFOR_BASE_SCORE > 29) then {  
    partizanmenu =
    [
        ["Поддержка", true],
            ["Блокпост", [2], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\checkpoint_select.sqf";}']], "1", "1"],
            ["Патруль", [3], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\patrol_select.sqf";}']], "1", "1"],            
            ["Технички", [4], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\technical_select.sqf";}']], "1", "1"],                        
            ["Минное поле", [5], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\partizan_tools\minefield_select.sqf";}']], "1", "1"],                                     
            ["(separator)", [6], "", -1, [["expression", ""]], "1", "1"], // separator line
            ["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

showCommandingMenu "#USER:partizanmenu";
