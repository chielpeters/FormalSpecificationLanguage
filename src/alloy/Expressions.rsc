module alloy::Expressions

import grammar::Expressions;
import alloy::util::Info;
import alloy::TypesAndLiterals;
import String;
import List;

str expression2alloy((Expr) `(<Expr e>)`,VarMap vm) = "( " + expression2alloy(e,vm) + " )";
str expression2alloy((Expr)`<Var v>`,VarMap vm) = var2alloy(v,vm);
str expression2alloy((Expr)`<Var v> [ <ExprList el> ]`,VarMap vm) = var2alloy(v,vm) + "[" + exprlist2alloy(el,vm) + "]";
str expression2alloy((Expr) `<PropertyOfVar pv>`,VarMap vm) = propertyofvar2alloy(pv,vm);
str expression2alloy((Expr) `old <PropertyOfVar p>`,VarMap vm) = propertyofvar2alloy(pv,vm+oldNow());
str expression2alloy((Expr) `<LiteralPlus l>`,VarMap vm) = literalplus2alloy(l,vm);
str expression2alloy((Expr) `{ <Expr lhs> ... <Expr rhs> }`,VarMap vm) = "Filter[<expression2alloy(lhs,vm)>,<expression2alloy(rhs,vm)>]";
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
str expression2alloy((Expr) `<Expr lhs> \>= <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + ".gte[" + expression2alloy(rhs,vm)+ "]";
str expression2alloy((Expr) `<Expr lhs> == <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " = " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> != <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " != " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> && <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " and " + expression2alloy(rhs,vm);
str expression2alloy((Expr) `<Expr lhs> || <Expr rhs>`,VarMap vm) = expression2alloy(lhs,vm) + " or " + expression2alloy(rhs,vm);

str literalplus2alloy((LiteralPlus)`<Literal l>`,VarMap vm) = literal2alloy(l,vm);
str literalplus2alloy((LiteralPlus)`( <MapElements elems> )`,VarMap vm) = "{" + intercalate(", ", [ mapelem2alloy(elem,vm) | elem <- elems.elems]) + "}";
str literalplus2alloy((LiteralPlus)`{<ExprList el>}`,VarMap vm) = "{" + exprlist2alloy(el,vm) + "}";
str literalplus2alloy((LiteralPlus)`[<ExprList el>]`,VarMap vm) = "{" + intercalate(" + ", [seqelem2alloy(e,i,vm)| <i,e> <- enumerate(l)]) + "}";

str seqelem2alloy(Expr a,int i,VarMap vm) = "<i>" + "-\>" + expression2alloy(a,vm);
str mapelem2alloy(MapElement m,VarMap vm) = expression2alloy(m.key,vm) +  "-\>" + expression2alloy(m.val,vm);
str exprlist2alloy(ExprList explist,VarMap vm) = intercalate(", ", [ expression2alloy(e,vm) | e <- explist.exprs ]);

str propertyofvar2alloy((PropertyOfVar)`<Var v> <Fields f>`,VarMap vm) = var2alloy(v) + "<f>";
str propertyofvar2alloy((PropertyOfVar)`<Var v> <Fields f> [<ExprList el> ]`,VarMap vm) = var2alloy(v) + "<f>" + "[" + exprlist2alloy(el) + "]";
str var2alloy(Var v,VarMap vm) = (v in vm) ? expression2alloy(vm[v],vm) : "<v>"; 


list[Expr] exprlist2list(ExprList el) = [ e | e <- el.exprs ];
list[tuple[int, Expr]] enumerate(ExprList el){
	int n =0;
	list[tuple[int, Expr]] l = [];
	for(e <- el.exprs){ n+=1;l += [<n,e>];}
	return l;
}
