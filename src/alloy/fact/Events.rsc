module alloy::fact::Events

import grammar::Events;
import alloy::fact::Params;
import List;

str events2alloy(list[Event] evs) = intercalate(" or ", [event2alloy(e) | e <- evs ]);

str event2alloy(Event e) = "<e.sig.name>[<eventparam2alloy(e)>]";

str eventparam2alloy(Event e){
	params = getParamNames(eventParamToList(e));
	return intercalate(", ", ["s","s\'"] + params);
}

