module grammar::Invariants

extend grammar::Lexical;
extend grammar::Expressions;

start syntax Invariants = Invariant* invariants;
syntax Invariant = @Foldable "Invariant" InvariantName name "{" InvariantDecl decl "}";
syntax InvariantDecl = Scope* scope Expr e;
syntax Scope = Quant Decl "|";
syntax Quant = "all" | "no" | "some" | "lone" | "one";
syntax Decl = Var v ":" Expr e;
