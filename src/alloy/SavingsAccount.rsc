module alloy::SavingsAccount

import ParseTree;
import IO;
import alloy::util::Info;
import alloy::util::StringTemplates;
import alloy::fact::Traces;
import alloy::Expressions;
import alloy::calledevents::Events;
import alloy::Events;
import alloy::Functions;
import grammar::Expressions;
import grammar::Events;
import grammar::Functions;
import grammar::SavingsAccount;

void savingsaccount2alloy(SavingsAccount sa, bool log){
	loc b = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryEvents.txt|;
	loc f = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryFunctions.txt|;
	//TODO START[#Events]
	Events evs = parse(#start[Events],b);
	EventMap em = getEventMap(b);
	events = [ em[e.name] | e <- sa.events]; 
	str body = addMLComment("EVENTS");
	body += ("" | it + event2alloy(em[ev.name],initInfo(ev.name,exprlist2list(ev.el),em)) + "\n\n"  | ev <- sa.events);
	
	
	body += addMLComment("CALLED EVENTS");
	body += calledevents2alloy(events,em);
	
	body += addMLComment("FUNCTIONS");
	Functions funcs = parse(#start[Functions],f);
	body += functions2alloy(funcs);
	
	body += addMLComment("FACT");
	body += fact2alloy(events);
	
	loc alloyFile = getAlloyFileLoc(sa.name);
	
	writeToAlloy(alloyFile,sa.name,body);
	
	if(log) println(body);
}


loc getAlloyFileLoc(SavingsAccountName name) = |file:///C:/Users/Chiel/Dropbox/Thesis/Alloy/| + "<name>.als";

void writeToAlloy(loc file, SavingsAccountName name, str body){
	str res = getModuleName(name) + getImports() + getSignature() + body;
	writeFile(file,res);
}
