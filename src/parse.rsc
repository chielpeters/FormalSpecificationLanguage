module parse

import ParseTree;
import grammar::Functions;
loc a = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryFunctionsFormatted.txt|;
loc b = |file:///C:/Users/Chiel/Dropbox/Thesis/DSL/LibraryEventsFormatted.txt|;
public Functions parse(str f) = parse(#Functions,f);
public Functions parse(loc f) = parse(#Functions,f);