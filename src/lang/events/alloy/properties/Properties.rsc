module lang::events::alloy::properties::Properties

import lang::events::alloy::properties::Expressions;
import lang::events::alloy::properties::LifeCycle;
import lang::specifications::alloy::utils::Info;
import lang::specifications::alloy::utils::StringTemplates;
import lang::specifications::\syntax::Lexical;
import lang::events::\syntax::Events;
import List;

//TODO REFACTOR
str notchangedproperties2alloy(Event e, EventMap em,Properties prev_props,str old,str new){
	Properties ps = notChangedProperties(e,em);
	str res = addComment("PROPERTY CONDITIONS") ;
	if([Field]"opened" notin prev_props) res += printLifeCycleProperty(e.sig.name,old,new);
	return res + intercalate("\n",[ "<new>.<p> = <old>.<p>" | p <-ps, p notin prev_props]);
}

Properties notChangedProperties(Event e, EventMap em){
	Properties saProperties = { [Field]"balance" , [Field]"term" , [Field]"startDate" ,[Field]"payoutfreq"};
	return saProperties - changedProperties(e,em);
}

Properties changedProperties(Event e,EventMap em) = lifeCycleProperty(e.sig.name) + changedProperties(post,em) when /Post post := e.post;
Properties changedProperties(Event e,EventMap em) = lifeCycleProperty(e.sig.name);
Properties changedProperties(Post post,EventMap em) = ({}|it+ changedProperties(cond,em) | cond <- post.postconditions);
Properties changedProperties((Cond)`<Expr exp>`,EventMap em) = changedProperties(exp);
Properties changedProperties((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,EventMap em) = changedProperties(em[name],em);
Properties changedProperties((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,EventMap em) = changedProperties(c,em);


