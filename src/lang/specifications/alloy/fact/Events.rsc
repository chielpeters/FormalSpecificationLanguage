module lang::specifications::alloy::fact::Events

import lang::events::\syntax::Events;
import lang::specifications::alloy::fact::Params;
import List;

str events2alloy(list[Event] evs) = intercalate(" or ", [event2alloy(e) | e <- evs ]);

str event2alloy(Event e) = "<e.sig.name>[<eventparam2alloy(e)>]";

str eventparam2alloy(Event e){
	params = getParamNames(eventParamToList(e));
	return intercalate(", ", ["new","old"] + params);
}

