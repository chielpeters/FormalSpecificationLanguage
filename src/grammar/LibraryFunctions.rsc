module grammar::LibraryFunctions

extend grammar::Statements;
extend grammar::Lexical;

start syntax Functions = 
  Function+ functions;

syntax Function = 
  FunctionName name "[" { Argument ","}* args "]" ":" Type rtype "=" Statement s;

syntax Argument = Type t Var var;


  


