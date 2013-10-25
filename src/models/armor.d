module models.armor;

import utility.accessorTemplate;

import models.armyProfile;
import models.armorTrait;
import models.unit;


/**
 *  A class representing a piece of armor.
 */
// FIXME - not sure this descending from unit is correct. Might
// indicate a need to push additional things up in to aetherVerseObject.
class armor : unit {

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

    /**
     * Calculate the cost of this object
     */
    override void calculate() {
        // FIXME: Do calculation
    }

    /**
     * Validate that this object can be used in the current context.
     *
     * @return true if validation passed
     * @return false if failed
     */
    override bool validate() {
        // FIXME: Do validation
        return true;
    }
}
