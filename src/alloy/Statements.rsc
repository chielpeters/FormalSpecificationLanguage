module alloy::Statements

import alloy::Expressions;
import alloy::Literals;
import grammar::Statements;
import String;


str statement2alloy((Statement) `case <Expr e> { <Case+ cases> };`){
	list[Case] listCases = ([] | it + c | c <- cases);
	str res = "";
	for(c <- listCases){
		res = expression2alloy(e) + ".eq[<literal2alloy(c.lit)>]" + "=\>" + statement2alloy(c.s) + "\n else " + res;
	}
	res = replaceLast(res,"\n else ","");
	return res;
}

str statement2alloy((Statement) `sum(<Expr e> | <Var v> \<- <Expr s>);`){
	return "sum <v> : <expression2alloy(s)> | <expression2alloy(e)>"; 
}

str statement2alloy((Statement) `<Expr cond> ? <Statement ifStat> : <Statement elseStat>`){
	return parseconditional(cond,ifStat,elseStat);
}

str statement2alloy((Statement) `(<Statement s>)`){
	return "( " + statement2alloy(s) + ")";
}

str statement2alloy((Statement) `<Expr e>;`){
	return expression2alloy(e);
}

str parseconditional(Expr cond, Statement ifStat, Statement elseStat){
	return expression2alloy(cond) + isFunctionBoolean(cond) + " =\> " + statement2alloy(ifStat) + " else " + statement2alloy(elseStat);
}