module alloy::Literals

import grammar::Lexical;
import grammar::TypesAndLiterals;
import ParseTree;
import String;

str literal2alloy((Literal)`<Percentage p>`){
	return replaceAll(replaceAll(replaceAll("<p>",".",""),"%","")," ","");
}

str literal2alloy((Literal)`<Int i>`){
	return "<i>";
}

str literal2alloy((Literal)`<Bool b>`){
 	return "<b>";
}

str literal2alloy((Literal)`<Period p>`){
  	str period = "<p>";
  	switch(period){
	    case "Day" 		:   return "1";
    	case "Month" :   return "2";
    	case "Quarter" : return "3";
  		case "Year" : return "4";
  	}
}

str literal2alloy((Literal)`<Int days> <Month m>`){
	return "newDate[<days>,<month2Int(m)>]";
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
