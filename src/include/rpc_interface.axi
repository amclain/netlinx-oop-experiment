(***********************************************************
    NetLinx Object Oriented Programming Experiment
    
    RPC Interface
************************************************************)

#if_not_defined OOP_RPC_INTERFACE
#define OOP_RPC_INTERFACE 1
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(*           DEVICE NUMBER DEFINITIONS GO BELOW            *)
(***********************************************************)
DEFINE_DEVICE

dvRPC    = 34500:1:0;

dvPROJ_1 = 5001:1:0;
dvPROJ_2 = 5001:2:0;

(***********************************************************)
(*              CONSTANT DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*                    INCLUDES GO BELOW                    *)
(***********************************************************)

#include 'projector_class'

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*              VARIABLE DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_VARIABLE

volatile oop_projector_t proj_1;
volatile oop_projector_t proj_2;

(***********************************************************)
(*         SUBROUTINE/FUNCTION DEFINITIONS GO BELOW        *)
(***********************************************************)

(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                   THE EVENTS GO BELOW                   *)
(***********************************************************)
DEFINE_EVENT

data_event[dvRPC]
{
    string:
    {
        oop_projector_new(proj_1, dvPROJ_1, 'Projector 1');
        oop_projector_new(proj_2, dvPROJ_2, 'Projector 2');
        
        oop_projector_power_on(proj_1);
        oop_projector_power_off(proj_2);
        
        oop_projector_switch_input(proj_1, OOP_PROJECTOR_INPUT_VGA);
    }
    
    command: {}
    online:  {}
    offline: {}
}

// data_event[proj_1.dps] // Doesn't work. Have to define a device.
data_event[dvPROJ_1]
{
    string: { oop_projector_string_event(proj_1, data.text) }
    
    command: {}
    online:  {}
    offline: {}
}

data_event[dvPROJ_2]
{
    string: { oop_projector_string_event(proj_2, data.text) }
    
    command: {}
    online:  {}
    offline: {}
}

(***********************************************************)
(*                 THE MAINLINE GOES BELOW                 *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*          DO NOT PUT ANY CODE BELOW THIS COMMENT         *)
(***********************************************************)
#end_if
