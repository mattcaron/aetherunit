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
     * Unit types
     */
    enum unitType {
        Basic,
        Elite,
        Support
    }

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
     * Final list for this unit
     */
    mixin declarationAndProperties!("statList", "unitStatDifferential");

    /**
     * Type of the unit
     */
    mixin declarationAndProperties!("unitType", "type");

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
