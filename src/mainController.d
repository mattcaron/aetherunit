import std.stdio;

import gtk.Main;

import utility.accessorTemplate;
import utility.debugPrint;

import armyProfile;
import mainView;
import unit;

/**
 * Template to generate a model update function
 *
 * @param variableName the name of the variable which should be
 *                     updated. The function name is variableUpdated
 *
 */
mixin template generateModelUpdate(string variableName) {
    mixin (
        "public void "~variableName~"Updated(int newValue) {
            profile."~variableName~" = newValue;
            view.armyBaseCostUpdate(profile.recalculate());
        }"
    );
}

/**
 * Main controller class.
 *
 * Controls the window in which the user will spend most of their time
 */
class mainController {

    mixin declarationAndProperties!("armyProfile", "profile");
    mixin declarationAndProperties!("mainView", "view");
    mixin generateModelUpdate!("DEX");
    mixin generateModelUpdate!("STR");
    mixin generateModelUpdate!("CON");
    mixin generateModelUpdate!("TEK");
    mixin generateModelUpdate!("MOR");
    mixin generateModelUpdate!("PRE");

    /**
     * Default constructor
     */
    this() {
        profile = new armyProfile();
    }

    /**
     * Create and run the main GTK window
     *
     * @param args arguments passed on the command line
     *
     * @return exit value from the GTK window
     */
    int go(string[] args) {
        int retVal = 0;

        view = new mainView(this);

        if (view.init(args)) {
            view.run();
        }
        return retVal;
    }
}

