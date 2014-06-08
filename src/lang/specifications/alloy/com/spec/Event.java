package lang.specifications.alloy.com.spec;

import java.util.List;

public class Event {
	String EventName;
	List<String> Parameters;
	
	public Event(String name,List<String> list){
		this.EventName=name;
		this.Parameters=list;
	}
	
	@Override
	public String toString() {
	   return "DataObject [EventName=" + EventName + ", Parameters=" + Parameters + "]";
	}
}
