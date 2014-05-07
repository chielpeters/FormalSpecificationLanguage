module alloy::SavingsAccount

import ParseTree;
import List;
import alloy::VarMap;
import alloy::Expressions;
import alloy::Events;
import grammar::Expressions;
import grammar::Events;
import grammar::SavingsAccount;

str savingsaccount2alloy(SavingsAccount sa){
	loc b = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryEventsFormatted.txt|;
	EventMap em = getEvents(parse(#Events,b));
	return ("" | it + event2alloy(ev.name,exprlist2list(ev.exprlist),em) + "\n\n"  | ev <- sa.events);
}

str event2alloy(EventName name, list[Expr] args, EventMap evMap){
	VarMap VarMap = getVarMap(args,evMap[name]);
	return event2alloy(evMap[name],VarMap);
}

EventMap getEvents(Events events){
	return ( () | it + (event.sig.name : event)| event <- events.events);
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