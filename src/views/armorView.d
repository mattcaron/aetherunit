module views.armorView;

import views.genericView;
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
class armorView : genericView {

    /**
     * Build an instance of this widget
     *
     * @return true on success
     * @return false on failure
     */
    bool build() {
        string gladeString = import(WIDGET_RESOURCE);
        return super.init(gladeString, WIDGET_RESOURCE, WIDGET_NAME);
    }
}
