global runmode is 0. //have runmode recovery here in each file
global mission is import("missionLib.ks").
global event is import("EventLib.ks").

clearscreen.

//Recover state or use default.
mission["recover_state"]().

//main event loop
until false {
	mission["run_file"](states + ".ks").
	wait 0.01.
}