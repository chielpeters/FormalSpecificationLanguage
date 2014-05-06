module alloy::Events

import grammar::Events;
import alloy::VarMap;
import alloy::Functions;
import alloy::Expressions;
import List;
import String;

alias EventMap = map[EventName,Event];


EventMap getEvents(Events events){
	return ( () | it + (event.sig.name : event)| event <- events);
} 

str event2alloy(EventName name, list[Expr] args, EventMap evMap){
	VarMap VarMap = getVarMap(args,evMap[name]);
	return event2alloy(evMap[name],VarMap);
}

str event2alloy((Event)`<Signature sig> <Parameters param> <Pre pre> <Post post>`, VarMap vm){
	return "pred SavingsAccount.<sig.name> [s : SavingsAccount, <functionargs2alloy(param.args)>] {
	'  <precond2alloy(pre,vm)>  
	'  <postcond2alloy(post,vm)>
	'}";
}

VarMap getVarMap(list[Expr] args, Event event){
	int i = 0;
	VarMap vm = ();
	for(arg <- event.sig.args){
		if(i < size(args)){vm += (arg.var : args[i]);} else 
		if((EventArgument)`<Type t> <Var v> = <Expr exp>` := arg){ vm += (arg.var : exp);}
		else throw "Event Variable is undefined <arg.var>";
		i+=1;
	}
	return vm;
}

str precond2alloy(Pre pre,VarMap vm){
	return replaceLast((""| it + condition2alloy(cond,vm) + " and " | cond <- pre.preconditions)," and ","");
}
str postcond2alloy(Post post,VarMap vm){
	return replaceLast((""| condition2alloy(cond,vm) + " and " | cond <- post.postconditions)," and ","");
}

str condition2alloy((Condition)`<Expr exp>`,VarMap vm) = expression2alloy(exp,vm);
