module lang::savingsaccounts::utils::Parse

import lang::savingsaccounts::\syntax::SavingsAccount;
import ParseTree;

SavingsAccount parseSavingsAccount(loc file) = parse(#SavingsAccount,file);
SavingsAccount parseSavingsAccount(str x, loc file) = parse(#SavingsAccount,x,file);
SavingsAccount parseSavingsAccount() = parse(#SavingsAccount,|project://SavingsAccount/input/savingsaccounts/TopRekening.sa|);
