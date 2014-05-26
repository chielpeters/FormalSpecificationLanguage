module lang::specifications::alloy::fact::Params

import lang::events::\syntax::Events;
import lang::specifications::\syntax::TypesAndLiterals;
import lang::specifications::alloy::TypesAndLiterals;
import List;
import String;

str vardecl2alloy(list[Event] evs){
	p = sort(getParameters(evs));
	if(!isEmpty(p)){ return "some " + generateVarDecl(p,getParamNames(p)) + " | ";} else return "";
}

str generateVarDecl(list[Type] types, list[str] names) = intercalate(", ",[ "<n> : <type2alloy(t)>" | <n,t> <- zip(names,types)]);

list[Type] getParameters(list[Event] evs) = unionLists(([[]] | it + [eventParamToList(e)] | e <- evs));
list[Type] unionLists(list[list[Type]] lists) = ([] | it - paramList + paramList | paramList <- lists);
list[Type] eventParamToList(Event e) = (/Parameters p := e) ? [ arg.t | Argument arg <- p.args.args] : [];
list[Type] sort(list[Type] params) = sort(params, bool (Type a, Type b){ return "<a>" < "<b>";});


list[str] getParamNames(list[Type] params) = ([] | it + type2str(p, countBefore(p,params,i)) | <p,i> <- zip(params,[0..size(params)]));
str type2str(Type t, int i) = i == 0 ? toLowerCase("<t>"[0]) : toLowerCase("<t>"[0]) + "<i>";

int countBefore(&T elem, list[&T] l, int index) = count(elem,slice(l,0,index));
int count(&T elem, list[&T] l) = ( 0 | it + 1 | e <- l, e == elem);



