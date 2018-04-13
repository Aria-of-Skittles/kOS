{
local lib is import("Library.ks").

 if runmode = 0 { // Is only used during startup of main.ks or a reboot  
	lib["initialize"](ascent).
	mission["recover_runmode"]().
	}

 else if runmode = 1 {     
	set TVAL to 1.
	SAS on.
	if verticalspeed > 70 { 
		SAS off. 
	  	mission["next"](). 
		}
	}

 else if runmode = 2 {     
	set TVAL to 1.
	local tPitch is max(5, 90 * (1 - ALT:RADAR / 45000)).
	set steering to heading(90,tPitch).
	if ship:apoapsis > targetApoapsis {
		mission["set_state"](circularize).
		}
	if verticalspeed < 1 or ship:PITCH > 90 {
		mission["set_state"](abort).
		}
	}

 event["burnout"](true).
 event["reports"]().
}