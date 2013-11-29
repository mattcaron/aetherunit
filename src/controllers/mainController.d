module controllers.mainController;

import std.stdio;
import std.conv;

import gtk.CellRendererToggle;

import utility.accessorTemplate;

import controllers.addController;
import controllers.armorController;
import controllers.genericController;
import controllers.subpanelController;

import views.errorView;
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
class mainController : genericController {

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
        // path, and we just put the generic addView in via the
        // addController.
        //
        // Once the button is clicked, only then do we care exactly
        // which top level heading it is.
        aetherVerseObject selection = list.getObjectFromPath(
            view.tvArmyGetSelection());

        if (selection is null) {
            addController add = new addController(this);
            view.replaceSidePane(add.getWidget());
        }
        else {
            // TODO: pick specific sub-panel
        }
    }

    /**
     * Replace the subpanel with the one determined by the given
     * path
     */
    void onAddClicked() {
        masterList.listType selectedType = list.getObjectTypeFromPath(
            view.tvArmyGetSelection());
        subpanelController newSubpanel;

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
            newSubpanel = new armorController(this);
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

        if (newSubpanel !is null) {
            view.replaceSidePane(newSubpanel.getWidget());
        }
    }

    /******************* Generic functions ****************/

    /**
     * Default constructor
     */
    this() {
        profile = new armyProfile();
        list = new masterList();
        view = new mainView(this);
    }

    /**
     * Create and run the main GTK window
     *
     * This controller is a little special in that the others tend to
     * do the setup in their constructors, but tis guys does it in its
     * "go" function so that we can have a result returned back from
     * all the GTK platform init stuff.
     *
     * @param args arguments passed on the command line
     *
     * @return exit value from the GTK window
     */
    int go(string[] args) {
        int retVal = 0;

        if (view.init(args)) {
            this.view.lsCharacteristicPopulate(profile.characteristics);
            view.run();
        }
        return retVal;
    }

    /**
     * Callback for when the army characteristic toggle gets toggled
     */
    // FIXME - this is nearly identical to armyController's
    // onToggleArmorTrait. mixin?
    void onToggleArmyCharacteristic(string path, CellRendererToggle toggle) {
        // The path here is simple - it's just the index in to our
        // list of traits
        int index = to!int(path);
        if (index >= profile.characteristics.length) {
            writefln("Error: index exceeds armyProfile.characteristics.length");
        }
        else {
            profile.characteristics[index].selected = 
            !profile.characteristics[index].selected;
            view.toggleArmyCharacteristic(
                path, profile.characteristics[index].selected);
        }
    }

}

