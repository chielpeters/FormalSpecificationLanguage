module alloy::util::Info

import grammar::TypesAndLiterals;
import grammar::Events;
import grammar::Expressions;
import ParseTree;
import List;

alias VarMap = map[Var,Expr];
alias EventMap = map[EventName,Event];
alias Info = tuple[EventName name, VarMap vm, EventMap em];

Info initInfo(EventName name, VarMap vm, EventMap em) = <name, vm, em>;
Info addVars(Info i, VarMap vm) = <i.name, i.vm+vm, i.em>;

Info changeEventName(EventName name,Info i) = <name,i.vm,i.em>;

EventMap getEventMap(Events events) = (event.sig.name : event | event <- events.events);

VarMap oldNow() = ( parse(#Var,"now") : parse(#Expr,"s.now"),parse(#Var,"this") : parse(#Expr,"s"));
VarMap thisNow() = ( parse(#Var,"now") : parse(#Expr,"this.now")); 

VarMap setVarMap(list[Expr] args, Event event){
	int i = 0;
	VarMap vm = thisNow();
	for(arg <- event.sig.args){
		if(i < size(args)){vm += (arg.var : args[i]);} else 
		if((EventArgument)`<Type t> <Var v> = <Expr exp>` := arg){ vm += (v : exp);}
		else throw "Event Variable is undefined <arg.var>";
		i+=1;
	}
	return vm;
}

//DEBUG
Info init(Event e) = <e.sig.name,(),(e.sig.name : e)>;

