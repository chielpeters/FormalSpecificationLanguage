module grammar::Statements

extend grammar::Expressions;

syntax Statement 
  = bracket "(" Statement ")"
  | ifstat: Expr "?" Statement ":" Statement
  | casestat: "case" Id "{" (Literal "=\>" Statement)+ "}" ";"
  | sumstat : "sum" "(" Expr "|" Type? Id "\<-" Expr ")" ";"
  | exprStat: Expr ";"
  ;  