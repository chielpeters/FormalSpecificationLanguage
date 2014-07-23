module TopRekening

open util/ordering[TopRekening]
open util/integer
open types/date
open types/period
open types/frequency
open types/percentage

sig TopRekening {
  balance : Date -> lone Int,
  term : one Int,
  startDate : one Date,
  interestFreq : one Frequency,
  now : one Date,
  opened : one Int 
}

/********************
* EVENTS
********************/

pred TopRekening.openAccount [ old : TopRekening ,inleg : Int]{
  // PRECONDITIONS 
  inleg.gte[50]
  // POSTCONDITIONS 
  this.balance = {this.now->inleg}
  // FRAME CONDITIONS 
  this.opened = 1 
  old.opened = 0
  this.term = old.term
  this.startDate = old.startDate
  this.interestFreq = old.interestFreq
}



pred TopRekening.withdraw [ old : TopRekening ,amount : Int]{
  // PRECONDITIONS 
  old.balance[old.now].gte[amount] 
  amount.gt[0]
  // POSTCONDITIONS 
  this.balance[this.now] = old.balance[old.now].sub[( 1.sub[noPenalty[amount]] ).mul[amount]] 
  this.now = next[old.now] 
  old.balance in this.balance 
  #this.balance = ( #old.balance ).plus[1]
  // FRAME CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  this.term = old.term
  this.startDate = old.startDate
  this.interestFreq = old.interestFreq
}



pred TopRekening.deposit [ old : TopRekening ,amount : Int]{
  // PRECONDITIONS 
  amount.gt[0]
  // POSTCONDITIONS 
  this.balance[this.now] = old.balance[old.now].plus[( 1.sub[noPenalty[amount]] ).mul[amount]] 
  this.now = next[old.now] 
  old.balance in this.balance 
  #this.balance = ( #old.balance ).plus[1]
  // FRAME CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  this.term = old.term
  this.startDate = old.startDate
  this.interestFreq = old.interestFreq
}



pred TopRekening.interest [ old : TopRekening ]{
  // PRECONDITIONS 
  isPayOutDate[old.now, getDate[1,12,0], Yearly]
  // POSTCONDITIONS 
  this.balance[this.now] = old.balance[old.now].plus[interest[100, {0->getPercentage[3]}, this.balance, this.now.sub[Yearly], this.now]] 
  this.now = next[old.now] 
  old.balance in this.balance 
  #this.balance = ( #old.balance ).plus[1]
  // FRAME CONDITIONS 
  old.opened = 1 
  this.opened = old.opened
  this.term = old.term
  this.startDate = old.startDate
  this.interestFreq = old.interestFreq
}



pred TopRekening.close [ old : TopRekening ]{
  // PRECONDITIONS 
  old.balance[old.now] = 0
  
  // FRAME CONDITIONS 
  old.opened = 1 
  this.opened = 0
  this.term = old.term
  this.balance = old.balance
  this.startDate = old.startDate
  this.interestFreq = old.interestFreq
  this.now = old.now
}



/********************
* FUNCTIONS
********************/

pred isPayOutDate[date : Date, payoutdate : Date, freq : Frequency] {
  freq = Yearly=>date.days = payoutdate.days and date.month = payoutdate.month
  else freq = Quarterly=>date.days = payoutdate.days and ( payoutdate.month.sub[date.month] ).rem[3] = 0
  else freq = Monthly=>date.days = payoutdate.days
  else freq = Daily=>{}
}

fun interest[maximum : Int, interestRates : Int -> Percentage, balance : Date -> Int, start : Date, end : Date] : Int {
  (sum date : Filter[start,end] | min[balance[date], maximum].mul[interestRates.get[balance[date]]].div[daysInYear[date]])
}

fun interest[maximum : Int, interestRates : Int -> Percentage, bonusrate : Percentage, balance : Date -> Int, start : Date, end : Date] : Int {
  balance[start].lte[balance[end]] => (sum date : Filter[start,end] | ( min[balance[date], maximum].mul[( interestRates.get[balance[date]].plus[bonusrate] )] ).div[daysInYear[date]]) else interest[maximum, interestRates, balance, start, end]
}

fun noPenalty[yearsLeft : Int] : Percentage {
  getPercentage[0]
}

/********************
* FACT
********************/

fact traces {
  first. (TopRekening <: opened) = 0
  all old: TopRekening - last | let new = next[old]{
    some i : Int |  openAccount[new, old, i] or withdraw[new, old, i] or deposit[new, old, i] or interest[new, old] or close[new, old]
  }
}
/********************
* INVARIANTS
********************/

assert Positive {
  all s : TopRekening |all d : Date |{ s.opened = 1=>s.balance[d].gte[0] }
}
/********************
* COMMANDS
********************/

run {} for 5 TopRekening,  exactly 5 Date, 8 Int, exactly 30 Percentage
check Positive for 5 TopRekening,  exactly 5 Date, 8 Int, exactly 30 Percentage
