module alloy::fact::Traces

import grammar::Events;
import alloy::fact::Events;
import alloy::fact::Params;

str fact2alloy(list[Event] evs){
return "fact traces {
	'  all s: SavingsAccount - last | let s\' = next[s]{
	'    advance[s.now,s\'.now]
	'    <vardecl2alloy(evs)> <events2alloy(evs)>
	'  }
	'}\n";
}