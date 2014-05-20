module lang::functions::alloy::Statements

import lang::savingsaccounts::alloy::Expressions;
import lang::savingsaccounts::alloy::TypesAndLiterals;
import lang::savingsaccounts::alloy::utils::Info;
import lang::functions::\syntax::Statements;
import String;
import IO;

str statement2alloy((Statement) `(<Statement s>)`,VarMap vm) 
	= "( " + statement2alloy(s,vm) + ")";
str statement2alloy((Statement) `<Expr cond> ? <Statement ifStat> : <Statement elseStat>`,VarMap vm) 
	= expr2alloy(cond,vm) + " =\> " + statement2alloy(ifStat,vm) + " else " + statement2alloy(elseStat,vm);

str statement2alloy((Statement) `case <Expr e> { <Case+ cases> };`,VarMap vm){
	list[Case] listCases = ([] | it + c | c <- cases);
	str res = "";
	for(c <- listCases){
		res = expr2alloy(e,vm) + " = <literal2alloy(c.lit,vm)>" + "=\>" + statement2alloy(c.s,vm) + "\nelse " + res;
	}
	res = replaceLast(res,"\nelse ","");
	return res;
}
str statement2alloy((Statement) `sum(<Expr e> | <Var v> \<- <Expr s>);`,VarMap vm) 
	= "(sum <v> : <expr2alloy(s,vm)> | <expr2alloy(e,vm)>)";
str statement2alloy((Statement) `<Expr e>;`,VarMap vm) 
	= expr2alloy(e,vm);

