module models.traits.armyBarbaric;

import utility.accessorTemplate;

import models.statList;

import models.traits.armyCharacteristic;

class armyBarbaric : armyCharacteristic {
    
    /**
     * Initializing constructor
     *
     * @param armyStatList the stat list for the army to which this
     *                     characteristic applies
     */
    this(statList armyStatList) {
        super(armyStatList);
        this.invalidationList = [];
        this.name = armyCharacteristicList.Barbaric;
    }

    /**
     * Calculate the cost of this object
     *
     * @return the cost of this object
     */
    override int calculate() {
        return 0;
    }

    /**
     * Validate that this object can be used in the current context.
     *
     * @return true if validation passed
     * @return false if failed
     */
    override bool validate() {
        return true;
    }
}
