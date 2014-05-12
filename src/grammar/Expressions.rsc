module grammar::Expressions

extend grammar::TypesAndLiterals;
extend grammar::Lexical;

syntax Expr
  = bracket "(" Expr ")"
  > non-assoc (	
    property: PropertyOfVar
    | oldproperty: "old" PropertyOfVar
    | literal: Literal
    | makeSet: "{" Expr "..." Expr "}"
    | functioncall: FunctionName "[" ExprList "]"
  )
  > not: "!" Expr
  > left (
    mul: Expr lhs "*" Expr rhs
    | inset: Expr "in" Expr
    | div: Expr "/" Expr
    | modulo: Expr "%" Expr
  )
  > left (
    add: Expr "+" Expr
    | sub: Expr "-" Expr
  )
  > non-assoc (
    lt: Expr "\<" Expr
    | leq: Expr "\<=" Expr
    | gt: Expr "\>" Expr
    | geq: Expr "\>=" Expr
    | eq: Expr "==" Expr
    | neq: Expr "!=" Expr
  )
  > left and: Expr "&&" Expr
  > left or: Expr "||" Expr
  ;
  
syntax PropertyOfVar = 
    propertyOfVar : Var var Fields f
    | propertyOfVar : Var var Fields f "[" ExprList "]"
    ;
    
syntax Fields = DotField+ fields;
syntax DotField = "." Var f;
syntax ExprList = {Expr ","}* exprs;