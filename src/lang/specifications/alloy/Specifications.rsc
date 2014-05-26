module lang::specifications::alloy::Specifications


import lang::specifications::alloy::utils::Info;
import lang::specifications::alloy::utils::StringTemplates;
import lang::specifications::alloy::utils::CalledFunctions;
import lang::specifications::alloy::fact::Traces;
import lang::specifications::alloy::Expressions;
import lang::specifications::alloy::Signature;
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
	list[Event] calledevents = [ em[e.name] | e <- spec.evs.events]; 
	CalledFunctions cf = getCalledFunctions(calledevents,funcs,spec);
	
	str body = getModuleName(spec.name) + getImports(spec.name) + signature2alloy(spec.name,spec.fields.fields);
	
	body += addMLComment("EVENTS");
	body += ("" | it + event2alloy(em[ev.name],spec.fields.fields,initInfo(spec.name,exprlist2list(ev.el),ev.name,em)) + "\n\n"  | ev <- spec.evs.events);
		
	body += addMLComment("FUNCTIONS");
	body += functions2alloy(funcs,cf);
	
	body += addMLComment("FACT");
	body += fact2alloy(calledevents,spec.name);
	
	if(/InvariantInstances invs := spec){
		body += addMLComment("INVARIANTS");
		body += invariants2alloy(invs,invariants);
	}
	
	body += addMLComment("COMMANDS");
	body += predShow(spec.name);
	if(/InvariantInstances invs := spec){
		body += (""|it + invariant2alloycommand(inv,spec.name) + "\n" | inv <- invs.invariants);
	}
	
	loc output = getOutputAlloyFileLocation(spec.name);
	
	writeFile(output,body);
	if(log) println(body);
}


loc getOutputAlloyFileLocation(SpecificationName name) = |project://FormalSpecificationLanguage/output/| + "<name>.als";



