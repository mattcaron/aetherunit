import std.stdio;

import gtk.Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import gtk.SpinButton;
import gtk.Label;

import gobject.Type;

import armyProfile;
import mainController;
import utility.accessorTemplate;
import utility.debugPrint;

/**
 * Constant string which is the name of our UI description file.
 */
const string mainWindowResource = "main.glade";

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
 * @param buttonName name of the button you want to hook
 * @param className name of the class in which the variable lives.
 * @param variableName name of the class variable to which the button
 *                     should be bound
 */
mixin template generateSpinButtonCallback(string buttonName,
                                          string className, 
                                          string variableName) {
    mixin (
        "private void "~buttonName~"Changed(SpinButton button) {
            "~className~"."~variableName~" = button.getValueAsInt();
            "~className~".recalculate();
            // armyBaseCost.setValue("~className~".armyBaseCost);
        }"
    );
}

class mainView {
    mixin declarationAndProperties!("mainController", "controller");
    mixin declarationAndProperties!("armyProfile", "profile");

    mixin declarationAndProperties!("Window", "w");
    mixin declarationAndProperties!("Label", "lblArmyBaseCost");

    mixin generateSpinButtonCallback!("sbArmyDEX", "profile", "DEX");
    mixin generateSpinButtonCallback!("sbArmySTR", "profile", "STR");
    mixin generateSpinButtonCallback!("sbArmyCON", "profile", "CON");
    mixin generateSpinButtonCallback!("sbArmyTEK", "profile", "TEK");
    mixin generateSpinButtonCallback!("sbArmyMOR", "profile", "MOR");
    mixin generateSpinButtonCallback!("sbArmyPRE", "profile", "PRE");

    this(mainController controller, armyProfile profile) {
        this.controller = controller;
        this.profile = profile;
    }

    bool init(string[] args) {
        // IMPORTANT: Main.init needs to be called before Builder is
        // created.
        string gladestring = import(mainWindowResource);
        bool retVal = true;

        Main.init(args);

        Builder g = new Builder();
        
        if (!g.addFromString(gladestring, gladestring.length)) {
            writefln("Couldn't find glade file: %s", mainWindowResource);
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
 
    void run() {
        w.showAll();
        Main.run();
    }
}
