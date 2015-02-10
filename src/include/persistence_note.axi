
// -----------------------------------------------------------------
// How can persistent data be implemented in an object-oriented way?
// -----------------------------------------------------------------

// One struct for volatile data.
struct oop_projector_t
{
    dev dps;
    char name[255];
}

// Another struct for persistent data.
struct oop_projector_memo_t
{
    integer power_state;
    oop_projector_input_t input; // TODO: This has a mix of persistent and volatile parts.
}

volatile   oop_projector_t      proj_1_v
persistent oop_projector_memo_t proj_1_p

// Instead of taking "self" as an argument, functions take v and p for their
// volatile and persistent structs, respectively.
// 
// p may have to be an empty struct to prevent the function signature from
// changing when the number of persistent properties transitions between 0 and 1.
// 
// The tradeoff for implementing persistence this way is that the v and p
// structs must be passed to every function.
define_function oop_projector_power_on(oop_projector_t v, oop_projector_memo_t p)
{
    do_stuff();
}


// -----------------------------------------------------------------
// Alternative
// -----------------------------------------------------------------

// Global auto-generated memo struct.
struct memo_t
{
    integer proj_1_power_state
    integer proj_1_input_number
    integer proj_2_power_state
    integer proj_2_input_number
}

persistent memo_t memo

// Run on a timeline.
define_function memoize()
{
    memo.proj_1_power_state  = proj_1.power_state
    memo.proj_1_input_number = proj_1.input.number
    memo.proj_2_power_state  = proj_2.power_state
    memo.proj_2_input_number = proj_2.input.number
}

// Put in DEFINE_START
define_function unmemoize()
{
    proj_1.power_state  = memo.proj_1_power_state
    proj_1.input.number = memo.proj_1_input_number
    proj_2.power_state  = memo.proj_2_power_state
    proj_2.input.number = memo.proj_2_input_number
}
