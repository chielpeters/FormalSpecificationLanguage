module alloy::fact::Traces

import grammar::Events;
import alloy::fact::Events;
import alloy::fact::Params;
import alloy::util::StringTemplates;

str fact2alloy(list[Event] evs){
return "fact traces {
	'  all old: SavingsAccount - last | let new = next[old]{
	'    advance[old.now,new.now]
	'    <balancePropertyCondition("old","new")>
	'    first.opened = 0
	'    <vardecl2alloy(evs)> <events2alloy(evs)>
	'  }
	'}\n";
}