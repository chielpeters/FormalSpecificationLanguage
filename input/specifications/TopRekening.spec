Specification TopRekening

Fields{
	balance 		: Date -> Integer
	term 			: Integer
	startDate		: Date
	interestFreq 	: Freq
	now 			: Date
}

Events{
  openAccount()
  withdraw()
  deposit()
  close()
}

Invariants{
	Positive
}