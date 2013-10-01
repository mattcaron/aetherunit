module views.mainView;

import std.stdio;
import std.conv;

import gtk.Alignment;
import gtk.Builder;
import gtk.Button;
import gtk.Label;
import gtk.Main;
import gtk.SpinButton;
import gtk.TreeIter;
import gtk.TreeSelection;
import gtk.TreeStore;
import gtk.TreeView;
import gtk.Widget;
import gtk.Window;

import gdk.Event;

// These are necessary for the implicit conversion functions needed to
// be able to convert them to type "Widget" so they can be dynamically
// added to containers (ie currentSidePaneView). If you remove them,
// it will cease to function. It needs the top level widget for each
// view added in to alignmentSidePane
import gtk.Grid;

import gobject.Type;

import utility.accessorTemplate;
import utility.debugPrint;

import controllers.mainController;

import models.masterList;

/**
 * Constant string which is the name of our UI description file.
 */
immutable string MAIN_WINDOW_RESOURCE = "mainView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string MAIN_WINDOW_NAME = "mainWindow";

/**
 * Template to emit code to hook a spin button to a callback function
 *
 * @param buttonName name of the button
 */
template hookSpinButton(string buttonName) {
        const char[] hookSpinButton = "
    SpinButton "~buttonName~" = cast(SpinButton)g.getObject(\""~buttonName~"\");
    if("~buttonName~" is null) {
        writefln(\"Unable to get button: "~buttonName~"\");
        retVal = 1;
    } 
    else {
        "~buttonName~".addOnValueChanged(&"~buttonName~"Changed);
    }";
}

/**
 * Generate a callback for the spin button.
 *
 * This callback will automatically update the given variable with
 * the current value of the SpinButton
 *
 * @param variableName name of the base variable from which all things
 *                     are derived.
 */
mixin template generateSpinButtonCallback(string variableName) {
    mixin (
        "private void sbArmy"~variableName~"Changed(SpinButton button) {
            controller."~variableName~"Updated(button.getValueAsInt());
        }"
    );
}

/**
 * Class to control the main view
 */
class mainView {

    /**
     * Reference to the main controller
     *
     * This is used to inform the controller of updates
     */
    mixin declarationAndProperties!("mainController", "controller");

    /**
     * Reference to the builder object which contains all our bits
     */
    mixin declarationAndProperties!("Builder", "g");

    /**
     * Reference to the window we're controlling
     */
    mixin declarationAndProperties!("Window", "w");

    /**
     * Reference to the current side pane
     */
    mixin declarationAndProperties!("Widget", "currentSidePaneView");

    /** 
     * Reference to the label in the window which we want to update
     * with the calculated army cost.
     */
    mixin declarationAndProperties!("Label", "lblArmyBaseCost");

    /**
     * Callback passed to GTK to handle updates to the DEX spin button
     */
    mixin generateSpinButtonCallback!("DEX");

    /**
     * Callback passed to GTK to handle updates to the STR spin button
     */
    mixin generateSpinButtonCallback!("STR");

    /**
     * Callback passed to GTK to handle updates to the CON spin button
     */
    mixin generateSpinButtonCallback!("CON");

    /**
     * Callback passed to GTK to handle updates to the TEK spin button
     */
    mixin generateSpinButtonCallback!("TEK");

    /**
     * Callback passed to GTK to handle updates to the MOR spin button
     */
    mixin generateSpinButtonCallback!("MOR");

    /**
     * Callback passed to GTK to handle updates to the PRE spin button
     */
    mixin generateSpinButtonCallback!("PRE");

    /**
     * Initializing constructor
     *
     * @param controller the controller to which callbacks should be
     * directed.
     */
    this(mainController controller) {
        this.controller = controller;
        currentSidePaneView = null;
    }

    /**
     * Initialization function
     *
     * This function must be called before calling any other functions
     *
     * @param args arguments passed on the command line
     *
     * @return true on success
     * @return false on failure
     */
    bool init(string[] args) {
        // IMPORTANT: Main.init needs to be called before Builder is
        // created.
        string gladestring = import(MAIN_WINDOW_RESOURCE);
        bool retVal = true;

        Main.init(args);

        g = new Builder();
        
        if (!g.addFromString(gladestring, gladestring.length)) {
            writefln("Couldn't find glade file: %s", MAIN_WINDOW_RESOURCE);
            retVal = false;
        } 
        else {
            w = cast(Window)g.getObject(MAIN_WINDOW_NAME);
            
            if (w is null) {
                writefln("Unable to get handle to main window");
                retVal = false;
            }
            else {
                w.addOnDelete(
                    delegate bool (Event event, Widget aux) { 
                        Main.quit(); 
                        // We return true here because this is the
                        // last handler - quit and we're
                        // done. Propagating to other handlers results
                        // in attempts to call hooks where thinks have
                        // already been freed, resulting in segfaults
                        // due to access of nonexistent resources.
                        return true;
                    } 
                );
            }
            lblArmyBaseCost = cast(Label)g.getObject("lblArmyBaseCost");
            if (lblArmyBaseCost is null) {
                writefln("Unable to get label lblArmyBaseCost");
                retVal = false;
            }
            mixin(hookSpinButton!("sbArmyDEX"));
            mixin(hookSpinButton!("sbArmySTR"));
            mixin(hookSpinButton!("sbArmyCON"));
            mixin(hookSpinButton!("sbArmyTEK"));
            mixin(hookSpinButton!("sbArmyMOR"));
            mixin(hookSpinButton!("sbArmyPRE"));
        }
        return retVal;
    }

    /**
     * Update the army base cost label
     *
     * @param value Value to which the label should be set.
     */
    void armyBaseCostUpdate(int value) {
        lblArmyBaseCost.setText(to!string(value));
    }

    /**
     * Show the view and run the main GTK message pump.
     */
    void run() {
        w.showAll();
        Main.run();
    }

    /**
     * Populate the army TreeStore from the master list
     *
     * @param list the master list
     */
    void tsArmyPopulate(masterList list) {
        TreeStore tsArmy = cast(TreeStore)g.getObject("tsArmy");
        if (tsArmy is null) {
            writefln("Unable to get tree store tsArmy");
        }
        else {
            // Iterators used to keep track of column "headers" - top
            // level expandoflyout doodads
            TreeIter iterBasicUnits;
            TreeIter iterEliteUnits;
            TreeIter iterSupportUnits;
            TreeIter iterArmors;
            TreeIter iterRangedWeapons;
            TreeIter iterMeleeWeapons;

            // Add the top level headers
            iterBasicUnits = tsArmy.append(null);
            tsArmy.setValue(iterBasicUnits, 0, "Basic Units");
            iterEliteUnits = tsArmy.append(null);
            tsArmy.setValue(iterEliteUnits, 0, "Elite Units");
            iterBasicUnits = tsArmy.append(null);
            tsArmy.setValue(iterBasicUnits, 0, "Support Units");
            iterArmors = tsArmy.append(null);
            tsArmy.setValue(iterArmors, 0, "Armors");
            iterRangedWeapons = tsArmy.append(null);
            tsArmy.setValue(iterRangedWeapons, 0, "Ranged Weapons");
            iterMeleeWeapons = tsArmy.append(null);
            tsArmy.setValue(iterMeleeWeapons, 0, "Melee Weapons");

            TreeView tvArmy = cast(TreeView)g.getObject("tvArmy");
            if (tvArmy is null) {
                writefln("Unable to get tree view tvArmy");
            }
            else {
                tvArmy.addOnCursorChanged(
                    delegate void (TreeView treeView) {
                        TreeIter selection = treeView.getSelectedIter();
                        // TODO - call into the controller to replace
                        // the side pane
                    }
                );
                // Set it to a single selection "browse" mode
                TreeSelection selection = tvArmy.getSelection();
                selection.setMode(GtkSelectionMode.BROWSE);
            }
        }
    }

    /**
     * Replace the current side pane with the the given one
     *
     * @param newView view to add in
     *
     */
    void replaceSidePane(Widget newView) {
        if (currentSidePaneView is null) {
            // we're replacing the default "replace me" one
            currentSidePaneView = cast(Widget)g.getObject("gridReplaceMe");
        }

        if (currentSidePaneView is null) {
            writefln("currentSidePaneView is null (and shouldn't be)");
        }
        else {
            Alignment alignmentSidePane = cast(Alignment)g.getObject(
                "alignmentSidePane");
            if (alignmentSidePane is null) {
                writefln("Unable to get alignment alignmentSidePane");
            }
            else {
                alignmentSidePane.remove(currentSidePaneView);
                currentSidePaneView = newView;
                alignmentSidePane.add(currentSidePaneView);
            }
        }
    }
}
