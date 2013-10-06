module views.addView;

import std.stdio;

import gtk.Builder;
import gtk.Button;
import gtk.Label;
import gtk.Widget;

import gobject.Type;

import utility.accessorTemplate;

import views.genericView;

/**
 * Constant string which is the name of our UI description file.
 */
immutable string WIDGET_RESOURCE = "addView.glade";

/**
 * Constant string which is the name of our parent window
 */
immutable string WIDGET_NAME = "addDialog";

/**
 * Class to control the armor view
 */
class addView : genericView {

    /**
     * Build an instance of this widget
     *
     * @return true on success
     * @return false on failure
     */
    bool build() {
        string gladeString = import(WIDGET_RESOURCE);
        bool retVal = true;

        if (!super.init(gladeString, WIDGET_RESOURCE, WIDGET_NAME)) {
            retVal = false;
        }
        else {
            // hook button here
        }
        return retVal;
    }
}
