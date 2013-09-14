import utility.accessorTemplate;

import armyProfile;

abstract class aetherVerseObject {

    mixin declarationAndProperties!("armyProfile", "profile");

    this(armyProfile profile) {
        this.profile = profile;
    }

    abstract void calculate();
    abstract bool validate();
    
}
