module alloy::Events

import grammar::Events;
import alloy::util::Info;
import alloy::util::ParseOptionals;
import alloy::Functions;
import alloy::Expressions;
import alloy::TypesAndLiterals;
import alloy::changedproperties::Events;
import List;
import String;
import ParseTree;

str event2alloy(Event e, Info i){
	return "pred SavingsAccount.<i.name> [ s : SavingsAccount <posparam2alloy(e,i)>]{
	'  <posprecond2alloy(e,i)>
	'  <pospostcond2alloy(e,i)>
	'  <notchangedproperties2alloy(e,i.em,"s","this")>
	'}";
}

str posparam2alloy(Event e, Info i) = "," + functionargs2alloy(getParam(e).args) when !isEmpty("<e.param>"); 
str posparam2alloy(Event e, Info i) = "";
 
str posprecond2alloy(Event e, Info i) = addComment("PRECONDITIONS") + precond2alloy(getPreCondition(e),i) when !isEmpty("<e.pre>"); 
str posprecond2alloy(Event e, Info i) = ""; 

str pospostcond2alloy(Event e, Info i) = addComment("POSTCONDITIONS") + postcond2alloy(getPostCondition(e),i) when !isEmpty("<e.post>"); 
str pospostcond2alloy(Event e, Info i) = ""; 

str precond2alloy(Pre pre,Info i) = intercalate(" \n", [ condition2alloy(cond,addVars(i,oldNow())) | cond <- pre.preconditions ]);
str postcond2alloy(Post post,Info i) = intercalate(" \n", [ condition2alloy(cond,i) | cond <- post.postconditions ]);

str condition2alloy((Cond)`<Expr exp>`,Info i) = expression2alloy(exp,i.vm);
str condition2alloy((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,Info i) = "<i.name>_<name>[this,s,<exprlist2alloy(param,i.vm)>]";
str condition2alloy((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,Info i)= "all <literal2alloy(v,i.vm)> : <expression2alloy(e,i.vm)> | <condition2alloy(c,i)>";

str addComment(str comment) = "// <comment> \n";