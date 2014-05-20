module alloy::SavingsAccount

import ParseTree;
import parse;
import List;
import IO;
import alloy::util::Info;
import alloy::util::StringTemplates;
import alloy::fact::Traces;
import alloy::Expressions;
import alloy::calledevents::Events;
import alloy::Events;
import alloy::Invariants;
import alloy::Functions;
import grammar::Expressions;
import grammar::Events;
import grammar::Functions;
import grammar::SavingsAccount;

void savingsaccount2alloy(SavingsAccount sa, bool log){

	Events evs = unpackAndParseEvents();
	Functions funcs = unpackAndParseFunctions();
	Invariants invariants = unpackAndParseInvariants();
	
	EventMap em = getEventMap(evs);
	events = [ em[e.name] | e <- sa.evs.events]; 
	CalledFunctions cf = getCalledFunctions(events,sa);
	
	
	str body = addMLComment("EVENTS");
	body += ("" | it + event2alloy(em[ev.name],initInfo(ev.name,exprlist2list(ev.el),em)) + "\n\n"  | ev <- sa.evs.events);
	
	body += addMLComment("CALLED EVENTS");
	body += calledevents2alloy(events,em);
	
	body += addMLComment("FUNCTIONS");
	body += functions2alloy(funcs,cf);
	
	body += addMLComment("FACT");
	body += fact2alloy(events);
	
	if(/I_Invariants invs := sa){
		body += addMLComment("INVARIANTS");
		body += invariants2alloy(invs,invariants);
	}
	
	body += addMLComment("COMMANDS");
	body += predShow();
	if(/I_Invariants invs := sa){
		body += (""|it + invariant2alloycommand(inv) + "\n" | inv <- invs.invariants);
	}
	
	loc alloyFile = getAlloyFileLoc(sa.name);
	writeToAlloy(alloyFile,sa.name,body);
	if(log) println(body);
}


loc getAlloyFileLoc(SavingsAccountName name) = |file:///C:/Users/Chiel/Dropbox/Public/| + "<name>.als";

void writeToAlloy(loc file, SavingsAccountName name, str body){
	str res = getModuleName(name) + getImports() + getSignature() + body;
	writeFile(file,res);
}

CalledFunctions getCalledFunctions(list[Event] events, SavingsAccount sa){
	CalledFunctions cf = {};
	for(/FunctionName v := events){ cf += v;}
	for(event <- events){ for(/Var v := event.sig.args){ cf += [FunctionName]"<v>";}}
	for(ev <- sa.evs.events){ for(/Var v := ev.el){ cf += [FunctionName]"<v>";}}	
	return cf;
}
