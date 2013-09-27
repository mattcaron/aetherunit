module models.masterList;

import utility.accessorTemplate;

import models.basicUnit;
import models.supportUnit;
import models.eliteUnit;
import models.armor;

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

    // mixin declarationAndProperties!("weapon[]", "weapons");
    /**
     * List of armors
     */
    mixin declarationAndProperties!("armor[]", "armors");

    /**
     * Default constructor
     */
    this() {
    }

}
