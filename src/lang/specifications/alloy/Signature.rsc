module lang::specifications::alloy::Signature

import lang::specifications::\syntax::TypesAndLiterals;
import lang::specifications::\syntax::Fields;
import lang::specifications::\syntax::Lexical;
import List;


str signature2alloy(SpecificationName name, FieldDecls decls){
return "sig <name> {
  '  <intercalate("\n",[field2alloy(f) | f <- decls.decls])> 
  '}";
}

str field2alloy(FieldDecl field) = "<field.name> : <type2alloy(field.t)>";

str type2alloy((Type)`Integer`) = "one Int";
str type2alloy((Type)`Date`) = "one Date";
str type2alloy((Type)`Period`) = "one Period";
str type2alloy((Type)`Percentage`) = "one Percentage";
str type2alloy((Type)`map[<Type key> : <Type val>]`) = "<type2alloy(key)> -\> lone <type2alloy(val)>";
str type2alloy((Type)`list[ <Type t>]`) = "seq <type2alloy(t)>";
str type2alloy((Type)`set[ <Type t>]`) = "set <type2alloy(t)>";
str type2alloy((Type)`Freq`) = "one Frequency";