module alloy::changedproperties::Expressions

import grammar::Expressions;

Properties changedProperties((Expr) `(<Expr e>)`) = changedProperties(e);


Properties changedProperties((Expr)`this <Fields f>`) = first(f); 
Properties changedProperties((Expr)`this <Fields f> [<ExprList el>]`) = first(f); 
Properties changedProperties((Expr) `<PropertyOfVar pv>`) = {};
Properties changedProperties((Expr) `old <PropertyOfVar p>`) = {};
Properties changedProperties((Expr) `<Literal l>`) = literal2alloy(l);

Properties changedProperties((Expr) `{ <Expr lhs> ... <Expr rhs> }`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<FunctionName name> [ <ExprList expressions> ]`) = {};
Properties changedProperties((Expr) `! <Expr e>`) = changedProperties(e);
Properties changedProperties((Expr) `<Expr lhs> in <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> * <Expr rhs>`) = changedProperties(lhs)  + changedProperties(rhs) ;
Properties changedProperties((Expr) `<Expr lhs> / <Expr rhs>`) = changedProperties(lhs)  + changedProperties(rhs) ;
Properties changedProperties((Expr) `<Expr lhs> % <Expr rhs>`) = changedProperties(lhs)  + changedProperties(rhs) ;
Properties changedProperties((Expr) `<Expr lhs> + <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs) ;
Properties changedProperties((Expr) `<Expr lhs> - <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs) ;
Properties changedProperties((Expr) `<Expr lhs> \< <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> \<= <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> \> <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> \>= <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> == <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> != <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> && <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties((Expr) `<Expr lhs> || <Expr rhs>`) = changedProperties(lhs) + changedProperties(rhs);
Properties changedProperties(Expr e) = {};
Properties first(Fields fields) = {[ f.f | DotField f <- fields.fields][0]}; 