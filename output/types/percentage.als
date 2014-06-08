module percentage

open util/integer


sig Percentage{
 percent : Int
}


fun lowestViablePercentage[ amount : Int] : Int{
 min[{i :Int | amount.mul[i].div[100] > 0 && i >0}]
}


fun getPercentage[Npercent : Int] : Percentage{
 {p : Percentage | p.percent = Npercent}
}

fun Filter[start : Percentage, end : Percentage] : Percentage{
 { p : Percentage | lte[start,p] and gte[end,p] }
}

fun mul[p : Percentage, x : Int] : Percentage {getPercentage[p.percent.mul[x]]}
fun mul[x : Int,p : Percentage] : Int {p.percent.div[lowestViablePercentage[x]].mul[x.mul[lowestViablePercentage[x]].div[100]]}
fun mul[p1 : Percentage, p2 : Percentage] : Percentage { getPercentage[p1.percent.mul[p2.percent].div[100]]}



fun plus[x : Int, p : Percentage] : Percentage { getPercentage[x.mul[100].plus[p.percent]]} 
fun plus[p : Percentage,x : Int] : Percentage { getPercentage[p.percent.plus[x.mul[100]]]} 
fun plus[p1 : Percentage, p2 : Percentage] : Percentage { getPercentage[p1.percent.plus[p2.percent]]} 


fun sub[x : Int, p : Percentage] : Percentage { getPercentage[x.mul[100].sub[p.percent]]} 
fun sub[p : Percentage,x : Int] : Percentage { getPercentage[p.percent.sub[x.mul[100]]]} 
fun sub[p1 : Percentage, p2 : Percentage] : Percentage { getPercentage[p1.percent.plus[p2.percent]]} 


pred lt[p1 : Percentage, p2 : Percentage]{ p1.percent < p2.percent}
pred lte[p1 : Percentage, p2 : Percentage]{ p1.percent <= p2.percent}
pred gt[p1 : Percentage, p2 : Percentage]{ p1.percent > p2.percent}
pred gte[p1 : Percentage, p2 : Percentage]{ p1.percent >= p2.percent}
pred eq[p1 : Percentage, p2 : Percentage]{ p1.percent = p2.percent}
pred neq[p1 : Percentage, p2 : Percentage]{ p1.percent != p2.percent}

fun min[p1 : Percentage, p2 : Percentage] : Percentage{ lte[p1,p2] => p1 else p2}
fun min[int1 : Int, int2:Int] : Int { int1 < int2 => int1 else int2}
fun max[p1 : Percentage, p2 : Percentage] : Percentage{ gte[p1,p2] => p1 else p2}
fun max[int1 : Int, int2:Int] : Int { int1 < int2 => int2 else int1}

fun find( int2percentage : Int -> Percentage, value : Int) : Percentage{
	max[{prevs[value] + value} & ({int2percentage}.univ)].int2percentage
}


fact Percentages{
 all i : {i: Int | i.gt[10] and i.lt[10]} | one p : Percentage | i = p.percent 
}

pred show{}

run show{} for 20 Int,exactly 64 Percentage

