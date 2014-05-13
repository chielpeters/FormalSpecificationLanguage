module alloy::Expressions

import grammar::Expressions;
import alloy::util::Info;
import alloy::TypesAndLiterals;
import String;
import List;

str expr2alloy((Expr) `(<Expr e>)`,VarMap vm) = "( " + expr2alloy(e,vm) + " )";
str expr2alloy((Expr)`<Var v>`,VarMap vm) = var2alloy(v,vm);
str expr2alloy((Expr)`<Var v> [ <ExprList el> ]`,VarMap vm) = var2alloy(v,vm) + "[" + exprlist2alloy(el,vm) + "]";
str expr2alloy((Expr) `<PropertyOfVar pv>`,VarMap vm) = propertyofvar2alloy(pv,vm);
str expr2alloy((Expr) `old <PropertyOfVar pv>`,VarMap vm) = propertyofvar2alloy(pv,vm+oldNow());
str expr2alloy((Expr) `<LiteralPlus l>`,VarMap vm) = literalplus2alloy(l,vm);
str expr2alloy((Expr) `{ <Expr lhs> ... <Expr rhs> }`,VarMap vm) = "Filter[<expr2alloy(lhs,vm)>,<expr2alloy(rhs,vm)>]";
str expr2alloy((Expr) `! <Expr e>`,VarMap vm) = "!" + expr2alloy(e,vm);
str expr2alloy((Expr) `<Expr lhs> in <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + " in "  + expr2alloy(rhs,vm);
str expr2alloy((Expr) `<Expr lhs> * <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".mul["  + expr2alloy(rhs,vm) + "]";
str expr2alloy((Expr) `<Expr lhs> / <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".div[" + expr2alloy(rhs,vm) + "]";
str expr2alloy((Expr) `<Expr lhs> % <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".rem[" + expr2alloy(rhs,vm) + "]";
str expr2alloy((Expr) `<Literal date> + <Int i> * <Period p>`,VarMap vm) = literal2alloy(date,vm) + ".add[" + literal2alloy(i,vm) + "," + literal2alloy(p,vm) + "]";
str expr2alloy((Expr) `<Expr lhs> + <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".add[" + expr2alloy(rhs,vm) + "]";
str expr2alloy((Expr) `<Literal date> - <Int i> * <Period p>`,VarMap vm) = literal2alloy(date,vm) + ".sub[" + literal2alloy(i,vm) + "," + literal2alloy(p,vm) + "]";
str expr2alloy((Expr) `<Expr lhs> - <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".sub[" + expr2alloy(rhs,vm) + "]";
str expr2alloy((Expr) `<Expr lhs> \< <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".lt[ " + expr2alloy(rhs,vm)+ "]";
str expr2alloy((Expr) `<Expr lhs> \<= <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".lte[" + expr2alloy(rhs,vm)+ "]";
str expr2alloy((Expr) `<Expr lhs> \> <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".gt[" + expr2alloy(rhs,vm)+ "]";
str expr2alloy((Expr) `<Expr lhs> \>= <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + ".gte[" + expr2alloy(rhs,vm)+ "]";
str expr2alloy((Expr) `<Expr lhs> == <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + " = " + expr2alloy(rhs,vm);
str expr2alloy((Expr) `<Expr lhs> != <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + " != " + expr2alloy(rhs,vm);
str expr2alloy((Expr) `<Expr lhs> && <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + " and " + expr2alloy(rhs,vm);
str expr2alloy((Expr) `<Expr lhs> || <Expr rhs>`,VarMap vm) = expr2alloy(lhs,vm) + " or " + expr2alloy(rhs,vm);

str literalplus2alloy((LiteralPlus)`<Literal l>`,VarMap vm) = literal2alloy(l,vm);
str literalplus2alloy((LiteralPlus)`( <MapElements elems> )`,VarMap vm) = "{" + intercalate(", ", [ mapelem2alloy(elem,vm) | elem <- elems.elems]) + "}";
str literalplus2alloy((LiteralPlus)`{<ExprList el>}`,VarMap vm) = "{" + exprlist2alloy(el,vm) + "}";
str literalplus2alloy((LiteralPlus)`[<ExprList el>]`,VarMap vm) = "{" + intercalate(" + ", [seqelem2alloy(e,i,vm)| <i,e> <- enumerate(el)]) + "}";

str seqelem2alloy(Expr a,int i,VarMap vm) = "<i>" + "-\>" + expr2alloy(a,vm);
str mapelem2alloy(MapElement m,VarMap vm) = expr2alloy(m.key,vm) +  "-\>" + expr2alloy(m.val,vm);
str exprlist2alloy(ExprList explist,VarMap vm) = intercalate(", ", [ expr2alloy(e,vm) | e <- explist.exprs ]);

str propertyofvar2alloy((PropertyOfVar)`<Var v> <Fields f>`,VarMap vm) = var2alloy(v,vm) + "<f>";
str propertyofvar2alloy((PropertyOfVar)`<Var v> <Fields f> [<ExprList el> ]`,VarMap vm) = var2alloy(v,vm) + "<f>" + "[" + exprlist2alloy(el,vm) + "]";
str var2alloy(Var v,VarMap vm) = (v in vm) ? expr2alloy(vm[v],vm) : "<v>"; 


list[Expr] exprlist2list(ExprList el) = [ e | e <- el.exprs ];
list[tuple[int, Expr]] enumerate(ExprList el){
	int n =0;
	list[tuple[int, Expr]] l = [];
	for(e <- el.exprs){ l += [<n,e>];n+=1;}
	return l;
}
