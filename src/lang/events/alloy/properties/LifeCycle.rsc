module lang::events::alloy::properties::LifeCycle

import lang::specifications::alloy::utils::Info;
import lang::specifications::\syntax::Lexical;
import lang::events::\syntax::Events;
import Node;
import String;

data EventType = modifier() | open() | close();

EventType getEventType(Event e) = open() when /LifeCycleType t := e && "<t>" == "initial";
EventType getEventType(Event e) = close() when /LifeCycleType t := e && "<t>" == "final";
EventType getEventType(Event e) = modifier();

str printLifeCycleProperty(Event e,str old, str new){
	EventType etype = getEventType(e);
	if(etype == EventType::modifier()) return "<old>.opened = 1 \n<new>.opened = <old>.opened\n";
	elseif(etype == EventType::open()) return "<new>.opened = 1 \n<old>.opened = 0\n";
	else return "<old>.opened = 1 \n<new>.opened = 0\n";  
}
