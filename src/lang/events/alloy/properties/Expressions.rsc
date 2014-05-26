module lang::events::alloy::properties::Expressions

import lang::specifications::\syntax::Expressions;

alias Properties = set[Field];

Properties changedProperties(Expr e){
	Properties res = {};
	visit(e){ case /property(p) : res+= first(p.f);}
	return res;
}

Properties first(Fields fields) = {[ f | /Field f <- fields.fields][0]};