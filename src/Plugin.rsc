module Plugin

import lang::events::ide::Events;
import lang::functions::ide::Functions;
import lang::invariants::ide::Invariants;
import lang::specifications::ide::Specifications;
import util::IDE;

void main(){
	registerEvents();
	registerFunctions();
	registerInvariants();
	registerSpecifications();
}

void reset(){
	clearLanguages();
	main();
}