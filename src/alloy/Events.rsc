module alloy::Events

import grammar::Events;
import alloy::util::Info;
import alloy::Functions;
import alloy::Expressions;
import alloy::changedproperties::Events;
import List;
import String;
import ParseTree;

str event2alloy(Event e, Info i){
	return "pred SavingsAccount.<i.name> [ s : SavingsAccount <(/Parameters p := e.param) ? ","+functionargs2alloy(p.args):"">]{
	'  <(/Pre pre := e.pre) ? addComment("PRECONDITIONS")+precond2alloy(pre,i):"">
	'  <(/Post post := e.post) ? addComment("POSTCONDITIONS")+postcond2alloy(post,i):"">
	'  <notchangedproperties2alloy(e,i.em,"s","this")>
	'}";
}

str precond2alloy(Pre pre,Info i) = intercalate(" \n", [ cond2alloy(cond,addVars(i,oldNow())) | cond <- pre.preconditions ]);
str postcond2alloy(Post post,Info i) = intercalate(" \n", [ cond2alloy(cond,i) | cond <- post.postconditions ]);

str cond2alloy((Cond)`<Expr exp>`,Info i) = expr2alloy(exp,i.vm);
str cond2alloy((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,Info i) = "<i.name>_<name>[this,s,<exprlist2alloy(param,i.vm)>]";
str cond2alloy((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,Info i)= "all <var2alloy(v,i.vm)> : <expr2alloy(e,i.vm)> | <cond2alloy(c,i)>";

str addComment(str comment) = "// <comment> \n";