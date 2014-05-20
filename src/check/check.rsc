module check::check

import Message;
import parse;
import ParseTree;
import grammar::Functions;
import grammar::Events;
import grammar::SavingsAccount;


list[Message] check(SavingsAccount sa){

	set[EventName] existingEvents = { ev.sig.name | ev <- unpackAndParseEvents().events};
	errors = [ error("Undefined Event <e.name>", e.name@\loc) | e <- sa.evs.events, e.name notin existingEvents];
	
	set[FunctionName] existingFunctions = { f.name | f <- unpackAndParseFunctions().functions};
	for(/Var v := sa){
		if( [FunctionName]"<v>" notin existingFunctions){ errors += [error("undefined Function <v>", v@\loc)];}
	}
	if(/I_Invariants invs := sa){
		set[InvariantName] existingInvariants = { inv.name | inv <- unpackAndParseInvariants().invariants};
		errors += [ error("Undefined InvariantName <inv.name>",inv.name@\loc) | inv <- invs.invariants, inv.name notin existingInvariants]; 
	}
	return errors;
}