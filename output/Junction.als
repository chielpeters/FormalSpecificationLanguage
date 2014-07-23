module Junction

open util/ordering[Junction]
open util/integer
open TrafficLight

sig Junction {
  left : one TrafficLight,
  right : one TrafficLight,
  opened : one Int 
}

/********************
* EVENTS
********************/

pred Junction.init [ old : Junction ,l : TrafficLight, r : TrafficLight]{
  // PRECONDITIONS 
  l.opened = 1 and r.opened = 1
  // POSTCONDITIONS 
  this.left = l 
  this.right = r 
  amountOfGreens[this.left, this.right] = 0
  // FRAME CONDITIONS 
  this.opened = 1 
  old.opened = 0
  
}



pred Junction.changeJunctionState [ old : Junction ]{
  
  // POSTCONDITIONS 
  this.left = next[old.left] 
  this.right = next[old.right] 
  amountOfGreens[this.left, this.right].lte[1]
  // FRAME CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  
}



/********************
* FUNCTIONS
********************/

fun amountOfGreens[t1 : TrafficLight, t2 : TrafficLight] : Int {
  t1.color.plus[t2.color]
}

/********************
* FACT
********************/

fact traces {
  first. (Junction <: opened) = 0
  all old: Junction - last | let new = next[old]{
    some t : TrafficLight, t1 : TrafficLight |  init[new, old, t, t1] or changeJunctionState[new, old]
  }
}
/********************
* INVARIANTS
********************/

assert No2GreenLights {
  all state : Junction |{ state.opened = 1=>amountOfGreens[state.left, state.right].lte[1] }
}
/********************
* COMMANDS
********************/

run {} for 5 Junction,  25 TrafficLight 
check No2GreenLights for 5 Junction,  25 TrafficLight 
