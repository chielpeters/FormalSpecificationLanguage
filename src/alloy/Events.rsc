module alloy::Events

import grammar::Events;
import alloy::VarMap;
import alloy::Functions;
import alloy::Expressions;
import alloy::TypesAndLiterals;
import List;
import String;

str event2alloy((Event)`<Signature sig> <Parameters param> <Pre pre> <Post post>`, VarMap vm){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount, <functionargs2alloy(param.args)>] {
	'  <precond2alloy(pre,vm)>  
	'  <postcond2alloy(post,vm)>
	'}";
}

str event2alloy((Event)`<Signature sig> <Pre pre> <Post post>`, VarMap vm){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount] {
	'  <precond2alloy(pre,vm)>  
	'  <postcond2alloy(post,vm)>
	'}";
}

str event2alloy((Event)`<Signature sig> <Post post>`, VarMap vm){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount] { 
	'  <postcond2alloy(post,vm)>
	'}";
}

str event2alloy((Event)`<Signature sig>`, VarMap vm){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount] {
	'}";
}


str precond2alloy(Pre pre,VarMap vm){
	return replaceLast((""| it + condition2alloy(cond,vm) + " and " | cond <- pre.preconditions)," and ","");
}
str postcond2alloy(Post post,VarMap vm){
	return replaceLast((""| it + condition2alloy(cond,vm) + " and " | cond <- post.postconditions)," and ","");
}


str condition2alloy((Cond)`<Expr exp>`,VarMap vm) = expression2alloy(exp,vm);
//TODO eventArgs
str condition2alloy((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,VarMap vm) = "<name> [this,s,<exprlist2alloy(param,vm)>]";
str condition2alloy((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,VarMap vm)= "all <literal2alloy(v,vm)> : <expression2alloy(e,vm)> | <condition2alloy(c,vm)>";

/*
str lifecyclecond2alloy(EventName name){
	if(contains("<name>","close")) return "s.opened = 1 and this.opened = 0";
	else if(contains("<name>","open")) return "s.opened = 0 and this.opened = 1";
	else return "s.opened = 1 and this.opened = 1"; 
}
*/