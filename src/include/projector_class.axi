(***********************************************************
    NetLinx Object Oriented Programming Experiment
    
    Projector Class
************************************************************)

#if_not_defined OOP_PROJECTOR
#define OOP_PROJECTOR 1
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(*                    INCLUDES GO BELOW                    *)
(***********************************************************)

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

struct oop_projector_input_t
{
    integer number;
    char name[64];
}

struct oop_projector_t
{
    dev dps;
    char name[255];
    integer power_state;
    oop_projector_input_t input;
}

(***********************************************************)
(*              CONSTANT DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_CONSTANT

OOP_PROJECTOR_POWER_STATE_OFF     = 0;
OOP_PROJECTOR_POWER_STATE_ON      = 1;
OOP_PROJECTOR_POWER_STATE_WARMING = 2;
OOP_PROJECTOR_POWER_STATE_COOLING = 3;

// TODO: Assign input number=>name.
oop_projector_input_t OOP_PROJECTOR_INPUT_HDMI      = { 0, 'HDMI' };
oop_projector_input_t OOP_PROJECTOR_INPUT_VGA       = { 1, 'VGA' };
oop_projector_input_t OOP_PROJECTOR_INPUT_COMPOSITE = { 2, 'Composite' };
oop_projector_input_t OOP_PROJECTOR_INPUT_SVIDEO    = { 3, 'SVideo' };

(***********************************************************)
(*         SUBROUTINE/FUNCTION DEFINITIONS GO BELOW        *)
(***********************************************************)

define_function oop_projector_new(oop_projector_t self, dev dps, char name[])
{
    self.dps = dps;
    self.name = name;
    self.power_state = OOP_PROJECTOR_POWER_STATE_OFF;
    self.input = OOP_PROJECTOR_INPUT_HDMI;
    
    print(LOG_LEVEL_INFO, "'oop_projector initialized: ', self.name");
}

define_function integer oop_projector_get_power_state(oop_projector_t self)
{
    return self.power_state;
}

define_function oop_projector_get_input(oop_projector_t self, oop_projector_input_t ret)
{
    ret = self.input;
}

define_function oop_projector_power_on(oop_projector_t self)
{
    self.power_state = OOP_PROJECTOR_POWER_STATE_WARMING;
    send_string self.dps, "'(PON)', $0D";
    print(LOG_LEVEL_INFO, "'oop_projector warming up: ', self.name");
    
    wait 50 {
        self.power_state = OOP_PROJECTOR_POWER_STATE_ON;
        print(LOG_LEVEL_INFO, "'oop_projector warmup complete: ', self.name");
    }
}

define_function oop_projector_power_off(oop_projector_t self)
{
    self.power_state = OOP_PROJECTOR_POWER_STATE_COOLING;
    send_string self.dps, "'(POF)', $0D";
    print(LOG_LEVEL_INFO, "'oop_projector cooling down: ', self.name");
    
    wait 50 {
        self.power_state = OOP_PROJECTOR_POWER_STATE_OFF;
        print(LOG_LEVEL_INFO, "'oop_projector cooldown complete: ', self.name");
    }
}

define_function oop_projector_switch_input(oop_projector_t self, oop_projector_input_t input)
{
    self.input = input;
    send_string self.dps, "'(IN', itoa(self.input.number), ')', $0D";
    print(LOG_LEVEL_INFO, "'oop_projector: ', self.name,
        ' set to input: ', self.input.name");
}

(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*          DO NOT PUT ANY CODE BELOW THIS COMMENT         *)
(***********************************************************)
#end_if
