module lang::events::alloy::properties::Properties

import lang::events::alloy::properties::Expressions;
import lang::events::alloy::properties::LifeCycle;
import lang::specifications::alloy::utils::StringTemplates;
import lang::specifications::\syntax::Lexical;
import lang::specifications::\syntax::Fields;
import lang::events::\syntax::Events;
import List;

str notchangedproperties2alloy(Event e,FieldDecls decls,str old,str new){
	Properties ps = toProperties(decls) - changedProperties(e);
	str res = addComment("PROPERTY CONDITIONS") ;
	res += printLifeCycleProperty(e,old,new);
	return res + intercalate("\n",[ "<new>.<p> = <old>.<p>" | p <-ps]);
}

Properties changedProperties(Event e) = changedProperties(post) when /Post post := e.post;
Properties changedProperties(Event e) = {};
Properties changedProperties(Post post) = ({}|it+ changedProperties(cond) | cond <- post.postconditions.exprs);

Properties toProperties(FieldDecls decls) = ({} | it + decl.name | decl <- decls.decls); 