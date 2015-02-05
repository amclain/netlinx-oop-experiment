# NetLinx Object Oriented Programming Experiment

This is an experiment in designing encapsulated, reusable objects in the NetLinx
programming language.

The concept of simulating objects in a procedural language is by no means new,
and this example borrows a lot from C design patterns. However, although the
NetLinx syntax shares many traits with C, program execution is far less related.
This experiment is an attempt to discover and document ways of designing and
using objects in NetLinx in a way that is compatible with
[model oriented programming](http://download.imatix.com/mop/introduction.html).

## Example Code

Instantiating and controlling two projectors:
```text
oop_projector_t proj_1;
oop_projector_t proj_2;

oop_projector_new(proj_1, 5001:1:0, 'Projector 1');
oop_projector_new(proj_2, 5001:2:0, 'Projector 2');

oop_projector_power_on(proj_1);
oop_projector_power_off(proj_2);

oop_projector_switch_input(proj_1, OOP_PROJECTOR_INPUT_VGA);
```

Console output:
```text
Line      1 (16:46:14):: INFO: oop_projector initialized: Projector 1
Line      3 (16:46:14):: INFO: oop_projector initialized: Projector 2
Line      4 (16:46:14):: INFO: oop_projector warming up: Projector 1
Line      5 (16:46:14):: INFO: oop_projector cooling down: Projector 2
Line      6 (16:46:14):: INFO: oop_projector: Projector 1 set to input: VGA
Line      7 (16:46:19):: INFO: oop_projector warmup complete: Projector 1
Line      8 (16:46:19):: INFO: oop_projector cooldown complete: Projector 2
```

Serial port output:
```text
Line      3 (16:46:14):: String To [5001:1:1]-[(PON)$0D]
Line      4 (16:46:14):: String To [5001:2:1]-[(POF)$0D]
Line      5 (16:46:14):: String To [5001:1:1]-[(IN1)$0D]
```
