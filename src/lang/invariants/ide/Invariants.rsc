module lang::invariants::ide::Invariants

import lang::invariants::utils::Parse;
import util::IDE;

str INVARIANTS_EXTENSION = "invs";
str INVARIANTS_LANGUAGE = "Invariants";

void registerInvariants(){
	registerLanguage(INVARIANTS_LANGUAGE,INVARIANTS_EXTENSION,parseInvariants);
}