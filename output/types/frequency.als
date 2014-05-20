module frequency

abstract sig Frequency{}

one sig Yearly extends Frequency{} 
one sig Quarterly extends Frequency{}
one sig Monthly extends Frequency{} 
one sig Daily extends Frequency{} 

fun order : Frequency -> Frequency{
	{
		Yearly -> Quarterly + Yearly -> Monthly + Yearly -> Daily + 
		Quarterly -> Monthly + Quarterly -> Daily + 
		Monthly -> Daily
	}
}


pred eq[f1 : Frequency, f2 : Frequency] { f1 = f2}

pred lt[f1 : Frequency, f2 : Frequency]{
	f2 in order[f1]
}

pred lte[f1 : Frequency, f2 : Frequency]{
	f2 in order[f1] or eq[f1,f2]
}

pred gt[f1 : Frequency, f2 : Frequency]{
	f2 not in order[f1] and eq[f1,f2]
}

pred gte[f1 : Frequency, f2 : Frequency]{
	f2 not in order[f1]
}
