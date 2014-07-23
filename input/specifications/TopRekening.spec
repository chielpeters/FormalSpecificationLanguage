Specification TopRekening

Fields{
	balance 		: Date -> Integer
	term 			: Integer
	startDate		: Date
	interestFreq 	: Freq
	now 			: Date
}


Events{
  openAccount(50)
  withdraw()
  deposit()
  interest((0 : 3%),Yearly,1 Dec,100)
  close()
}

Invariants{
	Positive
}