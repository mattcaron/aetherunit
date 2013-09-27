module models.lightWeapon;

import utility.accessorTemplate;

import models.armyProfile;
import models.rangedWeapon;

/**
 *  An abstract class representing a light weapon
 */
abstract class lightWeapon : rangedWeapon {

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
        type = rangedWeaponType.Light;
    }
}
