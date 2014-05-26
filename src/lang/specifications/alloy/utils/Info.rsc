module lang::specifications::alloy::utils::Info

import lang::specifications::\syntax::Lexical;
import lang::specifications::\syntax::TypesAndLiterals;
import lang::specifications::\syntax::Expressions;
import lang::events::\syntax::Events;
import ParseTree;
import List;

alias VarMap = map[Var,Expr];
alias EventMap = map[EventName,Event];
alias Info = tuple[SpecificationName specname, VarMap vm, EventMap em];

Info initInfo(SpecificationName specname, VarMap vm, EventMap em) = <specname, vm, em>;
Info initInfo(SpecificationName specname, list[Expr] args,EventName name, EventMap em) = <specname,setVarMap(args,em[name]),em>;

Info addVars(Info i, VarMap vm) = <i.specname, i.vm+vm, i.em>;

EventMap getEventMap(Events events) = (event.sig.name : event | event <- events.events);

VarMap oldNow() = ( [Var]"now" : [Expr]"old.now", [Var]"this" : [Expr]"old");
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