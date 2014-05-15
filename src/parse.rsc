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

Events parseEvents(loc file) = parse(#start[Events],file);
Events parseEvents(str x, loc file) = parse(#start[Events],x,file);

Functions parseFunctions(loc file) = parse(#start[Functions],file);
Functions parseFunctions(str x, loc file) = parse(#start[Functions],x,file);
