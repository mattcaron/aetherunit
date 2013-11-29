module models.traits.armyArchaic;

import utility.accessorTemplate;

import models.statList;

import models.traits.armyCharacteristic;

class armyArchaic : armyCharacteristic {
    
    /**
     * Initializing constructor
     *
     * @param unitStatList the stat list for the army to which this 
     *                     characteristic applies
     */
    this(statList armyStatList) {
        super(armyStatList);
        this.invalidationList = [];
        this.name = armyCharacteristicList.Archaic;
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
