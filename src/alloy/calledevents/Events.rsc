module alloy::calledevents::Events

import grammar::Events;
import grammar::Lexical;
import alloy::util::ParseOptionals;
import alloy::Expressions;
import alloy::util::Info;
import alloy::Events;
import List;
import String;

str calledevents2alloy(list[Event] evs,EventMap em) =  intercalate("\n",[ calledevent2alloy(e,initInfo(e.sig.name,(),em)) | e <- evs]);
str calledevent2alloy(Event e,Info i) =  calledpre2alloy(e,i) + calledpost2alloy(e,i);

str calledpre2alloy(Event e,Info i) = calledprecond2alloy(getPreCondition(e),i) when !isEmpty("<e.pre>");
str calledpre2alloy(Event e,Info i) = "";

str calledpost2alloy(Event e,Info i) = calledpostcond2alloy(getPostCondition(e),i) when !isEmpty("<e.post>");
str calledpost2alloy(Event e,Info i) = "";

str calledprecond2alloy(Pre pre, Info i) = ( "" | it+ calledcond2alloy(cond,i) | cond <- pre.preconditions);
str calledpostcond2alloy(Post post, Info i) = ( "" | it + calledcond2alloy(cond,i) | cond <- post.postconditions);

str calledcond2alloy((Cond)`<Expr exp>`, Info i) = "";
str calledcond2alloy((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,Info i){
	EventName ename = getEventName("<i.name>_<name>");
	VarMap vm = setVarMap(exprlist2list(eventargs),i.em[name]);
	Info newInfo = initInfo(ename,vm,i.em);
	return event2alloy(i.em[name],newInfo) + "\n";
} 
str calledcond2alloy((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,Info i) = calledcond2alloy(c,i);
