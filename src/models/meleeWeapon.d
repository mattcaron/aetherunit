module models.meleeWeapon;

import utility.accessorTemplate;

import models.armyProfile;
import models.unit;

/**
 *  A class representing a melee weapon.
 */
class meleeWeapon : unit {

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
