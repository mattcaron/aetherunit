module models.assaultWeapon;

import utility.accessorTemplate;

import models.armyProfile;
import models.rangedWeapon;

/**
 *  An abstract class representing an assault weapon
 */
abstract class assaultWeapon : rangedWeapon {

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
        type = rangedWeaponType.Assault;
    }
}
