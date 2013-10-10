module models.vehicle;

import models.armyProfile;
import models.supportUnit;

/**
 *  An abstract class representing a vehicle, which is always a support unit.
 */
abstract class vehicle : supportUnit {

    /**
     * Vehicles are single model support units
     *
     * TEK is the index in to the array.
     */
    immutable int[] baseModelArray = [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

    /**
     * Number of stat points units get to spend to increase stats
     */
    immutable int extraStatPoints = 0;

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
