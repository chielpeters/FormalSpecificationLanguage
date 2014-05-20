module period

abstract sig Period{}

one sig Year extends Period{} 
one sig Quarter extends Period{} 
one sig Month extends Period{}
one sig Day extends Period{}

pred isYear[p : Period]{p = Year}
pred isQuarter[p : Period]{p = Quarter}
pred isMonth[p : Period]{p = Month}
pred isDay[p : Period]{p = Day}
