module models.eliteUnit;

import models.armyProfile;
import models.unit;

/**
 *  A class representing an elite unit.
 */
class eliteUnit : unit {

    /**
     * Look up table of the base number of models per TEK level.
     *
     * TEK is the index in to the array.
     */
    immutable int[] baseModelArray = [10, 10, 8, 6, 5, 5, 4, 3, 2, 2, 1];
    
    /**
     * Number of stat points units get to spend to increase stats
     */
    immutable int extraStatPoints = 2;

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
        type = unitType.Elite;
    }

}
