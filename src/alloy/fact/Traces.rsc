module alloy::fact::Traces

import grammar::Events;
import alloy::fact::Events;
import alloy::fact::Params;

str fact2alloy(list[Event] evs){
return "fact traces {
	'  all old: SavingsAccount - last | let new = next[old]{
	'    advance[old.now,new.now]
	'    <vardecl2alloy(evs)> <events2alloy(evs)>
	'  }
	'}\n";
}