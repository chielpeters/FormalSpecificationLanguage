module alloy::VarMap

import grammar::TypesAndLiterals;
import grammar::Events;
import grammar::Expressions;

alias VarMap = map[Var,Expr];
alias EventMap = map[EventName,Event];



