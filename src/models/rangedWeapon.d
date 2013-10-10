module models.rangedWeapon;

import utility.accessorTemplate;

import models.aetherVerseObject;
import models.armyProfile;

/**
 *  An abstract class representing a generic ranged weapon.
 */
abstract class rangedWeapon : aetherVerseObject {

    /**
     * The weapon's damage.
     */
    mixin declarationAndProperties!("int", "DAM");

    /**
     * The weapon's range factor.
     *
     * This is multiplied by RANGE_MULTIPLIER in the child classes to
     * calculate the actual range.
     */
    mixin declarationAndProperties!("int", "RNG");

    /**
     * The number of shots the weapon has
     *
     */
    mixin declarationAndProperties!("int", "NumberOfShots");

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
