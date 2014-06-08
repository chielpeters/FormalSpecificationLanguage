module lang::specifications::alloy::Signature

import lang::specifications::\syntax::TypesAndLiterals;
import lang::specifications::alloy::TypesAndLiterals;
import lang::specifications::\syntax::Fields;
import lang::specifications::\syntax::Lexical;
import List;


str signature2alloy(SpecificationName name, FieldDecls decls){
	list[FieldDecl] fdecls = [ f | f <- decls.decls] + [FieldDecl]"opened : Integer";
	return "sig <name> {
  	'  <intercalate(",\n",[field2alloy(f) | f <- fdecls])> 
  	'}\n\n";
}

str signature2alloy(SpecificationName name, FieldDecls decls, SpecificationName extends){
	list[FieldDecl] fdecls = [ f | f <- decls.decls] + [FieldDecl]"opened : Integer";
	return "sig <name> extends <extends>{
  	'  <intercalate(",\n",[field2alloy(f) | f <- fdecls])> 
  	'}\n\n";
}

str field2alloy(FieldDecl field) = "<field.name> : <fieldtype2alloy(field.t)>";

str fieldtype2alloy(t:(Type)`Integer`) = "one " + type2alloy(t);
str fieldtype2alloy(t:(Type)`Date`) = "one " + type2alloy(t);
str fieldtype2alloy(t:(Type)`Period`) = "one " + type2alloy(t);
str fieldtype2alloy(t:(Type)`Percentage`) = "one " + type2alloy(t);
str fieldtype2alloy(t:(Type)`<Type t1> -\> <Type t2>`) = "<type2alloy(t1)> -\> lone <type2alloy(t2)>"; 
str fieldtype2alloy(t:(Type)`map[<Type key> : <Type val>]`) = "<type2alloy(key)> -\> lone <type2alloy(val)>";
str fieldtype2alloy(t:(Type)`list[ <Type ta>]`) = "seq <type2alloy(ta)>";
str fieldtype2alloy(t:(Type)`set[ <Type ta>]`) = "set <type2alloy(ta)>";
str fieldtype2alloy(t:(Type)`Freq`) = "one " + type2alloy(t);
str fieldtype2alloy(t:(Type)`<CustomType ta>`) = "one " + "<ta>";
str fieldtype2alloy(Type t){throw "uncaught fieldtype <t>";}