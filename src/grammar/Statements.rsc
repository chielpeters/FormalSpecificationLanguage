module grammar::Statements

extend grammar::Expressions;

syntax Statement 
  = bracket "(" Statement ")"
  | ifstat: Expr "?" Statement ":" Statement
  | casestat: "case" Expr "{" Case+ cases "}" ";"
  | sumstat : "sum" "(" Expr "|" Var "\<-" Expr ")" ";"
  | exprStat: Expr ";"
  ;  
  
  syntax Case = Literal lit "=\>" Statement s;