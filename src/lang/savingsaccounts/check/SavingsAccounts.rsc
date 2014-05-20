module lang::savingsaccounts::check::SavingsAccounts

import lang::savingsaccounts::\syntax::SavingsAccount;
import lang::functions::\syntax::Functions;
import lang::functions::utils::Parse;
import lang::events::\syntax::Events;
import lang::events::utils::Parse;
import lang::invariants::\syntax::Invariants;
import lang::invariants::utils::Parse;

import Message;
import ParseTree;

list[Message] check(SavingsAccount sa){

	set[EventName] existingEvents = { ev.sig.name | ev <- unpackAndParseEvents().events};
	errors = [ error("Undefined Event <e.name>", e.name@\loc) | e <- sa.evs.events, e.name notin existingEvents];
	
	set[FunctionName] existingFunctions = { f.name | f <- unpackAndParseFunctions().functions};
	for(/Var v := sa){
		if( [FunctionName]"<v>" notin existingFunctions){ errors += [error("undefined Function <v>", v@\loc)];}
	}
	if(/InvariantInstances invs := sa){
		set[InvariantName] existingInvariants = { inv.name | inv <- unpackAndParseInvariants().invariants};
		errors += [ error("Undefined InvariantName <inv.name>",inv.name@\loc) | inv <- invs.invariants, inv.name notin existingInvariants]; 
	}
	return errors;
}