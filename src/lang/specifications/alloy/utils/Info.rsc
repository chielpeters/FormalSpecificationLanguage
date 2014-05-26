module lang::specifications::alloy::utils::Info

import lang::specifications::\syntax::TypesAndLiterals;
import lang::specifications::\syntax::Expressions;
import lang::events::\syntax::Events;
import ParseTree;
import List;

alias VarMap = map[Var,Expr];
alias EventMap = map[EventName,Event];
alias Properties = set[Field];
alias Info = tuple[EventName name, VarMap vm, EventMap em,Properties p];

Info initInfo(EventName name, VarMap vm, EventMap em,Properties p) = <name, vm, em,p>;
Info initInfo(EventName name, list[Expr] args, EventMap em,Properties p) = <name,setVarMap(args,em[name]),em,p>;

Info addVars(Info i, VarMap vm) = <i.name, i.vm+vm, i.em,i.p>;
Info addProperties(Info i, Properties p) = <i.name,i.vm,i.em,i.p+p>;
Info changeEventName(EventName name,Info i) = <name,i.vm,i.em,i.p>;

EventMap getEventMap(Events events) = (event.sig.name : event | event <- events.events);

VarMap oldNow() = ( [Var]"now" : [Expr]"s.now", [Var]"this" : [Expr]"s");
VarMap thisNow() = ( [Var]"now" : [Expr]"this.now"); 

VarMap setVarMap(list[Expr] args, Event event){
	int i = 0;
	VarMap vm = thisNow();
	for(arg <- event.sig.args){
		if(i < size(args)){vm += (arg.var : args[i]);} else 
		if((EventArgument)`<Type t> <Var v> = <Expr exp>` := arg){ vm += (v : exp);}
		else throw "Event Variable is undefined <arg.var> in event <event.sig.name>";
		i+=1;
	}
	return vm;
}