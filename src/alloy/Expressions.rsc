module alloy::Expressions

import grammar::Expressions;
import alloy::VarMap;
import alloy::TypesAndLiterals;
import String;

str expression2alloy((Expr) `(<Expr e>)`,VarMap vm) = "( " + expression2alloy(e,vm) + " )";
//TODO Change to accept both properties
str expression2alloy((Expr) `<PropertyOfVar v>`,VarMap vm){
	if(v.var in vm) return expression2alloy(vm[v.var],vm) + ".<f>"; else return "<v>";
}
str expression2alloy((Expr) `old <PropertyOfVar p>`,VarMap vm){
	if((PropertyOfVar)`this. <Field f>` := p) return "s.<f>" ;
	if((PropertyOfVar)`this. <Field f> [<ExprList el>]` := p) return "s.<f>[<exprlist2alloy(el,vm)>]";
	return "<p>"; 
}
str expression2alloy((Expr) `<Literal l>`,VarMap vm) = literal2alloy(l,vm);
str expression2alloy((Expr) `{ <Expr lhs> ... <Expr rhs> }`,VarMap vm) = "Filter[<expression2alloy(lhs,vm)>,<expression2alloy(rhs,vm)>]";
str expression2alloy((Expr) `<FunctionName name> [ <ExprList expressions> ]`,VarMap vm) = "<name>[<exprlist2alloy(expressions,vm)>]";
str expression2alloy((Expr) `! <Expr e>`,VarMap vm) = "!" + expression2alloy(e,vm);
str expression2alloy((Expr) `<Expr lhs> in <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " in "  + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> * <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".mul["  + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> / <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".div[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> % <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".rem[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> + <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".plus[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> - <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".sub[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> \< <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".lt[ " + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> \<= <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".lte[" + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> \> <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".gt[" + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> \>= <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".gte[ " + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> == <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".eq[" + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> != <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".neq[" + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> && <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " and " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> || <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " or " + expression2alloy(rhs,vm);

str exprlist2alloy(ExprList explist,VarMap vm){
	if("<explist>" != ""){
		return replaceLast(( "" | it + expression2alloy(e,vm) + "," | e <- explist.exprs),",","");
	}
	return "";
}
list[Expr] exprlist2list(ExprList el){
	if("<el>" != ""){
		return ([] | it + e | e <- el.exprs);
	}
	return [];
}
