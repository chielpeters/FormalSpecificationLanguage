module lang::functions::\syntax::Functions

extend lang::functions::\syntax::Statements;
extend lang::specifications::\syntax::Lexical;

start syntax Functions = Function+ functions;

syntax Function = @Foldable
  FunctionName name "[" Arguments  args "]" ":" Type rtype "=" Statement s;

syntax Arguments = { Argument ","}* args;
syntax Argument = Type t Var var;


  


