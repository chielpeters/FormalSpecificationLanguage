module lang::events::ide::Events

import lang::events::utils::Parse;
import util::IDE;

str EVENTS_EXTENSION = "evs";
str EVENTS_LANGUAGE = "Events";

void registerEvents(){
	registerLanguage(EVENTS_LANGUAGE,EVENTS_EXTENSION,parseEvents);
}