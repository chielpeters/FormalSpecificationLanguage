module alloy::TypesAndLiterals

import grammar::Lexical;
import grammar::TypesAndLiterals;
import alloy::VarMap;
import alloy::Expressions;
import ParseTree;
import String;

str literal2alloy(Int i,VarMap vm) = "<i>";
str literal2alloy((Literal)`<Int i>`,VarMap vm) = "<i>";
str literal2alloy(Period p,VarMap vm) = "<p>";
str literal2alloy((Literal)`<Period p>`,VarMap vm) = "<p>";
str literal2alloy((Literal)`<Frequency f>`,VarMap vm) = "<f>";
str literal2alloy((Literal)`<Bool b>`,VarMap vm){if((Bool)`True` := b) return "{}"; else return "!{}";}
str literal2alloy((Literal)`<Var v>`,VarMap vm) = literal2alloy(v,vm);
str literal2alloy(Var v, VarMap vm){if(v in vm) return expression2alloy(vm[v],vm); else return "<v>";}
str literal2alloy((Literal)`<Date d>`,VarMap vm) = "getDate[<d.day>,<month2Int(d.month)>,0]";
str literal2alloy((Literal)`( <MapElements elems> )`,VarMap vm){
	return replaceLast(("{"| it + mapElem2String(elem,vm) + " + " | elem <- elems.elems)," + ","") + "}";
}
str literal2alloy((Literal)`{<{Literal ","}* l>}`,VarMap vm){
	return replaceLast(("{"| it + literal2alloy(elem,vm) + " + " | elem <- l)," + ","") + "}";
} 
str literal2alloy((Literal)`[<{Literal ","}* l>]`,VarMap vm){
	int i = 0;
	str res = "{";
	for(elem <- l){
	 	res += SeqElem2alloy(elem,i,vm) + " + ";
		i = i+1;
	}
	return replaceLast(res + "}"," + ","");
} 

str SeqElem2alloy(Literal a,int i,VarMap vm){
 return "<i>" + "-\>" + literal2alloy(a,vm);
}

str mapElem2String(MapElement m,VarMap vm){
	  return literal2alloy(m.key,vm) +  "-\>" + literal2alloy(m.val,vm);
} 

//TODO Change The way Percentage are dealt with
str literal2alloy(per:(Literal)`<Percentage p>`,VarMap vm){
	if((Literal)`0.0%` := per) return "getPercentage[0]";
	return "getPercentage[" + replaceAll(replaceAll(replaceAll("<p>",".",""),"%","")," ","") + "]";
}

int month2Int(Month m){
  str month = "<m>";
  switch(month){
    case "Jan" : return 1;
    case "Feb" : return 2;
    case "Mar" : return 3;
    case "Apr" : return 4;
    case "May" : return 5;
    case "Jun" : return 6;
    case "Jul" : return 7;
    case "Aug" : return 8;
    case "Sep" : return 9;
    case "Oct" : return 10;
    case "Nov" : return 11;
    case "Dec" : return 12;
  }
}

str type2alloy((Type)`Boolean`) = "Bool";
str type2alloy((Type)`Integer`) = "Int";
str type2alloy((Type)`Date`) = "Date";
str type2alloy((Type)`Period`) = "Period";
str type2alloy((Type)`Percentage`) = "Percentage";
str type2alloy((Type)`map[<Type key> : <Type val>]`) = "<type2alloy(key)> -\> <type2alloy(val)>";
str type2alloy((Type)`list[ <Type t>]`) = "seq <type2alloy(t)>";
str type2alloy((Type)`set[ <Type t>]`) = "set <type2alloy(t)>";
str type2alloy((Type)`Freq`) = "Frequency";




