module views.armorView;

import std.stdio;

import gtk.ListStore;
import gtk.TreeIter;

import controllers.armorController;
import controllers.mainController;

import models.armorTrait;

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

            TreeIter iterator;

            // Then rebuild
            if (traits !is null) {
                foreach (armorTrait trait; traits) {
                    lsTraits.append(iterator);
                    lsTraits.setValue(iterator, 0, trait.name);
                }
            }
        }
    }
}
