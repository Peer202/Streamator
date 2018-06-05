#include "macros.hpp"
/*
    Streamator

    Author: BadGuy

    Description:
    MouseMoving event handler for the spectator

    Parameter(s):
    0: Display <Display> (Default: displayNull)
    1: DeltaX <Number> (Default: 0)
    2: DeltaY <Number> (Default: 0)

    Returns:
    None
*/
params [
    "",
    ["_deltaX", 0, [0]],
    ["_deltaY", 0, [0]]
];

if (GVAR(InputMode) == 2) then {
    if (GVAR(PlanningModeDrawing)) then {
        [CLib_Player, QGVAR(cursorPosition), [serverTime, screenToWorld getMousePosition], 0.03] call CFUNC(setVariablePublic);
    };
} else {
    private _fov_factor = (GVAR(CameraPreviousState) param [4, GVAR(CameraFOV)]) / 0.75;
    private _dir = GVAR(CameraPreviousState) param [2, GVAR(CameraDir)];

    GVAR(CameraDir) = GVAR(CameraDir) + _deltaX * 0.5 * _fov_factor;
    GVAR(CameraPitch) = -89.0 max (89.9 min (GVAR(CameraPitch) - _deltaY * _fov_factor));

    GVAR(CameraDir) = ((((GVAR(CameraDir) - _dir) mod 360) min 90) max - 90) + _dir;
};
