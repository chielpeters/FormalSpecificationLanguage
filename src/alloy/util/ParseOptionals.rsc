module alloy::util::ParseOptionals

import ParseTree;
import grammar::Events;
import grammar::Lexical;

//TODO HOW TO REMOVE OPTIONAL
Post getPostCondition(Event e) = [Post]"<e.post>";// parse(#Post,"<e.post>");
Pre getPreCondition(Event e) = [Pre]"<e.pre>";
Parameters getParam(Event e) = [Parameters]"<e.param>";

//TODO how to make Lexicals/Syntax (Combine two names)
EventName getEventName(str name) = [EventName]name;