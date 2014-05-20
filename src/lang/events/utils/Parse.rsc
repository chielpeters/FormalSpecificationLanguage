module lang::events::utils::Parse

import lang::events::\syntax::Events;
import ParseTree;

start[Events] parseEvents(loc file) = parse(#start[Events],file);
start[Events] parseEvents(str x, loc file) = parse(#start[Events],x,file);

Events unpackAndParseEvents(){
	loc file = |project://SavingsAccount/input/events/events.evs|;
	return parse(#start[Events],file).args[1];
}