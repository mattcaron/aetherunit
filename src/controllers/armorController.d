module controllers.armorController;

import std.stdio;
import std.conv;

import gtk.CellRendererToggle;

import utility.accessorTemplate;

import controllers.subpanelController;
import controllers.mainController;

import models.armor;

import views.armorView;

/**
 * Armor controller class
 *
 * Controls the sub-window in which the user enters armor things
 */
class armorController : subpanelController {

    /**
     * The view object that we control
     */
    mixin declarationAndProperties!("armorView", "view");

    /**
     * The piece of armor currently described by this controller
     */
    mixin declarationAndProperties!("armor", "currentArmor");

    /**
     * Initializing constructor
     */
    this(mainController controller) {
        this.view = new armorView(this);
        super(controller, this.view);
        this.currentArmor = new armor(controller.profile);
        this.view.lsTraitPopulate(currentArmor.traits);
    }

    /**
     * Callback for when the armor trait toggle gets toggled
     */
    void onToggleArmorTrait(string path, CellRendererToggle toggle) {
        // The path here is simple - it's just the index in to our
        // list of traits
        int index = to!int(path);
        if (index >= currentArmor.traits.length) {
            writefln("Error: index exceeds currentArmor.traits.length");
        }
        else {
            currentArmor.traits[index].selected = 
            !currentArmor.traits[index].selected;
            view.toggleArmorTrait(path, currentArmor.traits[index].selected);
        }
    }
}
