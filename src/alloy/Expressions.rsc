module alloy::Expressions

import grammar::Expressions;
import alloy::VarMap;
import alloy::TypesAndLiterals;
import String;

str expression2alloy((Expr) `(<Expr e>)`,VarMap vm) = "( " + expression2alloy(e,vm) + " )";
//TODO Change to accept both properties
str expression2alloy((Expr) `<PropertyOfVar pv>`,VarMap vm){
	if(pv.var in vm && (PropertyOfVar)`<Var v> <Fields f>` :=pv) return expression2alloy(vm[v],vm) + "<f>";  
	else if(pv.var in vm && (PropertyOfVar)`<Var v> <Fields f> [<ExprList el>]` :=pv) return expression2alloy(vm[v],vm) + "<f>" + "[" +exprlist2alloy(el,vm) + "]";  
	else if((PropertyOfVar)`<Var v> <Fields f>`:=pv) return "<v><f>"; 
	else if((PropertyOfVar)`<Var v> <Fields f> [<ExprList el> ]`:=pv) return "<v><f>" + "[" + exprlist2alloy(el,vm) +"]";
	else throw "PropertyofVar not caught";
	
}
str expression2alloy((Expr) `old <PropertyOfVar p>`,VarMap vm){
	if((PropertyOfVar)`this <Fields f>` := p) return "s<f>" ;
	if((PropertyOfVar)`this <Fields f> [<ExprList el>]` := p) return "s<f>[<exprlist2alloy(el,vm+oldNow())>]";
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
str expression2alloy((Expr) `<Literal date> + <Int i> * <Period p>`,VarMap vm) = literal2alloy(date,vm) + ".add[" + literal2alloy(i,vm) + "," + literal2alloy(p,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> + <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".add[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Literal date> - <Int i> * <Period p>`,VarMap vm) = literal2alloy(date,vm) + ".sub[" + literal2alloy(i,vm) + "," + literal2alloy(p,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> - <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".sub[" + expression2alloy(rhs,vm) + "]";
str expression2alloy((Expr) `<Expr lhs> \< <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".lt[ " + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> \<= <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".lte[" + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> \> <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".gt[" + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> \>= <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".gte[ " + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> == <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " = " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> != <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " != " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> && <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " and " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> || <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " or " + expression2alloy(rhs,vm);

str exprlist2alloy(ExprList explist,VarMap vm) = intercalate(", ", [ expression2alloy(e) | e <- explist.exprs ]);
list[Expr] exprlist2list(ExprList el) = [ e | e <- el.exprs ];
