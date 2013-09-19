import std.stdio;

import controllers.mainController;
import utility.debugPrint;

/**
 * Main function
 * 
 * @param args Arguments passed in on the command line
 *
 * @return 0 on success
 * @return 1 on failure
 */
int main(string[] args) {
    mainController controller = new mainController();
    return controller.go(args);
}
