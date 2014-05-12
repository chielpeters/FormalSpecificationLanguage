module alloy::changedproperties::Events

import alloy::changedproperties::Properties;
import alloy::changedproperties::Expressions;
import alloy::VarMap;
import grammar::Events;
import ParseTree;

import ParseTree;
import grammar::Lexical;

Properties notChangedProperties(Event e, EventMap em){
	Properties saProperties = { parse(#Var,"balance") , parse(#Var,"term") , parse(#Var,"startDate") ,parse(#Var,"payoutfreq")};
	return saProperties - changedProperties(e,em);
}

Properties changedProperties(Event e,EventMap em) = changedProperties(getPostCondition(e),em) when e.post?;
Properties changedProperties(Post post,EventMap em) = ({}|it+ changedProperties(cond,em) | cond <- post.postconditions);
Properties changedProperties((Cond)`<Expr exp>`,EventMap em) = changedProperties(exp);
Properties changedProperties((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,EventMap em) = changedProperties(name,em);
Properties changedProperties((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,EventMap em) = changedProperties(c,em);

//TODO HOW TO REMOVE OPTIONAL
Post getPostCondition(Event e) = parse(#Post,"<e.post>");