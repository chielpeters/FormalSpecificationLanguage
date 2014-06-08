module lang::specifications::alloy::Specifications


import lang::specifications::alloy::utils::Info;
import lang::specifications::alloy::utils::StringTemplates;
import lang::specifications::alloy::utils::CalledFunctions;
import lang::specifications::alloy::fact::Traces;
import lang::specifications::alloy::Expressions;
import lang::specifications::alloy::Signature;
import lang::specifications::\syntax::Specifications;
import lang::specifications::utils::Parse;

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


void specification2alloy(Specification spec,loc folder, bool log){

	for(i <- spec.imports.imports){
		fileLoc = folder + "<i.filename>.spec";
		specification2alloy(parseSpecification(fileLoc),folder,false);
	}

	Events evs = unpackAndParseEvents(folder.parent);
	Functions funcs = unpackAndParseFunctions(folder.parent);
	Invariants invariants = unpackAndParseInvariants(folder.parent);
	
	EventMap em = getEventMap(evs);
	list[Event] calledevents = [ em[e.name] | e <- spec.evs.events]; 
	CalledFunctions cf = getCalledFunctions(calledevents,funcs,spec);
	
	str body = getModuleName(spec.name) + getNativeImports(spec.name);
	
	body += (""| it + "open " + "<i.filename>" + "\n" | i <- spec.imports.imports) + "\n"; 
	body += signature2alloy(spec.name,spec.fields.fields);
	
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
	body += showCommand(spec.name,spec.imports);
	if(/InvariantInstances invs := spec){
		body += (""|it + invariant2alloycommand(inv,spec.name,spec.imports) + "\n" | inv <- invs.invariants);
	}
	
	loc output = getOutputAlloyFileLocation(spec.name);
	
	writeFile(output,body);
	if(log) println(body);
}


loc getOutputAlloyFileLocation(SpecificationName name) = |project://FormalSpecificationLanguage/output/| + "<name>.als";



