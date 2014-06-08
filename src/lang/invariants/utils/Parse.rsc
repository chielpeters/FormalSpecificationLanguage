module lang::invariants::utils::Parse

import lang::invariants::\syntax::Invariants;
import ParseTree;

start[Invariants] parseInvariants(loc file) = parse(#start[Invariants],file);
start[Invariants] parseInvariants(str x,loc file) = parse(#start[Invariants],x,file);

Invariants unpackAndParseInvariants(){
	loc file = |project://FormalSpecificationLanguage/input/invariants/invariants.invs|;
	return parse(#start[Invariants],file).args[1];
}

Invariants unpackAndParseInvariants(loc folder){
	return parse(#start[Invariants],folder + "invariants/invariants.invs").args[1];
}