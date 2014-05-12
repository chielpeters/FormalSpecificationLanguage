module alloy::changedproperties::Events

import alloy::changedproperties::Properties;
import alloy::VarMap;
import grammar::Events;

Properties changedProperties(Event e,EventMap em){

	if((Event)`<Signature sig> <Parameters param> <Pre pre> <Post post>` := e){
		return changeProperties(pre) + changeProperties(post);
	}
	else if((Event)`<Signature sig> <Parameters param> <Pre pre>` := e){
		return changeProperties(pre);
	}
	else if((Event)`<Signature sig> <Parameters param> <Post post>` := e){
		return changeProperties(post);
	}
	return {};
}

Properties changedProperties(Pre pre,EventMap em) = { changedProperties(cond) | cond <- pre.preconditions};
Properties changedProperties(Post post,EventMap em) = { changedProperties(cond) | cond <- post.postconditions};

Properties changedProperties((Cond)`<Expr exp>`,EventMap em) = changedProperties(exp);
Properties changedProperties((Cond)`<EventName name> (<ExprList eventargs> ) [ <ExprList param> ]`,EventMap em) = changedProperties(name,em);
Properties changedProperties((Cond)`( <Cond c> | <Var v> \<- <Expr e> )`,EventMap em) = changedProperties(c);