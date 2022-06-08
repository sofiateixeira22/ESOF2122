
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric TapButtonNTimesStep() {
  return given1(
    RegExp(r'I go to the {string} page'),
        (wellKnownPage, context) async {
          final locator = find.byValueKey(wellKnownPage);
    },
  );
/*
  return given<String, int, FlutterWorld>(
    'I tap the {string} button {int} times',
        (key, count, context) async {
      final locator = find.byValueKey(key);
      for (var i = 0; i < count; i += 1) {
        await FlutterDriverUtils.tap(context.world.driver, locator);
      }
    },
  );
 */
}

/*
public class StepDefinitions {
  @Given("I go to the {string} page")
  public void i_want_to_open_page(String webpage) {
    webpageFactory.openPage(webpage);
  }
}
*/
//------------------------------------------------------------------------
StepDefinitionGeneric GivenWellKnownUserIsLoggedIn() {
  return given1(
    RegExp(r'(Bob|Mary|Emma|Jon) has logged in'),
        (wellKnownUsername, context) async {
      // implement your code
    },
  );
}