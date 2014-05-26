module TopRekening

open util/ordering[SavingsAccount]
open util/integer
open types/date
open types/period
open types/frequency
open types/percentage

sig SavingsAccount {
  balance : Date -> lone Int,
  term  : one Int,
  startDate : one Date,
  payoutfreq: one Frequency,
  opened : lone Int,
  now : one Date
}{
  opened in {0+1}
}

/********************
* EVENTS
********************/

pred SavingsAccount.openAccount [ s : SavingsAccount ,inleg : Int]{
  // PRECONDITIONS 
  inleg.gte[0]
  // POSTCONDITIONS 
  this.balance = {this.now->inleg}
  // PROPERTY CONDITIONS 
  this.opened = 1 
  s.opened = 0
  this.term = s.term
  this.startDate = s.startDate
  this.payoutfreq = s.payoutfreq
}



pred SavingsAccount.withdraw [ s : SavingsAccount ,amount : Int]{
  // PRECONDITIONS 
  s.balance[s.now].gte[amount] 
  amount.gte[0]
  // POSTCONDITIONS 
  this.balance[this.now] = s.balance[s.now].sub[amount]
  // PROPERTY CONDITIONS 
  s.opened = 1 
  this.opened = s.opened
  this.term = s.term
  this.startDate = s.startDate
  this.payoutfreq = s.payoutfreq
}



pred SavingsAccount.deposit [ s : SavingsAccount ,amount : Int]{
  // PRECONDITIONS 
  amount.gt[0]
  // POSTCONDITIONS 
  this.balance[this.now] = s.balance[s.now].plus[amount]
  // PROPERTY CONDITIONS 
  s.opened = 1 
  this.opened = s.opened
  this.term = s.term
  this.startDate = s.startDate
  this.payoutfreq = s.payoutfreq
}



pred SavingsAccount.close [ s : SavingsAccount ]{
  
  // POSTCONDITIONS 
  close_withdraw[this,s,this.balance[this.now]]
  // PROPERTY CONDITIONS 
  s.opened = 1 
  this.opened = 0
  this.term = s.term
  this.startDate = s.startDate
  this.payoutfreq = s.payoutfreq
}

pred SavingsAccount.close_withdraw [ s : SavingsAccount ,amount : Int]{
  // PRECONDITIONS 
  s.balance[s.now].gte[amount] 
  amount.gte[0]
  // POSTCONDITIONS 
  this.balance[this.now] = s.balance[s.now].sub[amount]
  // PROPERTY CONDITIONS 
  this.term = s.term
  this.startDate = s.startDate
  this.payoutfreq = s.payoutfreq
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
  all old: SavingsAccount - last | let new = next[old]{
    advance[old.now,new.now]
    old.balance in new.balance && #new.balance = add[#old.balance,1]
    first.opened = 0
    some i : Int |  openAccount[new, old, i] or withdraw[new, old, i] or deposit[new, old, i] or close[new, old]
  }
}
/********************
* INVARIANTS
********************/

assert Positive {
  all s: SavingsAccount  | all d : Date | s.balance[d] >= 0
}
/********************
* COMMANDS
********************/

pred show{} 
run show for 5 SavingsAccount, exactly 5 Date, 7 Int, exactly 128 Percentage
check Positive for 5 SavingsAccount, exactly 5 Date, 7 Int, exactly 128 Percentage
