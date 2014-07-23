module lang::invariants::alloy::Invariants

import lang::specifications::alloy::Expressions;
import lang::specifications::\syntax::Lexical;
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
	'  <invariantquantifieddecl2alloy(inv.decl)>
	'}";
}

str invariantquantifieddecl2alloy(QuantifiedDecl decl){
	str scope = (""| it + scope2alloy(s,()) + " |" |s <- decl.scope);
	str lifecycle = intercalate(" && ", [ "<s.d.v>.opened = 1" | s <- decl.scope, "<s.d.e>" notin {"Date","Percentage","Integer","Boolean","Frequency","Period"}  ]);
	return scope + "{ " + lifecycle + "=\>" + expr2alloy(decl.e,()) + " }";
}

str invariant2alloycommand(InvariantInstance inv,SpecificationName name, Imports imports) = "check <inv.name> <getCommandScope(name,imports)>";

InvariantMap getInvariantMap(Invariants invs) = ( () | it + (inv.name : inv) | inv <- invs.invariants);