module lang::functions::ide::Functions

import lang::functions::utils::Parse;
import util::IDE;

str FUNCTIONS_EXTENSION = "fns";
str FUNCTIONS_LANGUAGE = "Functions";

void registerFunctions(){
	registerLanguage(FUNCTIONS_LANGUAGE,FUNCTIONS_EXTENSION,parseFunctions);
}