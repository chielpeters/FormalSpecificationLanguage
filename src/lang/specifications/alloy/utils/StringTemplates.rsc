module lang::specifications::alloy::utils::StringTemplates

import lang::specifications::\syntax::Specifications;

str getModuleName(SpecificationName name) = "module <name>\n";

str getNativeImports(SpecificationName name){
return "
	'open util/ordering[<name>]
	'open util/integer
	'open types/date
	'open types/period
	'open types/frequency
	'open types/percentage
	'";
}

str showCommand(SpecificationName name,Imports imports) = "run {} <getCommandScope(name,imports)>\n";
str getCommandScope(SpecificationName name, Imports imports) = 
	"for 5 <name>, <getCommandScope(imports)> exactly 5 Date, 8 Int, exactly 30 Percentage";

str getCommandScope(Imports imports) = ("" | it + " 5 <i.filename>" + " , " | i <- imports.imports);


str addComment(str com) = "// <com> \n";
str addMLComment(str com) = "/********************\n* <com>\n********************/\n\n";