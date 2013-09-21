module models.supportUnit;

import models.armyProfile;
import models.unit;

/**
 *  A class representing a support unit.
 */
class supportUnit : unit {

    /**
     * Look up table of the base number of models per TEK level.
     *
     * TEK is the index in to the array.
     */
    immutable int[] baseModelArray = [ 6, 6, 6, 5, 5, 4, 3, 2, 1, 1, 1];

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
        type = unitType.Support;
    }


}
