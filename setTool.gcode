; change the variable to the require position 

; GET_TOOL_X=100
; PULL_TOOL_X=80
; GET_TOOL_Y=18
; BEFORE_TOOL_PULL_Y=50
; TOOL_CHANGE_SPEED=600


;PULL TOOL FROM CATCHER TO CARRIAGE
g1 x$PULL_TOOL_X y$BEFORE_TOOL_PULL_Y f3000           ; position before binding to tool
g1 x$PULL_TOOL_X y$GET_TOOL_Y F$TOOL_CHANGE_SPEED     ; binding to tool
g1 x$GET_TOOL_X y$GET_TOOL_Y F$TOOL_CHANGE_SPEED    ; pulling to tool

g1 x150 y150 F3000

;SET THE TOOL ON CATCHER 
g1 x$GET_TOOL_X y$GET_TOOL_Y f3000                   ; position before setting the tool
g1 x$PULL_TOOL_X y$GET_TOOL_Y F$TOOL_CHANGE_SPEED      ; setting the tool
g1 x$PULL_TOOL_X y$BEFORE_TOOL_PULL_Y F$TOOL_CHANGE_SPEED      ; setting the tool
