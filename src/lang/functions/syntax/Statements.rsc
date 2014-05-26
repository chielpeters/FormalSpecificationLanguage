module lang::functions::\syntax::Statements

extend lang::specifications::\syntax::Expressions;

syntax Statement 
  = bracket "(" Statement ")"
  | ifstat: Expr "?" Statement ":" Statement
  | casestat: "case" Expr "{" Case+ cases "}" ";"
  | sumstat : "sum" "(" Expr "|" Var "\<-" Expr ")" ";"
  | exprStat: Expr ";"
  ;  
  
  syntax Case = Literal lit "=\>" Statement s;