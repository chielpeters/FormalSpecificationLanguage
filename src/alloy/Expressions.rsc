module alloy::Expressions

import grammar::Expressions;
import alloy::TypesAndLiterals;
import String;

str expression2alloy((Expr) `(<Expr e>)`) = "( " + expression2alloy(e) + " )";
//TODO Change to accept both properties
str expression2alloy((Expr) `<PropertyOfVar p>`) = "<p>";
str expression2alloy((Expr) `<Var v>`) = "<v>";
str expression2alloy((Expr) `<Literal l>`) = literal2alloy(l);
str expression2alloy((Expr) `{ <Expr lhs> ... <Expr rhs> }`) = "Filter[<expression2alloy(lhs)>,<expression2alloy(rhs)>]";
str expression2alloy((Expr) `<FunctionName name> [ <{Expr ","}* expressions> ]`){
	str res =  "<name>";
 	res += ( "[" | it +  expression2alloy(exp) + "," | exp <- expressions) + "]";
  	res = replaceLast(res,",","");
  	return res;
}
str expression2alloy((Expr) `! <Expr e>`) = "!" + expression2alloy(e);
str expression2alloy((Expr) `<Expr lhs> * <Expr rhs>`) = expression2alloy(lhs) + ".mul["  + expression2alloy(rhs) + "]";
str expression2alloy((Expr) `<Expr lhs> / <Expr rhs>`) = expression2alloy(lhs) + ".div[" + expression2alloy(rhs) + "]";
str expression2alloy((Expr) `<Expr lhs> % <Expr rhs>`) = expression2alloy(lhs) + ".rem[" + expression2alloy(rhs) + "]";
str expression2alloy((Expr) `<Expr lhs> + <Expr rhs>`) = expression2alloy(lhs) + ".plus[" + expression2alloy(rhs) + "]";
str expression2alloy((Expr) `<Expr lhs> - <Expr rhs>`) = expression2alloy(lhs) + ".sub[" + expression2alloy(rhs) + "]";
str expression2alloy((Expr) `<Expr lhs> \< <Expr rhs>`) = expression2alloy(lhs) + " \< " + expression2alloy(rhs);
str expression2alloy((Expr) `<Expr lhs> \<= <Expr rhs>`) = expression2alloy(lhs) + " \<= " + expression2alloy(rhs);
str expression2alloy((Expr) `<Expr lhs> \> <Expr rhs>`) = expression2alloy(lhs) + " \> " + expression2alloy(rhs);
str expression2alloy((Expr) `<Expr lhs> \>= <Expr rhs>`) = expression2alloy(lhs) + " \>= " + expression2alloy(rhs);
str expression2alloy((Expr) `<Expr lhs> == <Expr rhs>`) = expression2alloy(lhs) + " = " + expression2alloy(rhs);
str expression2alloy((Expr) `<Expr lhs> != <Expr rhs>`) = expression2alloy(lhs) + " != " + expression2alloy(rhs);
str expression2alloy((Expr) `<Expr lhs> && <Expr rhs>`) = expression2alloy(lhs) + " && " + expression2alloy(rhs);
str expression2alloy((Expr) `<Expr lhs> || <Expr rhs>`) = expression2alloy(lhs) + " || " + expression2alloy(rhs);
