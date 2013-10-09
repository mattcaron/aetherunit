module controllers.mainController;

import std.stdio;

import utility.accessorTemplate;

import views.addView;
import views.armorView;
import views.errorView;
import views.genericView;
import views.mainView;

import models.aetherVerseObject;
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
                error.popup(\""~variableName~" \" ~
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

    /**
     * Current object being created (essentially, it's "in flux")
     */
    mixin declarationAndProperties!("aetherVerseObject", "currentObject");

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
     * Function to update the model's CON
     */
    mixin generateModelUpdate!("CON");

    /**
     * Function to update the model's TEK
     */
    mixin generateModelUpdate!("TEK");

    /**
     * Function to update the model's MOR
     */
    mixin generateModelUpdate!("MOR");

    /**
     * Function to update the model's PRE
     */
    mixin generateModelUpdate!("PRE");

    /**
     * Function to update things when the Army TreeView selection
     * changes
     */
    void tvArmyUpdated() {
        // If this returns null, it's a top level heading, not a real
        // path, and we just put the generic addView in.
        // Once the button is clicked, only then do we care exactly
        // which top level heading it is.
        aetherVerseObject selection = list.getObjectFromPath(
            view.tvArmyGetSelection());

        if (selection is null) {
            addView add = new addView(this);
            add.build();
            view.replaceSidePane(add.widget);
        }
        else {
            // TODO: pick specific sub-panel
        }
    }

    /**
     * Function to respond to the generic "Add" button being clicked
     */
    void onAddClicked() {
        masterList.listType selectedType = list.getObjectTypeFromPath(
            view.tvArmyGetSelection());
        genericView newView;

        // replace the side view with the correct panel for the
        // currently selected TreeView item
        switch (selectedType) {
        case masterList.listType.BasicUnit:
            writefln("TODO: implement side panel for %s", selectedType);
            break;
        case masterList.listType.EliteUnit:
            writefln("TODO: implement side panel for %s", selectedType);
            break;
        case masterList.listType.SupportUnit:
            writefln("TODO: implement side panel for %s", selectedType);
            break;
        case masterList.listType.Armor:
            newView = new armorView(this);
            break;
        case masterList.listType.MeleeWeapon:
            writefln("TODO: implement side panel for %s", selectedType);
            break;
        case masterList.listType.RangedWeapon:
            writefln("TODO: implement side panel for %s", selectedType);
            break;
        default:
            writefln("Warning - unknown type: %s", selectedType);
            break;
        }

        if (newView !is null) {
            newView.build();
            view.replaceSidePane(newView.widget);
        }
    }

    /******************* Generic functions ****************/

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
            view.run();
        }
        return retVal;
    }
}

