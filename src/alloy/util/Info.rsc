module alloy::util::Info

import grammar::TypesAndLiterals;
import grammar::Events;
import grammar::Expressions;
import ParseTree;
import List;

alias VarMap = map[Var,Expr];
alias EventMap = map[EventName,Event];
alias Info = tuple[EventName name, VarMap vm, EventMap em,Properties p];
alias CalledFunctions = set[FunctionName];
alias Properties = set[Field];

Info initInfo(EventName name, VarMap vm, EventMap em,Properties p) = <name, vm, em,p>;
Info initInfo(EventName name, list[Expr] args, EventMap em,Properties p) = <name,setVarMap(args,em[name]),em,p>;

Info addVars(Info i, VarMap vm) = <i.name, i.vm+vm, i.em,i.p>;
Info addProperties(Info i, Properties p) = <i.name,i.vm,i.em,i.p+p>;
Info changeEventName(EventName name,Info i) = <name,i.vm,i.em,i.p>;

EventMap getEventMap(Events events) = (event.sig.name : event | event <- events.events);

VarMap oldNow() = ( parse(#Var,"now") : parse(#Expr,"s.now"),parse(#Var,"this") : parse(#Expr,"s"));
VarMap thisNow() = ( parse(#Var,"now") : parse(#Expr,"this.now")); 

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