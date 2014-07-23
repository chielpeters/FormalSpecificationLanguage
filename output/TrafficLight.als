module TrafficLight

open util/ordering[TrafficLight]
open util/integer

sig TrafficLight {
  color : one Int,
  opened : one Int 
}

/********************
* EVENTS
********************/

pred TrafficLight.initTrafficLight [ old : TrafficLight ]{
  
  // POSTCONDITIONS 
  this.color = 0
  // FRAME CONDITIONS 
  this.opened = 1 
  old.opened = 0
  
}



pred TrafficLight.sameColor [ old : TrafficLight ]{
  
  
  // FRAME CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  this.color = old.color
}



pred TrafficLight.changeColor [ old : TrafficLight ]{
  
  // POSTCONDITIONS 
  this.color = changeColor[old.color]
  // FRAME CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  
}



/********************
* FUNCTIONS
********************/

fun changeColor[color : Int] : Int {
  color = 1 => 0 else 1
}

/********************
* FACT
********************/

fact traces {
  first. (TrafficLight <: opened) = 0
  all old: TrafficLight - last | let new = next[old]{
     initTrafficLight[new, old] or sameColor[new, old] or changeColor[new, old]
  }
}
/********************
* INVARIANTS
********************/

/********************
* COMMANDS
********************/

run {} for 5 TrafficLight
