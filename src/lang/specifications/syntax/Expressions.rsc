module lang::specifications::\syntax::Expressions

extend lang::specifications::\syntax::TypesAndLiterals;
extend lang::specifications::\syntax::Lexical;


syntax Expr
  = bracket "(" Expr ")"
  > left (
  	quantexpr : QuantifiedDecl
  )
  > non-assoc (	
    var : Var
    | functioncall : FunctionName "[" ExprList "]"
    | property: PropertyOfVar
    | oldproperty: "old" PropertyOfVar
    | literal: LiteralPlus
    | makeSet: "{" Expr "..." Expr "}"
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
    
syntax Fields = ("." Field)+ fields;
syntax ExprList = {Expr ","}* exprs;

syntax LiteralPlus =
  lit: Literal 
  | mapLit: "("  MapElements ")"
  | listLit: "[" ExprList  "]"
  | setLit: "{" ExprList "}"
  ;

syntax MapElements = {MapElement ","}* elems;
syntax MapElement = Expr key ":" Expr val;

syntax QuantifiedDecl = Scope+ scope "{" Expr e "}";
syntax Scope = Quant q Decl d "|";
syntax Quant = "all" | "no" | "some" | "lone" | "one";
syntax Decl = Var v ":" Expr e;
