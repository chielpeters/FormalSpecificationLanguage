module lang::specifications::alloy::utils::StringTemplates

import lang::specifications::\syntax::Specifications;

str getModuleName(SpecificationName name) = "module <name>\n";

str getImports(SpecificationName name){
return "
	'open util/ordering[<name>]
	'open util/integer
	'open types/date
	'open types/period
	'open types/frequency
	'open types/percentage
\n";
}

str predShow(SpecificationName name) = "pred show{} \nrun show <getCommandScope(name)>\n";
str getCommandScope(SpecificationName name) = "for 5 <name>, exactly 5 Date, 7 Int, exactly 128 Percentage";
str balancePropertyCondition(str old, str new) = "<old>.balance in <new>.balance";

str addComment(str com) = "// <com> \n";
str addMLComment(str com) = "/********************\n* <com>\n********************/\n\n";