import armyProfile;
import unit;

class eliteUnit : unit {

    immutable int[] baseModelArray = [10, 10, 8, 6, 5, 5, 4, 3, 2, 2, 1];
    immutable int extraStatPoints = 2;

    this(armyProfile profile) {
        super(profile);
        type = unitType.Elite;
    }

}
