module views.genericView;

import std.stdio;

import gtk.Builder;
import gtk.Widget;

import utility.accessorTemplate;

/**
 * Abstract class to control a generic view
 */
abstract class genericView {

    private string gladeString = "";

    /**
     * Reference to the builder object which contains all our bits
     */
    mixin declarationAndProperties!("Builder", "builder");

    /**
     * Reference to the widget we're controlling
     */
    mixin declarationAndProperties!("Widget", "widget");

    /**
     * Default constructor
     */
    this() {
    }

    /**
     * Initialization function
     *
     * This function initializes the view and must be called before
     * calling any other functions. Once completed, the view is ready
     * to be used in its desired role (replacing a side pane, popping
     * up a window, etc.)
     *
     * @param gladeString string describing our widget
     * @param widgetResource file name from which description of the
     *                       widget was obtained
     * @param widgetName name of the widget to get
     *
     * @return true on success
     * @return false on failure
     */
    protected bool init(immutable string gladeString,
                        immutable string widgetResource,
                        immutable string widgetName) {
        bool retVal = true;

        builder = new Builder();

        if (!builder.addFromString(gladeString, gladeString.length)) {
            writefln("Couldn't find glade file: %s", widgetResource);
            retVal = false;
        } 
        else {
            widget = cast(Widget)builder.getObject(widgetName);
            
            if (widget is null) {
                writefln("Unable to get handle to widget %s", 
                         widgetName);
                retVal = false;
            }
        }

        return retVal;
    }

    /**
     * Build an instance of this widget
     *
     * @return true on success
     * @return false on failure
     */
    abstract bool build();
}
