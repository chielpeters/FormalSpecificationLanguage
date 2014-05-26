module lang::invariants::alloy::Invariants

import lang::invariants::\syntax::Invariants;
import lang::specifications::\syntax::Specifications;
import lang::specifications::alloy::utils::StringTemplates;
import List;

alias InvariantMap = map[InvariantName name, Invariant inv];


str invariants2alloy(InvariantInstances i_invs, Invariants invs){
	InvariantMap invMap = getInvariantMap(invs);
	return ("" | it + invariant2alloy(invMap[inv.name]) + "\n" | inv <- i_invs.invariants);
}

str invariant2alloy(Invariant inv){
	return "assert <inv.name> {
	'  <inv.decl.scope> <inv.decl.e>
	'}";
}

str invariant2alloycommand(InvariantInstance inv) = "check <inv.name> <getCommandScope()>";

InvariantMap getInvariantMap(Invariants invs) = ( () | it + (inv.name : inv) | inv <- invs.invariants);