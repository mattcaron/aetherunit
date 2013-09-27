module models.armor;

import utility.accessorTemplate;

import models.aetherVerseObject;
import models.armyProfile;

/**
 *  A class representing a pieve of armor.
 */
abstract class armor : aetherVerseObject {

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
