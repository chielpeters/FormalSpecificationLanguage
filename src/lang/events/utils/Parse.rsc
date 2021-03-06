module lang::events::utils::Parse

import lang::events::\syntax::Events;
import ParseTree;

start[Events] parseEvents(loc file) = parse(#start[Events],file);
start[Events] parseEvents(str x, loc file) = parse(#start[Events],x,file);

Events unpackAndParseEvents(){
	loc file = |project://FormalSpecificationLanguage/input/events/events.evs|;
	return parse(#start[Events],file).args[1];
}

Events unpackAndParseEvents(loc folder){
	return parse(#start[Events],folder+"events/events.evs").args[1];
}