module alloy::changedproperties::Expressions

import grammar::Expressions;
import alloy::changedproperties::Properties;

Properties changedProperties((Expr) `(<Expr e>)`) = changedProperties(e);
Properties changedProperties((Expr)`this <Fields f>`) = first(f); 
Properties changedProperties((Expr)`this <Fields f> [<ExprList el>]`) = first(f); 
Properties changedProperties((Expr) `<Expr lhs> == <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties(Expr e) = {};

Properties first(Fields fields) = {[ f.f | DotField f <- fields.fields][0]}; 

//DEBUG
str printset(set[Var] v) = ("" | it + " " + "<f>" | f<-v);