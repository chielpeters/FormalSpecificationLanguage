module lang::events::alloy::properties::Expressions

import lang::specifications::\syntax::Expressions;
import lang::specifications::alloy::utils::Info;

Properties changedProperties((Expr)`this <Fields f>`) = first(f); 
Properties changedProperties((Expr)`this <Fields f> [<ExprList el>]`) = first(f); 
Properties changedProperties((Expr) `<Expr lhs> == <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> && <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> || <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties(Expr e) = {};

Properties first(Fields fields) = {[ f | /Field f <- fields.fields][0]};