module alloy::Functions

import grammar::LibraryFunctions;
import alloy::Statements;

str function2alloy(Function f){
	return 	"fun <f.name>(<for (arg <- f.args) {><functionarg2alloy(arg)><}>) : <f.rtype> { \n  " +
	" <statement2alloy(f.s)> \n" +
	"}";
}

str functionarg2alloy(Argument arg){
	return "<arg.var> : <arg.t>";
}




