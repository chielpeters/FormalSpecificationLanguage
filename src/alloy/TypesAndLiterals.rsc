module alloy::TypesAndLiterals

import grammar::Lexical;
import grammar::TypesAndLiterals;
import ParseTree;
import String;

str literal2alloy((Literal)`<Int i>`) = "<i>";
str literal2alloy((Literal)`<Period p>`) = "<p>";
str literal2alloy((Literal)`<Frequency f>`) = "<f>";

str literal2alloy((Literal)`<Bool b>`){
 	if((Bool)`True` := b) return "0=0"; else return "1=0";
}

//TODO Change The way Percentage are dealt with
str literal2alloy((Literal)`<Percentage p>`){
	return "getPercentage[" + replaceAll(replaceAll(replaceAll("<p>",".",""),"%","")," ","") + "]";
}


str literal2alloy((Literal)`<Int days> <Month m>`){
	return "getDate[<days>,<month2Int(m)>,0]";
}

str literal2alloy((Literal)`( <MapElements elems> )`){
	return replaceLast(("{"| it + mapElem2String(elem) + " + " | elem <- elems.elems)," + ","") + "}";
}

str literal2alloy((Literal)`{<{Literal ","}* l>}`){
	return replaceLast(("{"| it + literal2alloy(elem) + " + " | elem <- l)," + ","") + "}";
} 

str literal2alloy((Literal)`[<{Literal ","}* l>]`){
	int i = 0;
	str res = "{";
	for(elem <- l){
	 	res += SeqElem2alloy(elem,i) + " + ";
		i = i+1;
	}
	return replaceLast(res + "}"," + ","");
} 

str SeqElem2alloy(Literal a,i){
 return "<i>" + "-\>" + literal2alloy(a);
}

str mapElem2String(MapElement m){
	  return literal2alloy(m.key) +  "-\>" + literal2alloy(m.val);
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
str type2alloy((Type)`Frequency`) = "Frequency";




