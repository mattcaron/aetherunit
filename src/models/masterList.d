module models.masterList;

import utility.accessorTemplate;

import models.basicUnit;
import models.supportUnit;
import models.eliteUnit;

/**
 * A "master" list class consisting of a bunch of arrays of all the
 * other possible aetherverseObject subtyptes
 */
class masterList {

    /**
     * List of basic units
     */
    mixin declarationAndProperties!("basicUnit[]", "basicUnits");

    /**
     * List of elite units
     */
    mixin declarationAndProperties!("eliteUnit[]", "eliteUnits");

    /**
     * List of support units
     */
    mixin declarationAndProperties!("supportUnit[]", "supportUnits");

    // TODO: more specific subtypes here? (Personalities, melee
    // weapons, vehicles, etc?
    // mixin declarationAndProperties!("armor[]", "armors");
    // mixin declarationAndProperties!("weapon[]", "weapons");

    /**
     * Default constructor
     */
    this() {
    }

}
