module lang::savingsaccounts::alloy::utils::CalledFunctions

import lang::events::\syntax::Events;
import lang::savingsaccounts::\syntax::SavingsAccount;

alias CalledFunctions = set[FunctionName];

CalledFunctions getCalledFunctions(list[Event] events,Functions funcs,SavingsAccount sa){
	CalledFunctions cf = {};
	for(/FunctionName v := events){ cf += v;}
	for(event <- events){ for(/Var v := event.sig.args){ cf += [FunctionName]"<v>";}}
	for(ev <- sa.evs.events){ for(/Var v := ev.el){ cf += [FunctionName]"<v>";}}	
	return cf + calledFunctionsbyFunctions(cf,funcs);
}

CalledFunctions calledFunctionsbyFunctions(CalledFunctions cf, Functions funcs) =
 	( cf | it + calledFunctionsbyFunction(f) | f <- funcs.functions, f.name in cf);
 	
CalledFunctions calledFunctionsbyFunction(Function f){
	CalledFunctions cf = {};
	for(/FunctionName n := f.s){cf +=n;}
	return cf;
}