commandermenu =
[
    ["Поддержка", true],
        ["(separator)",       [2], "", -1, [["expression", ""]], "1", "1"], // separator line
        ["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
];

// Commander #1
if (BLUFOR_BASE_SCORE > 5) then {  
    commandermenu =
    [
    	["Поддержка", true],
    		["Запрос боеприпасов", [2], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\supplydrop_select.sqf";}']], "1", "1"],    		
            ["Модуль ремонтный", [3], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\repairdrop_select.sqf";}']], "1", "1"],
            ["Модуль топливный", [4], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\refueldrop_select.sqf";}']], "1", "1"],
            ["Модуль боеприпасов", [5], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\rearmdrop_select.sqf";}']], "1", "1"],            
            ["(separator)",       [6], "", -1, [["expression", ""]], "1", "1"],	// separator line
    		["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

// Commander #2
if (BLUFOR_BASE_SCORE > 14) then {  
    commandermenu =
    [
    	["Поддержка", true],
    		["Арт. удар: дымовые", [2], "", -5, [["expression", '["6Rnd_155mm_Mo_smoke"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
    		["Арт. удар: управляемые", [3], "", -5, [["expression", '["2Rnd_155mm_Mo_guided"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
    		["Арт. удар: фугасные", [4], "", -5, [["expression", '["32Rnd_155mm_Mo_shells"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],		
    		["Запрос боеприпасов", [5], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\supplydrop_select.sqf";}']], "1", "1"],
            ["Модуль ремонтный", [6], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\repairdrop_select.sqf";}']], "1", "1"],
            ["Модуль топливный", [7], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\refueldrop_select.sqf";}']], "1", "1"],
            ["Модуль боеприпасов", [8], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\rearmdrop_select.sqf";}']], "1", "1"],                        
    		["(separator)",       [9], "", -1, [["expression", ""]], "1", "1"],	// separator line
    		["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

// Commander #3
if (BLUFOR_BASE_SCORE > 23) then {  
    commandermenu =
    [
    	["Поддержка", true],
    		["Арт. удар: дымовые", [2], "", -5, [["expression", '["6Rnd_155mm_Mo_smoke"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
    		["Арт. удар: управляемые", [3], "", -5, [["expression", '["2Rnd_155mm_Mo_guided"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
    		["Арт. удар: фугасные", [4], "", -5, [["expression", '["32Rnd_155mm_Mo_shells"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],		
    		["Запрос боеприпасов", [5], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\supplydrop_select.sqf";}']], "1", "1"],
    		["Модуль ремонтный", [6], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\repairdrop_select.sqf";}']], "1", "1"],
            ["Модуль топливный", [7], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\refueldrop_select.sqf";}']], "1", "1"],
            ["Модуль боеприпасов", [8], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\rearmdrop_select.sqf";}']], "1", "1"],                        
            ["Авиаподдержка", [9], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\airsupport_select.sqf";}']], "1", "1"],                       
            ["(separator)",       [10], "", -1, [["expression", ""]], "1", "1"],	// separator line
    		["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

// Commander #4
if (BLUFOR_BASE_SCORE > 32) then {  
    commandermenu =
    [
    	["Поддержка", true],
    		["Арт. удар: дымовые", [2], "", -5, [["expression", '["6Rnd_155mm_Mo_smoke"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
    		["Арт. удар: управляемые", [3], "", -5, [["expression", '["2Rnd_155mm_Mo_guided"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],
    		["Арт. удар: фугасные", [4], "", -5, [["expression", '["32Rnd_155mm_Mo_shells"] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\artillery_select.sqf";}']], "1", "1"],		
    		["Запрос боеприпасов", [5], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\supplydrop_select.sqf";}']], "1", "1"],
    		["Модуль ремонтный", [6], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\repairdrop_select.sqf";}']], "1", "1"],
            ["Модуль топливный", [7], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\refueldrop_select.sqf";}']], "1", "1"],
            ["Модуль боеприпасов", [8], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\rearmdrop_select.sqf";}']], "1", "1"],                        
            ["Авиаподдержка", [9], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\airsupport_select.sqf";}']], "1", "1"],    		
    		["Вызов десанта", [10], "", -5, [["expression", '[player] spawn {_this call compile preProcessFileLineNumbers "scripts\commander\tools\descent_select.sqf";}']], "1", "1"],    		    		    		
            ["(separator)",       [11], "", -1, [["expression", ""]], "1", "1"],	// separator line
    		["Выход", [1], "", -3, [["expression", ""]], "1", "1"]
    ];
};

showCommandingMenu "#USER:commandermenu";
