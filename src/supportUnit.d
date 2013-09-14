import armyProfile;
import unit;

class supportUnit : unit {
    immutable int[] baseModelArray = [ 6, 6, 6, 5, 5, 4, 3, 2, 1, 1, 1];
    immutable int extraStatPoints = 2;

    this(armyProfile profile) {
        super(profile);
        type = unitType.Support;
    }


}
