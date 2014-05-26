module lang::specifications::\syntax::Fields

extend lang::specifications::\syntax::TypesAndLiterals;
extend lang::specifications::\syntax::Lexical;

syntax FieldDecls = FieldDecl* decls;

syntax FieldDecl = Field name ":" Type t;