module alloy::SavingsAccount

import ParseTree;
import List;
import alloy::Info;
import alloy::Expressions;
import alloy::Events;
import grammar::Expressions;
import grammar::Events;
import grammar::SavingsAccount;
import grammar::TypesAndLiterals;

str savingsaccount2alloy(SavingsAccount sa){
	loc b = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryEventsFormatted.txt|;
	EventMap em = getEventMap(parse(#Events,b));
	return ("" | it + event2alloy(ev.name,exprlist2list(ev.el),em) + "\n\n"  | ev <- sa.events);
}

str event2alloy(EventName name, list[Expr] args, EventMap em){
	VarMap vm = setVarMap(args,evMap[name]);
	Info i = initInfo(name,vm,em);
	return event2alloy(evMap[name],i);
}
