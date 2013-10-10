module models.meleeWeapon;

import utility.accessorTemplate;

import models.aetherVerseObject;
import models.armyProfile;

/**
 *  A class representing a melee weapon.
 */
class meleeWeapon : aetherVerseObject {

    /**
     * The weapon's damage.
     */
    mixin declarationAndProperties!("int", "DAM");

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
