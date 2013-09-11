import std.stdio;

import gtk.Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import gtk.SpinButton;

import gobject.Type;

import armyProfile;
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
template hookSpinButton(string buttonName)
{
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
 * @param variableName name of the class variable to which the button
 *                     should be bound
 */
mixin template generateSpinButtonCallback(string buttonName, 
                                          string variableName)
{
    mixin (
        "private void "~buttonName~"Changed(SpinButton button) {
            "~variableName~" = button.getValueAsInt();
            debugPrint(\""~variableName~" is %d\", "~variableName~");
        }"
    );
}

/**
 * Main controller class.
 *
 * Controls the window in which the user will spend most of their time
 */
class mainController {

    mixin declarationAndProperties!("string", "resourceFile");
    mixin declarationAndProperties!("armyProfile", "profile");

    mixin generateSpinButtonCallback!("armyDEX", "profile.DEX");
    mixin generateSpinButtonCallback!("armySTR", "profile.STR");
    mixin generateSpinButtonCallback!("armyCON", "profile.CON");
    mixin generateSpinButtonCallback!("armyTEK", "profile.TEK");
    mixin generateSpinButtonCallback!("armyMOR", "profile.MOR");
    mixin generateSpinButtonCallback!("armyPRE", "profile.PRE");

    /**
     * Initializing constructor
     */
    this()
    {
        profile = new armyProfile();
    }

    /**
     * Default close handler which calls Main.quit()
     *
     * @param aux The widget which called quit
     */
    private void quitMain(Widget aux) {
        Main.quit();
    }

    /**
     * Create and run the main GTK window
     *
     * @param args arguments passed on the command line
     *
     * @return exit value from the GTK window
     */
    int go (string[] args) {
        string gladestring = import(mainWindowResource);
        int retVal = 0;

        Main.init(args);

        // IMPORTANT: Main.init needs to be called before Builder is
        // created.
        Builder g = new Builder();

        if (!g.addFromString(gladestring, gladestring.length)) {
            writefln("Couldn't find glade file: %s", mainWindowResource);
            retVal = 1;
        } 
        else {
            Window w = cast(Window)g.getObject("mainWindow");
            
            if (w is null) {
                writefln("Unable to get handle to main window");
                retVal = 1;
            }
            else {
                w.addOnHide(&quitMain);
            }
            mixin(hookSpinButton!("armyDEX"));
            mixin(hookSpinButton!("armySTR"));
            mixin(hookSpinButton!("armyCON"));
            mixin(hookSpinButton!("armyTEK"));
            mixin(hookSpinButton!("armyMOR"));
            mixin(hookSpinButton!("armyPRE"));
            
            if (retVal == 0) {
                w.showAll();
                Main.run();
            }
        }
        return retVal;
    }
}

