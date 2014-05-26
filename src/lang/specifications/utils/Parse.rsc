module lang::specifications::utils::Parse

import lang::specifications::\syntax::Specifications;
import ParseTree;

Specification parseSpecification(loc file) = parse(#Specification,file);
Specification parseSpecification(str x, loc file) = parse(#Specification,x,file);
Specification parseSpecification() = parse(#Specification,|project://FormalSpecificationLanguage/input/savingsaccounts/TopRekening.sa|);
