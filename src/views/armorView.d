module views.armorView;

import std.stdio;

import gtk.CellRendererToggle;
import gtk.ListStore;
import gtk.TreeIter;

import controllers.armorController;
import controllers.mainController;

import models.traits.armorTrait;

import utility.accessorTemplate;

import views.subpanelView;
/**
 * Constant string which is the name of our UI description file.
 */
immutable string WIDGET_RESOURCE = "armorView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string WIDGET_NAME = "armorDialog";

/**
 * Class to control the armor view
 */
class armorView : subpanelView {

    /**
     * Reference to our controller
     *
     * This is used to inform our controller of updates
     */
    mixin declarationAndProperties!("armorController", "controller");

    /**
     * Initializing constructor
     *
     * @param controller the controller to which callbacks should be
     * directed.
     *
     */
    this(armorController controller) {
        this.controller = controller;
    }

    /**
     * Build an instance of this widget
     *
     * @return true on success
     * @return false on failure
     */
    override bool build() {
        string gladeString = import(WIDGET_RESOURCE);
        return super.init(gladeString, WIDGET_RESOURCE, WIDGET_NAME);
    }

    /**
     * Populate the list store of traits
     *
     * @param traits list of traits to put into the list store
     */
    void lsTraitPopulate(armorTrait[] traits = null) {
        ListStore lsTraits = cast(ListStore)builder.getObject("lsTraits");
        if (lsTraits is null) {
            writefln("Unable to get list store lsTraits");
        }
        else {
            // Destroy the store first
            lsTraits.clear();

            TreeIter iterator = new TreeIter();

            
            // Then rebuild
            if (traits !is null) {
                foreach (armorTrait trait; traits) {
                    writefln("Set value to %s", trait.name);
                    lsTraits.append(iterator);
                    // Column 1 is the name
                    lsTraits.setValue(iterator, 1, trait.name);
                }
            }

            CellRendererToggle toggle = 
            cast(CellRendererToggle)builder.getObject("toggleArmorTrait");
            if (toggle is null) {
                writefln("Unable to get toggle toggleArmorTrait");
            }
            else {
                toggle.addOnToggled(&controller.onToggleArmorTrait);
            }
        }
    }

    /**
     * Toggle the armor trait setting
     * 
     * @param path The tree path of the selection which was toggled
     * @param value The value to which the selection is to be set
     */
    void toggleArmorTrait(string path, bool value) {
        ListStore lsTraits = cast(ListStore)builder.getObject("lsTraits");
        if (lsTraits is null) {
            writefln("Unable to get list store lsTraits");
        }
        else {
            TreeIter iterator = new TreeIter();
            lsTraits.getIterFromString(iterator, path);
            if (iterator is null) {
                writefln("Unable to get iterator for path %s", path);
            }
            else {
                lsTraits.setValue(iterator, 0, value);
            }
        }
    }
}
