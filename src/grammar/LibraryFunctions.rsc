module grammar::LibraryFunctions

extend grammar::Statements;
extend grammar::Lexical;

start syntax Functions = 
  Function+ functions;

syntax Function = 
  FunctionName name "[" Arguments  args "]" ":" Type rtype "=" Statement s;

syntax Arguments = { Argument ","}* args;
syntax Argument = Type t Var var;


  


