module alloy::Events

import grammar::Events;
import alloy::Info;
import alloy::Functions;
import alloy::Expressions;
import alloy::TypesAndLiterals;
import List;
import String;

str event2alloy((Event)`<Signature sig> <Parameters param> <Pre pre> <Post post>`, Info i){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount, <functionargs2alloy(param.args)>] {
	'  <precond2alloy(pre,i)>  
	'  <postcond2alloy(post,i)>
	'}";
}

str event2alloy(e:(Event)`<Signature sig> <Pre pre> <Post post>`, Info i){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount] {
	'  <precond2alloy(pre,i)>  
	'  <postcond2alloy(post,i)>
	'}";
}

str event2alloy((Event)`<Signature sig> <Post post>`, Info i){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount] { 
	'  <postcond2alloy(post,i)>
	'}";
}

str event2alloy((Event)`<Signature sig>`, Info i){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount] {
	'}";
}


str precond2alloy(Pre pre,Info i){
	return intercalate(" and ", [ condition2alloy(cond,addVars(i,oldNow())) | cond <- pre.preconditions ]);
}
str postcond2alloy(Post post,Info i){
	return intercalate(" and ", [ condition2alloy(cond,vm) | cond <- post.postconditions ]);
}


str condition2alloy((Cond)`<Expr exp>`,Info i) = expression2alloy(exp,i.vm);
//TODO eventArgs
str condition2alloy((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,Info i) = "<name> [this,s,<exprlist2alloy(param,i.vm)>]";
str condition2alloy((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,Info i)= "all <literal2alloy(v,i.vm)> : <expression2alloy(e,i.vm)> | <condition2alloy(c,i)>";