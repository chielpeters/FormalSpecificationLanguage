module registerIDE

import parse;
import util::IDE;
import alloy::SavingsAccount;
import grammar::SavingsAccount;

void registerAll(){
	registerSavingsAccount();
	registerEvents();
	registerFunctions();
}

/**************************************************
* SAVINGSACCOUNTS
**************************************************/
str SAVINGSACCOUNT_EXTENSION = "sa";
str SAVINGSACCOUNT_LANGUAGE = "SavingsAccount";

void registerSavingsAccount(){
	registerLanguage(SAVINGSACCOUNT_LANGUAGE,SAVINGSACCOUNT_EXTENSION,parseSavingsAccount);
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

void generateAlloy(SavingsAccount sa, loc l){
	savingsaccount2alloy(sa,false);
}

void startAlloy(SavingsAccount sa, loc l){
	generateAlloy(sa,l);
	str location = "C:/Users/Chiel/Dropbox/Thesis/Alloy";
	location += "/<sa.sig.nam>.als";
	startAlloy(location);
	
}

@javaClass{com.sa.Alloy}
public java void startAlloy(str t);

/**************************************************
* EVENTS
**************************************************/
str EVENTS_EXTENSION = "events";
str EVENTS_LANGUAGE = "Events";

void registerEvents(){
	registerLanguage(EVENTS_LANGUAGE,EVENTS_EXTENSION,parseEvents);
}

/**************************************************
* EVENTS
**************************************************/
str FUNCTIONS_EXTENSION = "functions";
str FUNCTIONS_LANGUAGE = "Functions";

void registerFunctions(){
	registerLanguage(FUNCTIONS_LANGUAGE,FUNCTIONS_EXTENSION,parseFunctions);
}
