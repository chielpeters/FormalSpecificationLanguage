module lang::savingsaccounts::ide::SavingsAccounts

import lang::savingsaccounts::\syntax::SavingsAccount;
import lang::savingsaccounts::check::SavingsAccounts;
import lang::savingsaccounts::alloy::SavingsAccount;
import lang::savingsaccounts::utils::Parse;
import util::IDE;
import Message;
import ParseTree;
import List;


str SAVINGSACCOUNT_EXTENSION = "sa";
str SAVINGSACCOUNT_LANGUAGE = "SavingsAccount";

void registerSavingsAccount(){
	registerLanguage(SAVINGSACCOUNT_LANGUAGE,SAVINGSACCOUNT_EXTENSION,parseSavingsAccount);
	registerAnnotator(SAVINGSACCOUNT_LANGUAGE, checkAndAnnotate);
	contribs = {
	popup(
		menu(SAVINGSACCOUNT_LANGUAGE,[
	    	action("Generate Alloy", generateAlloy),
	    	action("Generate and Start Alloy", generateAndStartAlloy)
		])
	)
	};
	registerContributions(SAVINGSACCOUNT_LANGUAGE, contribs);
}

SavingsAccount checkAndAnnotate(SavingsAccount sa){
	return sa[@messages = toSet(check(sa))];
}

void generateAlloy(SavingsAccount sa, loc l){
	savingsaccount2alloy(sa,false);
}

void generateAndStartAlloy(SavingsAccount sa, loc l){
	generateAlloy(sa,l);
	loc location = |project://SavingsAccount/output/| + "<sa.name>.als";
	startAlloy(location);
	
}

@javaClass{lang.savingsaccounts.alloy.com.sa.Alloy}
public java void startAlloy(loc l);