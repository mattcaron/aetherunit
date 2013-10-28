module models.aetherVerseTrait;

import utility.accessorTemplate;

import models.aetherVerseObject;
import models.statList;

abstract class aetherVerseTrait : aetherVerseObject {

    /**
     * Whether or not this trait is selected
     */
    mixin declarationAndProperties!("bool", "selected");

    /**
     * Whether or not this trait is invalidated by another selected
     * trait
     */
    mixin declarationAndProperties!("bool", "invalidated");

    /**
     * List of other traits that this trait invalidates
     */
    mixin declarationAndProperties!("aetherVerseTrait[]", "invalidationList");

    /**
     * Description of this trait
     */
    mixin declarationAndProperties!("string", "description");

    /**
     * Initializing constructor
     *
     * @param unitStatList the stat list for the unit to which this 
     */
    this(statList unitStatList) {
        this.unitStatList = unitStatList;
    }

    /**
     * Function to iterate through a list of traits and invalidate
     * ones which conflict with this one
     */
    void invalidateTraits(aetherVerseTrait[] traitList) {
        // FIXME - implement
    }
    
    /**
     * Clear all "invalidated" flags
     *
     * @param traitList list of traits upon which to operate
     */
    static void clearInvalidations(aetherVerseTrait[] traitList) {
        foreach(aetherVerseTrait thisTrait; traitList) {
            thisTrait.invalidated = false;
        }
    }
}
