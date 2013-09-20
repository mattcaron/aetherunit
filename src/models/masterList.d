module models.masterList;

import utility.accessorTemplate;

import models.basicUnit;
import models.supportUnit;
import models.eliteUnit;

class masterList {

    // TODO: more specific subtypes here? (Personalities, melee
    // weapons, vehicles, etc?
    mixin declarationAndProperties!("basicUnit[]", "basicUnits");
    mixin declarationAndProperties!("eliteUnit[]", "eliteUnits");
    mixin declarationAndProperties!("supportUnit[]", "supportUnits");
    // mixin declarationAndProperties!("armor[]", "armors");
    // mixin declarationAndProperties!("weapon[]", "weapons");

    this() {
    }

}
