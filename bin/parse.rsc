module parse

import ParseTree;
import grammar::LibraryFunctions;
loc a = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryFunctionsFormatted.txt|;
public Functions parse(str f) = parse(#Functions,f);
public Functions parse(loc f) = parse(#Functions,f);