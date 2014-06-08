module lang::specifications::check::Specifications

import lang::specifications::\syntax::Specifications;
import lang::functions::\syntax::Functions;
import lang::functions::utils::Parse;
import lang::events::\syntax::Events;
import lang::events::utils::Parse;
import lang::invariants::\syntax::Invariants;
import lang::invariants::utils::Parse;

import IO;
import Message;
import ParseTree;

list[Message] check(Specification spec,loc folder){

	set[CustomType] importedtypes = { [CustomType]"<i.filename>" | i <- spec.imports.imports};
	list[Message] errors = [];
	
	errors += getUndeclaredImports(spec.imports,folder);
	errors += getUndeclaredTypeInFieldsErrors(spec.fields.fields, importedtypes);
	errors += getUndeclaredTypeInExtendsErrors(spec,importedtypes);
	errors += getUndeclaredInvariantsErrors(spec,folder);
	errors += getUndeclaredFunctionErrors(spec,folder);
	errors += getUndeclaredEventErrors(spec,folder);
	
	return errors;
}

list[Message] getUndeclaredImports(Imports imports, loc folder){
	return [ error("Class Not Found <i.filename> <folder + "<i.filename>.spec">",i.filename@\loc) | i <- imports.imports, !exists(folder + "<i.filename>.spec")];
}

list[Message] getUndeclaredTypeInFieldsErrors(FieldDecls fds, set[CustomType] importedTypes){
	return [ error("Undefined Type <d.t>", d.t@\loc) | d  <- fds.decls, customtype(ct) := d.t && ct notin importedTypes];
}

list[Message] getUndeclaredTypeInExtendsErrors(Specification spec, set[CustomType] importedTypes){
	if(/Extends e := spec.ext){ 
		if([CustomType]"<e.name>" notin importedTypes){
			return [ error("Class not Found <e.name>", e.name@\loc)];
		}
	}
	return [];
}

list[Message] getUndeclaredInvariantsErrors(Specification spec,loc folder){
	if(/InvariantInstances invs := spec){
		set[InvariantName] existingInvariants = { inv.name | inv <- unpackAndParseInvariants(folder.parent).invariants};
		return [ error("Undefined InvariantName <inv.name>",inv.name@\loc) | inv <- invs.invariants, inv.name notin existingInvariants]; 
	}
	return [];
}

list[Message] getUndeclaredFunctionErrors(Specification spec,loc folder){
	set[FunctionName] existingFunctions = { f.name | f <- unpackAndParseFunctions(folder.parent).functions};
	list[Message] errors =[];
	for(/Var v := spec){
		if([FunctionName]"<v>" notin existingFunctions){ 
			 errors += [error("undefined Function <v>", v@\loc)];
		}
	}
	return errors;
}

list[Message] getUndeclaredEventErrors(Specification spec,loc folder){
	set[EventName] existingEvents = { ev.sig.name | ev <- unpackAndParseEvents(folder.parent).events};
	return [ error("Undefined Event <e.name>", e.name@\loc) | e <- spec.evs.events, e.name notin existingEvents];
}
