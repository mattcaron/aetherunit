module models.aetherVerseObject;

import utility.accessorTemplate;

import models.armyProfile;

/**
 * An abstract object class for something existing in the aetherverse.
 */
abstract class aetherVerseObject {

    /**
     * Object to store a reference to the army profile
     *
     * @FIXME - make read only
     */
    mixin declarationAndProperties!("armyProfile", "profile");

    /**
     * Name of this object
     */
    mixin declarationAndProperties!("string", "name");

    /**
     * Initializing constructor
     *
     * @param profile reference to profile on which this unit is
     *                based.
     *
     * @FIXME - make read only
     */
    this(armyProfile profile) {
        this.profile = profile;
    }

    /**
     * Calculate the cost of this object
     */
    abstract void calculate();

    /**
     * Validate that this object can be used in the current context.
     *
     * @return true if validation passed
     * @return false if failed
     */
    abstract bool validate();
    
}
