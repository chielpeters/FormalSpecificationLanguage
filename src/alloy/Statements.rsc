module alloy::Statements

import alloy::Expressions;
import alloy::TypesAndLiterals;
import alloy::VarMap;
import grammar::Statements;
import String;


str statement2alloy((Statement) `(<Statement s>)`,VarMap vm) 
	= "( " + statement2alloy(s,vm) + ")";
str statement2alloy((Statement) `<Expr cond> ? <Statement ifStat> : <Statement elseStat>`,VarMap vm) 
	= expression2alloy(cond,vm) + " =\> " + statement2alloy(ifStat,vm) + " else " + statement2alloy(elseStat,vm);

str statement2alloy((Statement) `case <Expr e> { <Case+ cases> };`,VarMap vm){
	list[Case] listCases = ([] | it + c | c <- cases);
	str res = "";
	for(c <- listCases){
		res = expression2alloy(e,vm) + ".eq[<literal2alloy(c.lit)>]" + "=\>" + statement2alloy(c.s,vm) + "\n else " + res;
	}
	res = replaceLast(res,"\n else ","");
	return res;
}
str statement2alloy((Statement) `sum(<Expr e> | <Var v> \<- <Expr s>);`,VarMap vm) 
	= "sum <v> : <expression2alloy(s,vm)> | <expression2alloy(e,vm)>";
str statement2alloy((Statement) `<Expr e>;`,VarMap vm) 
	= expression2alloy(e,vm);

