module lang::events::alloy::properties::Fields

import lang::events::alloy::properties::Expressions;
import lang::events::alloy::properties::LifeCycle;
import lang::specifications::alloy::utils::StringTemplates;
import lang::specifications::\syntax::Lexical;
import lang::specifications::\syntax::Fields;
import lang::events::\syntax::Events;
import List;

str notchangedfields2alloy(Event e,FieldDecls decls,str old,str new){
	DeclaredFields df = toSet(decls) - changedFields(e);
	str res = addComment("PROPERTY CONDITIONS") ;
	res += printLifeCycleFieldCondition(e,old,new);
	return res + intercalate("\n",[ "<new>.<p> = <old>.<p>" | p <-df]);
}

DeclaredFields changedFields(Event e) = changedFields(post) when /Post post := e.post;
DeclaredFields changedFields(Event e) = {};
DeclaredFields changedFields(Post post) = ({}|it+ changedFields(cond) | cond <- post.postconditions.exprs);

DeclaredFields toSet(FieldDecls decls) = ({} | it + decl.name | decl <- decls.decls); 