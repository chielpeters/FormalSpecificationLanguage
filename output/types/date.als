module date

open util/integer
open util/ordering[Date]
open period
open frequency

sig Date{
  days : Int,
  month : Int,
  year : Int
}{
 days > 0 and month > 0 and year > 0
}

fact noIllegalDate{
  all d : Date | 
	isLeapYear[d] => !(d.days > d.month.daysInMonthLeap) && d.month <= 12
	else !(d.days > d.month.daysInMonth) && d.month <= 12
}

fact nodups{
 all d : Date | no d1 : {Date -d} | d = d1
}

fun getDate[Ndays : Int, Nmonth : Int, Nyear : Int] : Date{
 { d : Date | d.days = Ndays and d.month = Nmonth and d.year = Nyear}
}

fun get[map : Date -> Int, d : Date] : Int{
	max[{prevs[d] + d}& (map.univ)].map
}

fun Filter[start : Date,end : Date] : set Date {
 { d : Date | lte[d,end] and gte[d,start]} 
}

fun sub[d: Date, f : Frequency] : Date {
	f = Yearly => sub[d,Year,1] else
	f = Quarterly => sub[d,Quarter,1] else
	f = Monthly => sub[d,Month,1] else
	sub[d,Day,1]
}

fun sub[d : Date, p : Period, amount : Int] : Date{
	p = Year => {d1 : Date | advanceYears[d1,amount] = d} else
	p = Quarter => {d1 : Date | advanceMonths[d1,amount.mul[3]] = d} else
	p = Month => {d1 : Date | advanceMonths[d1,amount] = d} else
	{d1 : Date | advanceDays[d1,amount] = d}
}


fun plus[d: Date, f : Frequency] : Date {
	f = Yearly => plus[d,Year,1] else
	f = Quarterly => plus[d,Quarter,1] else
	f = Monthly => plus[d,Month,1] else
	plus[d,Day,1]
}

fun plus[d : Date,p : Period, amount : Int] : Date{
	p = Year => advanceYears[d,amount] else
	p = Quarter => advanceMonths[d,amount.mul[3]] else
	p = Month => advanceMonths[d,amount] else
	advanceDays[d,amount]
}
/*
pred lt[d1 : Date, d2 : Date]{
  d1.year != d2.year => d1.year < d2.year 
  else d1.month != d2.month => d1.month < d2.month
  else d1.days < d2.days
}

pred lte[d1 : Date, d2 : Date]{
  d1.year != d2.year => d1.year <= d2.year 
  else d1.month != d2.month => d1.month <= d2.month
  else d1.days <= d2.days
}

pred gt[d1 : Date, d2 : Date]{
  d1.year != d2.year => d1.year > d2.year 
  else d1.month != d2.month => d1.month > d2.month
  else d1.days > d2.days
}

pred gte[d1 : Date, d2 : Date]{
  d1.year != d2.year => d1.year >= d2.year 
  else d1.month != d2.month => d1.month >= d2.month
  else d1.days >= d2.days
}
*/
/*
pred eq[d1 : Date, d2 : Date]{
	d1.year = d2.year and d1.month = d2.month and d1.days = d2.days
}

pred neq[d1 : Date, d2 : Date]{
  !eq[d1,d2]
}
*/
pred isLeapYear[d : Date]{
  (rem[d.year,4] = 0 and rem[d.year,400] = 0) or (rem[d.year,4] = 0 and rem[d.year,100] != 0) 
} 

fun daysInYear[d:Date] : Int {isLeapYear[d] => (sum i : Int.daysInMonthLeap | i) else sum i : Int.daysInMonth| i}

pred setDate[d: Date,Ndays: Int, Nmonth : Int, Nyear : Int]{
 d.days = Ndays and d.month = Nmonth and d.year = Nyear
}

pred advance[d : Date, d': Date]{
	let dayAmount = d.days.add[1], daysInMonth = isLeapYear[d] => d.month.daysInMonthLeap else d.month.daysInMonth | (
		dayAmount > daysInMonth and d.month = 12 => setDate[d',dayAmount.rem[daysInMonth],1,d.year.add[1]]
		else dayAmount>  daysInMonth => setDate[d',dayAmount.rem[daysInMonth],d.month.add[1],d.year]
		else setDate[d',dayAmount,d.month,d.year])
}

fun advanceDays[d : Date, amount : Int] : Date{
	let dayAmount = d.days.add[amount], daysInMonth = isLeapYear[d] => d.month.daysInMonthLeap else d.month.daysInMonth | (
		dayAmount > daysInMonth and d.month = 12 => getDate[dayAmount.rem[daysInMonth],1,d.year.add[1]]
		else dayAmount>  daysInMonth => getDate[dayAmount.rem[daysInMonth],d.month.add[1],d.year]
		else getDate[dayAmount,d.month,d.year])
}

fun advanceMonths[d : Date, amount : Int] : Date{
	let NMonth = d.month.add[amount],
	newMonth = 	NMonth > 12 => NMonth.rem[12] else NMonth,
	daysInNewMonth = NMonth > 12 => (isLeapYear[getDate[1,1,d.year.add[1]]] => newMonth.daysInMonthLeap else newMonth.daysInMonthLeap) else  (isLeapYear[d] => newMonth.daysInMonthLeap else newMonth.daysInMonthLeap) |
	  	NMonth > 12 && d.days > daysInNewMonth => getDate[d.days.rem[daysInNewMonth],newMonth.add[1],d.year.add[1]] else
		NMonth > 12 => getDate[d.days,newMonth,d.year.add[1]] else
		d.days > daysInNewMonth => getDate[d.days.rem[daysInNewMonth],newMonth,d.year] else
		getDate[d.days,newMonth,d.year]
}

fun advanceYears[d : Date, amount : Int] : Date{
	let newYear = d.year.add[amount] |
	 	isLeapYear[d] && !isLeapYear[getDate[d.days,d.month,newYear]] && d.days = 29 && d.month = 2 => getDate[1,3,newYear] else getDate[d.days,d.month,newYear]
}

fun daysInMonth : Int-> Int{
 1 -> 31 +
 2 -> 28 +
 3 -> 31 +
 4 -> 30 +
 5 -> 31 +
 6 -> 30 +
 7 -> 31 +
 8 -> 31 +
 9 -> 30 +
 10 -> 31 +
 11 -> 30 +
 12 -> 31
}

fun daysInMonthLeap : Int-> Int{
 1 -> 31 +
 2 -> 29 +
 3 -> 31 +
 4 -> 30 +
 5 -> 31 +
 6 -> 30 +
 7 -> 31 +
 8 -> 31 +
 9 -> 30 +
 10 -> 31 +
 11 -> 30 +
 12 -> 31
}

pred init[d : Date]{
	d.days = 1
    d.month = 1
    d.year = 1
}

fact{
 init[first]
 all d: Date - last | let d' = next[d] | advance[d,d']
}


pred show{}

run show for 6 Int, exactly 2 Date

