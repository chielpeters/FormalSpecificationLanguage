module lang::specifications::alloy::Specifications


import lang::specifications::alloy::utils::Info;
import lang::specifications::alloy::utils::StringTemplates;
import lang::specifications::alloy::utils::CalledFunctions;
import lang::specifications::alloy::fact::Traces;
import lang::specifications::alloy::Expressions;
import lang::specifications::\syntax::Specifications;

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


void specification2alloy(Specification spec, bool log){

	Events evs = unpackAndParseEvents();
	Functions funcs = unpackAndParseFunctions();
	Invariants invariants = unpackAndParseInvariants();
	
	EventMap em = getEventMap(evs);
	events = [ em[e.name] | e <- spec.evs.events]; 
	CalledFunctions cf = getCalledFunctions(events,funcs,spec);
	
	str body = getModuleName(spec.name) + getImports() + getSignature();
	
	body += addMLComment("EVENTS");
	body += ("" | it + event2alloy(em[ev.name],initInfo(ev.name,exprlist2list(ev.el),em,{})) + "\n\n"  | ev <- spec.evs.events);
		
	body += addMLComment("FUNCTIONS");
	body += functions2alloy(funcs,cf);
	
	body += addMLComment("FACT");
	body += fact2alloy(events);
	
	if(/InvariantInstances invs := spec){
		body += addMLComment("INVARIANTS");
		body += invariants2alloy(invs,invariants);
	}
	
	body += addMLComment("COMMANDS");
	body += predShow();
	if(/InvariantInstances invs := spec){
		body += (""|it + invariant2alloycommand(inv) + "\n" | inv <- invs.invariants);
	}
	
	loc output = getOutputAlloyFileLocation(spec.name);
	
	writeFile(output,body);
	if(log) println(body);
}


loc getOutputAlloyFileLocation(Specification name) = |project://FormalSpecificationLanguage/output/| + "<name>.als";



