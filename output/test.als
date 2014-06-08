module test

open util/ordering[test]
open util/integer
open types/date
open types/period
open types/frequency
open types/percentage

sig test {
  opened : one Int 
}

/********************
* EVENTS
********************/

/********************
* FUNCTIONS
********************/

/********************
* FACT
********************/

fact traces {
  first. (test <: opened) = 0
  all old: test - last | let new = next[old]{
     
  }
}
/********************
* INVARIANTS
********************/

/********************
* COMMANDS
********************/

run {} for 5 test,  exactly 5 Date, 7 Int, exactly 30 Percentage
