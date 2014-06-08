module lang::specifications::ide::Specifications

import lang::specifications::\syntax::Specifications;
import lang::specifications::check::Specifications;
import lang::specifications::alloy::Specifications;
import lang::specifications::utils::Parse;
import util::IDE;
import Message;
import ParseTree;
import List;
import IO;


str SPECIFICATION_EXTENSION = "spec";
str SPECIFICATION_LANGUAGE = "Specification";

void registerSpecifications(){
	registerLanguage(SPECIFICATION_LANGUAGE,SPECIFICATION_EXTENSION,parseSpecification);
	registerAnnotator(SPECIFICATION_LANGUAGE, checkAndAnnotate);
	contribs = {
	popup(
		menu(SPECIFICATION_LANGUAGE,[
	    	action("Generate Alloy", generateAlloy),
	    	action("Generate and Start Alloy", generateAndStartAlloy),
	    	action("Generate Traces (LONG)", generateTraces)
		])
	)
	};
	registerContributions(SPECIFICATION_LANGUAGE, contribs);
}

Specification checkAndAnnotate(Specification spec){
	return spec[@messages = toSet(check(spec,spec@\loc.top.parent))];
}

void generateAlloy(Specification spec, loc l){
	specification2alloy(spec,spec@\loc.top.parent,false);
}

void generateAndStartAlloy(Specification spec, loc l){
	generateAlloy(spec,l);
	loc alloyLoc = |project://FormalSpecificationLanguage/resources/Alloy4.2_2014-05-16.jar|;
	loc location = |project://FormalSpecificationLanguage/output/| + "<spec.name>.als";
	startAlloy(alloyLoc,location);
	
}

void generateTraces(Specification spec, loc l){
	generateAlloy(spec,l);
	loc location = |project://FormalSpecificationLanguage/output/| + "<spec.name>.als";
	str res = generateTrace(location);
	loc jsonlocation = |project://FormalSpecificationLanguage/output/| + "<spec.name>Traces.json";
	writeFile(jsonlocation,res);
}

@javaClass{lang.specifications.alloy.com.spec.Traces}
public java str generateTrace(loc l);

@javaClass{lang.specifications.alloy.com.spec.Alloy}
public java void startAlloy(loc jarLoc,loc l);

@javaClass{lang.specifications.alloy.com.spec.Alloy}
public java str getString(loc l);