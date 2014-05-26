module lang::events::alloy::properties::Expressions

import lang::specifications::\syntax::Expressions;

alias DeclaredFields = set[Field];

DeclaredFields changedFields(Expr e){
	DeclaredFields res = {};
	visit(e){ case /property(p) : res+= first(p.f);}
	return res;
}

DeclaredFields first(Fields fields) = {[ f | /Field f <- fields.fields][0]};