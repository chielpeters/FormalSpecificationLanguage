module alloy::Expressions

import grammar::Expressions;
import alloy::Literals;
import String;


str expression2alloy((Expr) `{ <Expr lhs> ... <Expr rhs> }`){
	return "Filter[<expression2alloy(lhs)>,<expression2alloy(rhs)>]";
}

str expression2alloy((Expr) `<FunctionName name> [ <{Expr ","}* expressions> ]`){
	str res =  "<name>";
 	res += ( "[" | it +  expression2alloy(exp) + "," | exp <- expressions) + "]";
  	res = replaceLast(res,",","");
  	return res;
}

str expression2alloy((Expr) `(<Expr e>)`){
  	return "( " + expression2alloy(e) + " )";
}

str expression2alloy((Expr) `<Literal l>`){
  	return literal2alloy(l);
}

str expression2alloy((Expr) `<Var v>`){
  	return  "<v>";
}

str expression2alloy((Expr) `<Var v>`){
  	return  "<v>";
}

//TODO Change to accept both properties
str expression2alloy((Expr) `<PropertyOfVar p>`){
  	return "<p>";
}

str expression2alloy((Expr) `! <Expr e>`){
  	return  "!" + expression2alloy(e);
}

str expression2alloy((Expr) `<Expr lhs> * <Expr rhs>`){
  	return expression2alloy(lhs) + ".mul["  + expression2alloy(rhs) + "]";
}

str expression2alloy((Expr) `<Expr lhs> / <Expr rhs>`){
  	return expression2alloy(lhs) + ".div[" + expression2alloy(rhs) + "]";
}

str expression2alloy((Expr) `<Expr lhs> % <Expr rhs>`){
 	return expression2alloy(lhs) + ".rem[" + expression2alloy(rhs) + "]";
}

str expression2alloy((Expr) `<Expr lhs> + <Expr rhs>`){
  	return expression2alloy(lhs) + " + " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> - <Expr rhs>`){
  	return expression2alloy(lhs) + " - " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> \< <Expr rhs>`){
  	return expression2alloy(lhs) + " \< " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> \<= <Expr rhs>`){
  	return expression2alloy(lhs) + " \<= " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> \> <Expr rhs>`){
  	return expression2alloy(lhs) + " \> " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> \>= <Expr rhs>`){
  	return expression2alloy(lhs) + " \>= " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> == <Expr rhs>`){
  	return expression2alloy(lhs) + " = " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> != <Expr rhs>`){
  	return expression2alloy(lhs) + " != " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> && <Expr rhs>`){
  	return expression2alloy(lhs) + " && " + expression2alloy(rhs);
}

str expression2alloy((Expr) `<Expr lhs> || <Expr rhs>`){
  	return expression2alloy(lhs) + " || " + expression2alloy(rhs);
}

str isFunctionBoolean(Expr e){
	if((Expr) `<FunctionName name> [ <{Expr ","}* expressions> ]` := e){
  		return " in {True}";
	}
	return "";
}

