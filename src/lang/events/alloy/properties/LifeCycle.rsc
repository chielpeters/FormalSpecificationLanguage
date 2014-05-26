module lang::events::alloy::properties::LifeCycle

import lang::specifications::alloy::utils::Info;
import lang::specifications::\syntax::Lexical;
import Node;
import String;

data EventType = modifier() | open() | close();

EventType getEventType(EventName name) = open() when startsWith("<name>","open");
EventType getEventType(EventName name) = close() when startsWith("<name>","close");
EventType getEventType(EventName name) = modifier();

str printLifeCycleProperty(EventName name,str old, str new){
	EventType etype = getEventType(name);
	if(etype == EventType::modifier()) return "<old>.opened = 1 \n<new>.opened = <old>.opened\n";
	elseif(etype == EventType::open()) return "<new>.opened = 1 \n<old>.opened = 0\n";
	else return "<old>.opened = 1 \n<new>.opened = 0\n";  
}

Properties lifeCycleProperty(EventName name){
	EventType etype = getEventType(name);
	if( etype == EventType::modifier()) return {};
	else return {[Field]"opened"}; 
} 
