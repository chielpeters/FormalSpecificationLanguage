module lang::specifications::alloy::fact::Traces

import lang::events::\syntax::Events;
import lang::specifications::alloy::fact::Events;
import lang::specifications::alloy::fact::Params;
import lang::specifications::alloy::utils::StringTemplates;

str fact2alloy(list[Event] evs,SpecificationName name){
return "fact traces {
	'  all old: <name> - last | let new = next[old]{
	'    first.opened = 0
	'    <vardecl2alloy(evs)> <events2alloy(evs)>
	'  }
	'}\n";
}

//advance[old.now,new.now]
//<balancePropertyCondition("old","new")> && #new.balance = add[#old.balance,1]