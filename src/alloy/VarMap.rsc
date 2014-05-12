module alloy::VarMap

import grammar::TypesAndLiterals;
import grammar::Events;
import grammar::Expressions;
import ParseTree;

alias VarMap = map[Var,Expr];
alias EventMap = map[EventName,Event];

VarMap oldNow() = ( parse(#Var,"now") : parse(#Expr,"s.now"),parse(#Var,"this") : parse(#Expr,"s"));
VarMap thisNow() = ( parse(#Var,"now") : parse(#Expr,"this.now"));


