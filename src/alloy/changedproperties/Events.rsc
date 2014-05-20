module alloy::changedproperties::Events

import alloy::changedproperties::Properties;
import alloy::changedproperties::Expressions;
import alloy::util::Info;
import grammar::Events;
import grammar::Lexical;
import ParseTree;
import List;


str notchangedproperties2alloy(Event e, EventMap em,str old,str new){
	Properties ps = notChangedProperties(e,em);
	str s = "//PROPERTY CONDITIONS \n<balancePropertyCondition(old,new)>";
	return s + intercalate("\n",[ "<new>.<p> = <old>.<p>" | p <-ps]);
	
}

Properties notChangedProperties(Event e, EventMap em){
	Properties saProperties = { [Field]"balance" , [Field]"term" , [Field]"startDate" ,[Field]"payoutfreq"};
	return saProperties - changedProperties(e,em);
}

Properties changedProperties(Event e,EventMap em) = changedProperties(post,em) when /Post post := e.post;
Properties changedProperties(Event e,EventMap em) = {};
Properties changedProperties(Post post,EventMap em) = ({}|it+ changedProperties(cond,em) | cond <- post.postconditions);
Properties changedProperties((Cond)`<Expr exp>`,EventMap em) = changedProperties(exp);
Properties changedProperties((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,EventMap em) = changedProperties(em[name],em);
Properties changedProperties((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,EventMap em) = changedProperties(c,em);

str balancePropertyCondition(str old, str new) = "<old>.balance in <new>.balance\n";