module models.unit;

import utility.accessorTemplate;

import models.aetherVerseObject;
import models.armyProfile;
import models.statList;

/**
 *  An abstract class representing a generic unit.
 */
abstract class unit : aetherVerseObject {

    /**
     * Look up table of the base number of models per TEK level.
     *
     * TEK is the index in to the array.
     *
     * This is empty just to satisfy the compiler.
     */
    immutable int[] baseModelArray = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    /**
     * Look up table of extra models per TEK level.
     *
     * TEK is the index in to the array
     */
    immutable int[] extraModelsArray = [ 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3];

    /**
     * Number of stat points units get to spend to increase stats
     */
    immutable int extraStatPoints = 0;

    /**
     * Object to store a reference to the army profile
     *
     * @FIXME - make read only
     */
    mixin declarationAndProperties!("armyProfile", "profile");

    /**
     * Unit stat list differential
     *
     * This records where any extra stat points were spent, relative
     * to the base army profile. This, combined with the army profile,
     * and any modifications granted by traits yields the unitStatList
     */
    mixin declarationAndProperties!("statList", "unitStatDifferential");

    /**
     * Initializing constructor
     *
     * @FIXME - make readonly
     *
     * @param profile reference to profile on which this unit is
     *                based.
     */
    this(armyProfile profile) {
        this.profile = profile;
        this.unitStatList = new statList();
        this.unitStatDifferential = new statList();
    }

    /**
     * Calculate the base number of models for this unit
     *
     * @return the base number of models
     */
    int calculateBaseModels() {
        return baseModelArray[profile.TEK];
    }

    /**
     * Calculate the number of extra models (specialists) which can be
     * added to this unit
     *
     * @return The number of extra models which can be added to this
     * unit.
     */
    int calculateExtraModels() {
        return extraModelsArray[profile.TEK];
    }

}
