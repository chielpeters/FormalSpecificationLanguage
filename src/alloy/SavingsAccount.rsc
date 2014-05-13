module alloy::SavingsAccount

import ParseTree;
import alloy::util::Info;
import alloy::Expressions;
import alloy::calledevents::Events;
import alloy::Events;
import alloy::Functions;
import grammar::Expressions;
import grammar::Events;
import grammar::Functions;
import grammar::SavingsAccount;

str savingsaccount2alloy(SavingsAccount sa){
	loc b = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryEvents.txt|;
	loc f = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryFunctions.txt|;
	//TODO START[#Events]
	EventMap em = getEventMap(parse(#Events,b));
	str res = ("" | it + event2alloy(em[ev.name],initInfo(ev.name,exprlist2list(ev.el),em)) + "\n\n"  | ev <- sa.events);
	calledEvents = [ em[e.name] | e <- sa.events]; 
	
	res += addComment("CALLED EVENTS");
	res += calledevents2alloy(calledEvents,em);
	
	res += addComment("FUNCTIONS");
	res += functions2alloy(parse(#Functions,f));
	
	return res;
}
