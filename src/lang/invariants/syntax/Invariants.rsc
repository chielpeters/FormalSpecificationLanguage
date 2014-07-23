module lang::invariants::\syntax::Invariants

extend lang::specifications::\syntax::Lexical;
extend lang::specifications::\syntax::Expressions;

start syntax Invariants = Invariant* invariants;
syntax Invariant = @Foldable "Invariant" InvariantName name "{" QuantifiedDecl decl "}";
