module lang::savingsaccounts::alloy::SavingsAccount


import lang::savingsaccounts::alloy::utils::Info;
import lang::savingsaccounts::alloy::utils::StringTemplates;
import lang::savingsaccounts::alloy::utils::CalledFunctions;
import lang::savingsaccounts::alloy::fact::Traces;
import lang::savingsaccounts::alloy::Expressions;
import lang::savingsaccounts::\syntax::SavingsAccount;

import lang::events::alloy::Events;
import lang::events::\syntax::Events;
import lang::events::utils::Parse;

import lang::invariants::alloy::Invariants;
import lang::invariants::\syntax::Invariants;
import lang::invariants::utils::Parse;

import lang::functions::alloy::Functions;
import lang::functions::\syntax::Functions;
import lang::functions::utils::Parse;

import ParseTree;
import List;
import IO;


void savingsaccount2alloy(SavingsAccount sa, bool log){

	Events evs = unpackAndParseEvents();
	Functions funcs = unpackAndParseFunctions();
	Invariants invariants = unpackAndParseInvariants();
	
	EventMap em = getEventMap(evs);
	events = [ em[e.name] | e <- sa.evs.events]; 
	CalledFunctions cf = getCalledFunctions(events,funcs,sa);
	
	str body = getModuleName(sa.name) + getImports() + getSignature();
	
	body += addMLComment("EVENTS");
	body += ("" | it + event2alloy(em[ev.name],initInfo(ev.name,exprlist2list(ev.el),em,{})) + "\n\n"  | ev <- sa.evs.events);
		
	body += addMLComment("FUNCTIONS");
	body += functions2alloy(funcs,cf);
	
	body += addMLComment("FACT");
	body += fact2alloy(events);
	
	if(/InvariantInstances invs := sa){
		body += addMLComment("INVARIANTS");
		body += invariants2alloy(invs,invariants);
	}
	
	body += addMLComment("COMMANDS");
	body += predShow();
	if(/InvariantInstances invs := sa){
		body += (""|it + invariant2alloycommand(inv) + "\n" | inv <- invs.invariants);
	}
	
	loc output = getOutputAlloyFileLocation(sa.name);
	
	writeFile(output,body);
	if(log) println(body);
}


loc getOutputAlloyFileLocation(SavingsAccountName name) = |project://SavingsAccount/output/| + "<name>.als";



