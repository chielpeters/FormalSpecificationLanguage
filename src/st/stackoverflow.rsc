module st::stackoverflow

import ParseTree;
import String;

lexical Int = [0-9]+;
syntax Bool = "True" | "False";
syntax Period = "Day" | "Month" | "Quarter" | "Year";
layout Standard = [\ \t\n\f\r]*; 
syntax Optionals = Int? i Bool? b Period? p;

str printOptionals(Optionals opt){
	str res = "";
	if(isEmpty("<opt.i>")) { // opt has i is alway true (same for opt.i?)
		res += printInt(opt.i);
	}
	if(isEmpty("<opt.b>")){
		res += printBool(opt.b);
	}
	if(isEmpty("<opt.p>")) {
		res += printPeriod(opt.period);
	}
	return res;
}

str printInt(Int i) = "<i>";
str printBool(Bool b) = "<b>";
str printPeriod(Period p) = "<p>";

 
