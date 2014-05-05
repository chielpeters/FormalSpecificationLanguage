module alloy::Expressions

import grammar::Expressions;
import alloy::VarMap;
import alloy::TypesAndLiterals;
import String;

str expression2alloy((Expr) `(<Expr e>)`,VarMap vm) = "( " + expression2alloy(e,vm) + " )";
//TODO Change to accept both properties
str expression2alloy((Expr) `<PropertyOfVar p>`,VarMap vm) = "<p>";
str expression2alloy((Expr) `old <PropertyOfVar p>`,VarMap vm) = "<p>";
str expression2alloy((Expr) `<Var v>`,VarMap vm){
	if(v in vm) return expression2alloy(vm[v],vm); else return "<v>";
}
str expression2alloy((Expr) `<Literal l>`,VarMap vm) = literal2alloy(l);
str expression2alloy((Expr) `{ <Expr lhs> ... <Expr rhs> }`,VarMap vm) = "Filter[<expression2alloy(lhs,vm)>,<expression2alloy(rhs,vm)>]";
str expression2alloy((Expr) `<FunctionName name> [ <{Expr ","}* expressions> ]`,VarMap vm){
	str res =  "<name>";
 	res += ( "[" | it +  expression2alloy(exp,vm) + "," | exp <- expressions) + "]";
  	res = replaceLast(res,",","");
  	return res;
}
str expression2alloy((Expr) `! <Expr e>`,VarMap vm) = "!" + expression2alloy(e,vm);
str expression2alloy((Expr) `<Expr lhs> * <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".mul["  + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> / <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".div[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> % <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".rem[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> + <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".plus[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> - <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".sub[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> \< <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " \< " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> \<= <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " \<= " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> \> <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " \> " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> \>= <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " \>= " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> == <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " = " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> != <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " != " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> && <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " && " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> || <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " || " + expression2alloy(rhs,vm);
