module alloy::changedproperties::Events

import alloy::changedproperties::Properties;
import alloy::changedproperties::Expressions;
import alloy::util::Info;
import alloy::util::ParseOptionals;
import grammar::Events;
import grammar::Lexical;
import ParseTree;
import List;


str notchangedproperties2alloy(Event e, EventMap em,str old,str new){
	Properties ps = notChangedProperties(e,em);
	str s = "//PROPERTY CONDITIONS \n<old>.balance in <new>.balance\n";
	return s + intercalate("\n",[ "<new>.<p> = <old>.<p>" | p <-ps]);
	
}

Properties notChangedProperties(Event e, EventMap em){
	Properties saProperties = { parse(#Var,"balance") , parse(#Var,"term") , parse(#Var,"startDate") ,parse(#Var,"payoutfreq")};
	return saProperties - changedProperties(e,em);
}

Properties changedProperties(Event e,EventMap em) = changedProperties(getPostCondition(e),em) when e.post?;
Properties changedProperties(Post post,EventMap em) = ({}|it+ changedProperties(cond,em) | cond <- post.postconditions);
Properties changedProperties((Cond)`<Expr exp>`,EventMap em) = changedProperties(exp);
Properties changedProperties((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,EventMap em) = changedProperties(em[name],em);
Properties changedProperties((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,EventMap em) = changedProperties(c,em);

