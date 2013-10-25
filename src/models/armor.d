module models.armor;

import utility.accessorTemplate;

import models.armyProfile;
import models.armorTrait;
import models.unit;


/**
 *  A class representing a piece of armor.
 */
abstract class armor : unit {

    /**
     * ARM stat.
     */
    mixin declarationAndProperties!("int", "ARM");

    /**
     * All the traits which can be selected for armor
     */
    mixin declarationAndProperties!("armorTrait[]", "traits");

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
        // populate traits
        armorTrait.populate(traits);
    }
}
