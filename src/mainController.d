import std.stdio;

import gtk.Main;

import armyProfile;
import mainView;
import utility.accessorTemplate;
import utility.debugPrint;

/**
 * Main controller class.
 *
 * Controls the window in which the user will spend most of their time
 */
class mainController {

    mixin declarationAndProperties!("string", "resourceFile");
    mixin declarationAndProperties!("armyProfile", "profile");

    /**
     * Initializing constructor
     */
    this() {
        profile = new armyProfile();
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

        mainView view = new mainView(this, profile);

        if (view.init(args)) {
            view.run();
        }
        return retVal;
    }
}

