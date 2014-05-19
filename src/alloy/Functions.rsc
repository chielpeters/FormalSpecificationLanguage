module alloy::Functions

import grammar::Functions;
import alloy::Statements;
import alloy::util::Info;
import alloy::TypesAndLiterals;
import String;
import List;

str functions2alloy(Functions functions, CalledFunctions cf) = ("" | it + function2alloy(f) + "\n\n" | f <- functions.functions, f.name in cf);

//Boolean Functions are predicates
str function2alloy((Function)`<FunctionName name> [ <Arguments args> ] : Boolean = <Statement s>`){
	return 	"pred <name>[<functionargs2alloy(args)>] {
	' <statement2alloy(s,())>
	'}";
}

str function2alloy(Function f){
	return 	"fun <f.name>[<functionargs2alloy(f.args)>] : <type2alloy(f.rtype)> {
	' <statement2alloy(f.s,())>
	'}";
}

str functionargs2alloy(Arguments args) = intercalate(", " ,["<arg.var> : <type2alloy(arg.t)>" | arg <- args.args]);





