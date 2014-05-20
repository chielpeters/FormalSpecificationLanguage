module ide::RegisterIDE

import parse;
import List;
import util::IDE;
import ParseTree;
import Message;
import check::check;
import alloy::SavingsAccount;
import grammar::SavingsAccount;

void registerAll(){
	registerSavingsAccount();
	registerEvents();
	registerFunctions();
	registerInvariants();
}

/**************************************************
* SAVINGSACCOUNTS
**************************************************/
str SAVINGSACCOUNT_EXTENSION = "sa";
str SAVINGSACCOUNT_LANGUAGE = "SavingsAccount";

void registerSavingsAccount(){
	registerLanguage(SAVINGSACCOUNT_LANGUAGE,SAVINGSACCOUNT_EXTENSION,parseSavingsAccount);
	registerAnnotator(SAVINGSACCOUNT_LANGUAGE, checkAndAnnotate);
	contribs = {
	popup(
		menu(SAVINGSACCOUNT_LANGUAGE,[
	    	action("Generate Alloy", generateAlloy),
	    	action("Generate and Start Alloy", startAlloy)
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

void startAlloy(SavingsAccount sa, loc l){
	generateAlloy(sa,l);
	str location = "C:/Users/Chiel/Dropbox/public";
	location += "/<sa.name>.als";
	startAlloy(location);
	
}

@javaClass{com.sa.Alloy}
public java void startAlloy(str t);

/**************************************************
* EVENTS
**************************************************/
str EVENTS_EXTENSION = "evs";
str EVENTS_LANGUAGE = "Events";

void registerEvents(){
	registerLanguage(EVENTS_LANGUAGE,EVENTS_EXTENSION,parseEvents);
}

/**************************************************
* EVENTS
**************************************************/
str FUNCTIONS_EXTENSION = "fns";
str FUNCTIONS_LANGUAGE = "Functions";

void registerFunctions(){
	registerLanguage(FUNCTIONS_LANGUAGE,FUNCTIONS_EXTENSION,parseFunctions);
}

/**************************************************
* INVARIANTS
**************************************************/

str INVARIANTS_EXTENSION = "invs";
str INVARIANTS_LANGUAGE = "Invariants";

void registerInvariants(){
	registerLanguage(INVARIANTS_LANGUAGE,INVARIANTS_EXTENSION,parseInvariants);
}
