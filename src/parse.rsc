module parse

import vis::Figure;
import vis::ParseTree;
import vis::Render;
import grammar::SavingsAccount;
import grammar::Events;
import grammar::Functions;
import ParseTree;

public void viewTree(Tree tree) = render(space(visParsetree(tree),std(gap(8,30)),std(resizable(true))));

SavingsAccount parseSavingsAccount(loc file) = parse(#SavingsAccount,file);
SavingsAccount parseSavingsAccount(str x, loc file) = parse(#SavingsAccount,x,file);

Events parseEvents(loc file){
	if(/Events e := parse(#start[Events],file)) return e;
	throw "Parse Error parseEvents file:<file>";
}
Events parseEvents(str x, loc file){
	if(/Events e := parse(#start[Events],x,file)) return e;
	throw "Parse Error parseEvents x: <x>, file: <file>";
}

Functions parseFunctions(loc file){
	if(/Functions f := parse(#start[Functions],file)) return f;
	throw "Parse Error parseFunctions file <file>";
}
Functions parseFunctions(str x, loc file){
	if(/Functions f := parse(#start[Functions],x,file)) return f;
	throw "Parse Error parseFunctions,x : <x> file: <file>";
}
