module alloy::Functions

import grammar::Functions;
import alloy::Statements;
import alloy::util::Info;
import alloy::TypesAndLiterals;
import String;
import List;

str functions2alloy(Functions functions){
	return ("" | it + function2alloy(f) + "\n\n" | f <- functions.functions);
}

//Boolean Functions are predicates
str function2alloy((Function)`<FunctionName name> [ <Arguments args> ] : Boolean = <Statement s>`){
	VarMap vm = ();
	return 	"pred <name>[<functionargs2alloy(args)>] { \n" +
	" <statement2alloy(s,vm)> \n" +
	"}";
}

str function2alloy(Function f){
	VarMap vm = ();
	return 	"fun <f.name>[<functionargs2alloy(f.args)>] : <type2alloy(f.rtype)> { \n  " +
	" <statement2alloy(f.s,vm)> \n" +
	"}";
}

str functionargs2alloy(Arguments args){
	return intercalate(", " , ["<arg.var> : <type2alloy(arg.t)>" | arg <- args.args]);
}




