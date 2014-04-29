module alloy::Functions

import grammar::LibraryFunctions;
import alloy::Statements;
import alloy::Functions;
import String;

str function2alloy(Function f){
	return 	"fun <f.name>[<functionargs2alloy(f.args)>] : <type2alloy(f.rtype)> { \n  " +
	" <statement2alloy(f.s)> \n" +
	"}";
}

str functionargs2alloy((Arguments)`<Arguments args>`){
	return replaceLast((""| it + "<type2alloy(arg.t)> : <arg.var> ," | arg <- args.args),",","");
}




