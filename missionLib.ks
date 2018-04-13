{
//
 function run_file {
  parameter file.
  runpath(file).
  }.


// Update runmode, persisting to disk
 function set_runmode {
      parameter mode.
      writejson(list(mode), "runmode.json").
      set runmode to mode.
    }.

//reboot tolerance
 function recover_state {
	if core:volume:files:haskey("states.json") {
  	 set states to readjson("states.json")[0]
  	} else set_state(idle).
 }.

 function recover_runmode {
	if core:volume:files:haskey("runmode.json") {
  	 set runmode to readjson("runmode.json")[0].
  	} else set_runmode(1).
 }.

//switch to next runmode
 function next { 
	set_runmode(runmode + 1). 
	}.

//switch to a specific state
 function set_state {
	parameter state.
	set_runmode(1).
	writejson(list(state), "state.json").
	set states to state.
	}.

//switch to a specific runmode
 function switch_to {
	parameter mode.
	set_runmode(mode).
	}.

//+----------------------+
  	export(lex(
	"recover_mode", recover_runmode@,
	"recover_state", recover_state@,	
	"run_file", run_file@,
	"next", next@,
	"set_state", set_state@,
	"switch_to", switch_to@
	)).
}