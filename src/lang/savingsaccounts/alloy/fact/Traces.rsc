module lang::savingsaccounts::alloy::fact::Traces

import lang::events::\syntax::Events;
import lang::savingsaccounts::alloy::fact::Events;
import lang::savingsaccounts::alloy::fact::Params;
import lang::savingsaccounts::alloy::utils::StringTemplates;

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