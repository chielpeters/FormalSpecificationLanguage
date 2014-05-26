module lang::functions::utils::Parse

import lang::functions::\syntax::Functions;
import ParseTree;

start[Functions] parseFunctions(loc file) = parse(#start[Functions],file);
start[Functions] parseFunctions(str x, loc file) = parse(#start[Functions],x,file);

Functions unpackAndParseFunctions(){
	loc file = |project://FormalspecifcationLanguage/input/functions/functions.fns|;
	return parse(#start[Functions],file).args[1];
}