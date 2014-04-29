module alloy::Statements

import alloy::Expressions;
import grammar::Statements;

str statement2alloy((Statement) `<Expr cond> ? <Statement ifStat> : <Statement elseStat>`){
	return expression2alloy(cond) + isFunctionBoolean(cond) + " =\> " + statement2alloy(ifStat) + " else " + statement2alloy(elseStat);
}

str statement2alloy((Statement) `(<Statement s>)`){
	return "( " + statement2alloy(s) + ")";
}

str statement2alloy((Statement) `<Expr e>;`){
	return expression2alloy(e);
}