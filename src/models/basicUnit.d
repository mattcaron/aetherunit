module model.basicUnit;

import models.armyProfile;
import models.unit;

/**
 * A class representing a basic unit.
 */
class basicUnit : unit {

    /**
     * Look up table of the base number of models per TEK level.
     *
     * TEK is the index in to the array.
     */
    immutable int[] baseModelArray = [20, 20, 16, 12, 10, 8, 6, 5, 5, 3, 3];

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
}
