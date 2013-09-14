import std.stdio;
import std.conv;

import gtk.Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import gtk.SpinButton;
import gtk.Label;

import gobject.Type;

import utility.accessorTemplate;
import utility.debugPrint;

import armyProfile;
import mainController;

/**
 * Constant string which is the name of our UI description file.
 */
immutable string MAIN_WINDOW_RESOURCE = "main.glade";

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

class mainView {

    mixin declarationAndProperties!("mainController", "controller");
    mixin declarationAndProperties!("armyProfile", "profile");

    mixin declarationAndProperties!("Window", "w");
    mixin declarationAndProperties!("Label", "lblArmyBaseCost");

    mixin generateSpinButtonCallback!("DEX");
    mixin generateSpinButtonCallback!("STR");
    mixin generateSpinButtonCallback!("CON");
    mixin generateSpinButtonCallback!("TEK");
    mixin generateSpinButtonCallback!("MOR");
    mixin generateSpinButtonCallback!("PRE");

    /**
     * Initializing constructor
     *
     * @param controller the controller to which callbacks should be
     * directed.
     */
    this(mainController controller) {
        this.controller = controller;
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

        Builder g = new Builder();
        
        if (!g.addFromString(gladestring, gladestring.length)) {
            writefln("Couldn't find glade file: %s", MAIN_WINDOW_RESOURCE);
            retVal = false;
        } 
        else {
            w = cast(Window)g.getObject("mainWindow");
            
            if (w is null) {
                writefln("Unable to get handle to main window");
                retVal = false;
            }
            else {
                w.addOnHide(
                    delegate void(Widget aux) { 
                        Main.quit(); 
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
    void lblArmyBaseCostUpdate(int value) {
        lblArmyBaseCost.setText(to!string(value));
    }

    /**
     * Show the view and run the main GTK message pump.
     */
    void run() {
        w.showAll();
        Main.run();
    }
}
