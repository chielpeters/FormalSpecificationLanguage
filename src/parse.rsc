module parse

import vis::Figure;
import vis::ParseTree;
import vis::Render;
import grammar::SavingsAccount;
import grammar::Events;
import grammar::Functions;
import grammar::Invariants;
import ParseTree;

public void viewTree(Tree tree) = render(space(visParsetree(tree),std(gap(8,30)),std(resizable(true))));

SavingsAccount parseSavingsAccount(loc file) = parse(#SavingsAccount,file);
SavingsAccount parseSavingsAccount(str x, loc file) = parse(#SavingsAccount,x,file);
SavingsAccount parseSavingsAccount() = parse(#SavingsAccount,|file:///C:/Users/Chiel/Dropbox/Thesis/SavingsAccount/input/savingsaccounts/TopRekening.sa|);

start[Events] parseEvents(loc file) = parse(#start[Events],file);
start[Events] parseEvents(str x, loc file) = parse(#start[Events],x,file);

start[Functions] parseFunctions(loc file) = parse(#start[Functions],file);
start[Functions] parseFunctions(str x, loc file) = parse(#start[Functions],x,file);

start[Invariants] parseInvariants(loc file) = parse(#start[Invariants],file);
start[Invariants] parseInvariants(str x,loc file) = parse(#start[Invariants],x,file);


Events unpackAndParseEvents(){
	loc file = |file:///C:/Users/Chiel/Dropbox/Thesis/SavingsAccount/input/events/events.evs|;
	return parse(#start[Events],file).args[1];
}

Functions unpackAndParseFunctions(){
	loc file = |file:///C:/Users/Chiel/Dropbox/Thesis/SavingsAccount/input/functions/functions.fns|;
	return parse(#start[Functions],file).args[1];
}

Invariants unpackAndParseInvariants(){
	loc file = |file:///C:/Users/Chiel/Dropbox/Thesis/SavingsAccount/input/invariants/invariants.invs|;
	return parse(#start[Invariants],file).args[1];
}


