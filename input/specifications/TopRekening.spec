import test

Specification TopRekening extends test

Fields{
	balance 		: Date -> Integer
	term 			: Integer
	startDate		: Date
	interestFreq 	: Freq
	now 			: Date
	owner			: test
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