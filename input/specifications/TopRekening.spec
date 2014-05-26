Specification TopRekening

Fields{
	amount : Integer
}

Events{
  openAccount(1000)
  withdraw()
  deposit()
  close()
}

Invariants{
	Positive
}