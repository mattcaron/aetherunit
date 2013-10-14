module models.armor;

import utility.accessorTemplate;

import models.armyProfile;
import models.unit;


/**
 *  A class representing a pieve of armor.
 */
abstract class armor : unit {

    /**
     * ARM stat.
     */
    mixin declarationAndProperties!("int", "ARM");

    /**
     * Initializing constructor
     *
     * @FIXME - make readonly
     *
     * @param profile reference to profile on which this unit is
     *                based.
     */
    this(armyProfile profile) {
        super(profile);
    }
}
