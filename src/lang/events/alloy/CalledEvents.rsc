module lang::events::alloy::CalledEvents

import lang::events::\syntax::Events;
import lang::savingsaccounts::\syntax::Lexical;
import lang::savingsaccounts::alloy::Expressions;
import lang::savingsaccounts::alloy::utils::Info;
import lang::events::alloy::properties::Properties;
import lang::events::alloy::Events;
import List;
import String;

str calledevents2alloy(list[Event] evs,EventMap em) =  intercalate("",[ calledevent2alloy(e,initInfo(e.sig.name,(),em)) | e <- evs]);
str calledevent2alloy(Event e,Info i){
	str res = "";
	if(/Pre pre := e)  res += calledprecond2alloy(pre,i);
	if(/Post post := e)  res += calledpostcond2alloy(post,i);
	return res;
}

str calledprecond2alloy(Pre pre, Info i) = ( "" | it+ calledcond2alloy(cond,i) | cond <- pre.preconditions);
str calledpostcond2alloy(Post post, Info i) = ( "" | it + calledcond2alloy(cond,i) | cond <- post.postconditions);

str calledcond2alloy((Cond)`<Expr exp>`, Info i) = "";
str calledcond2alloy((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,Info i) = calledcond2alloy(c,i);
str calledcond2alloy((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,Info i){
	EventName ename = [EventName]"<i.name>_<name>";
	VarMap vm = setVarMap(exprlist2list(eventargs),i.em[name]);
	Info newInfo = initInfo(ename,vm,i.em,i.p);
	return event2alloy(i.em[name],newInfo) + "\n";
} 