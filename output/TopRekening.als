module TopRekening

open util/ordering[TopRekening]
open util/integer
open types/date
open types/period
open types/frequency
open types/percentage

sig TopRekening {
  amount : one Int,
  opened : one Int 
}

/********************
* EVENTS
********************/

pred TopRekening.openAccount [ old : TopRekening ,inleg : Int]{
  // PRECONDITIONS 
  inleg.gte[100]
  // POSTCONDITIONS 
  this.balance = {this.now->inleg}
  // PROPERTY CONDITIONS 
  this.opened = 1 
  old.opened = 0
  this.amount = old.amount
}



pred TopRekening.withdraw [ old : TopRekening ,amount : Int]{
  // PRECONDITIONS 
  old.balance[old.now].gte[amount] 
  amount.gte[0]
  // POSTCONDITIONS 
  this.balance[this.now] = old.balance[old.now].sub[amount]
  // PROPERTY CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  this.amount = old.amount
}



pred TopRekening.deposit [ old : TopRekening ,amount : Int]{
  // PRECONDITIONS 
  amount.gt[0]
  // POSTCONDITIONS 
  this.balance[this.now] = old.balance[old.now].plus[amount]
  // PROPERTY CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  this.amount = old.amount
}



pred TopRekening.close [ old : TopRekening ]{
  // PRECONDITIONS 
  old.balance[old.now] = 0
  
  // PROPERTY CONDITIONS 
  old.opened = 1 
  this.opened = 0
  this.amount = old.amount
}



/********************
* FUNCTIONS
********************/

fun noPenalty[yearsLeft : Int] : Percentage {
  getPercentage[0]
}

/********************
* FACT
********************/

fact traces {
  all old: TopRekening - last | let new = next[old]{
    first.opened = 0
    some i : Int |  openAccount[new, old, i] or withdraw[new, old, i] or deposit[new, old, i] or close[new, old]
  }
}
/********************
* INVARIANTS
********************/

assert Positive {
  all s: TopRekening  | all d : Date | s.balance[d] >= 0
}
/********************
* COMMANDS
********************/

pred show{} 
run show for 5 TopRekening, exactly 5 Date, 7 Int, exactly 128 Percentage
check Positive for 5 TopRekening, exactly 5 Date, 7 Int, exactly 128 Percentage
