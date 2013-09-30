module controllers.mainController;

import std.stdio;

import gtk.Main;

import utility.accessorTemplate;

import views.mainView;
import views.errorView;

import models.armyProfile;
import models.masterList;

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
            if (profile.attributeValueInRange(newValue)) {
                profile."~variableName~" = newValue;
                view.armyBaseCostUpdate(profile.recalculate());
            } else {
                errorView error = new errorView();
                error.popup(\""~variableName~"\" ~
                            \"is out of range. This is not your fault,\n\" ~
                            \"the UI should never have let you get here.\n\" ~
                            \"Please contact the software authors and \n\" ~
                            \"tell them about it.\");
            }
        }"
    );
}

/**
 * Main controller class.
 *
 * Controls the window in which the user will spend most of their time
 */
class mainController {

    /***************** Views *****************/

    /**
     * Main view object
     */
    mixin declarationAndProperties!("mainView", "view");

    /***************** Models ****************/
    /**
     * The overall army profile
     */
    mixin declarationAndProperties!("armyProfile", "profile");
    
    /**
     * List of items, units, etc.
     */
    mixin declarationAndProperties!("masterList", "list");

    /***************** Callbacks *************/
    /**
     * Function to update the model's DEX
     */
    mixin generateModelUpdate!("DEX");

    /**
     * Function to update the model's STR
     */
    mixin generateModelUpdate!("STR");

    /**
     * Function to update the models' CON
     */
    mixin generateModelUpdate!("CON");

    /**
     * Function to update the models' TEK
     */
    mixin generateModelUpdate!("TEK");

    /**
     * Function to update the models' MOR
     */
    mixin generateModelUpdate!("MOR");

    /**
     * Function to update the models' PRE
     */
    mixin generateModelUpdate!("PRE");

    /**
     * Default constructor
     */
    this() {
        profile = new armyProfile();
        list = new masterList();
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
            view.tsArmyPopulate(list);
            view.run();
        }
        return retVal;
    }
}

