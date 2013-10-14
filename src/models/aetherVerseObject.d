module models.aetherVerseObject;

import std.string;

import utility.accessorTemplate;

import models.armyProfile;
import models.statList;

/**
 * An abstract object class for something existing in the aetherverse.
 */
abstract class aetherVerseObject {

    /**
     * Name of this object
     */
    mixin declarationAndProperties!("string", "name");

    /**
     * Unit stat list
     *
     * If the class is represents a unit, it is the final stat list
     * for that unit, which is the 
     *
     * If the class represents a trait, this is passed in, so that the
     * trait can run any checks it needs.
     */
    mixin declarationAndProperties!("statList", "unitStatList");

    @property {
        string type() {
            return this.classinfo.name[
                lastIndexOf(this.classinfo.name, ".")+1..
                this.classinfo.name.length];
        }
    }

    /**
     * Default constructor
     */
    this() {
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
