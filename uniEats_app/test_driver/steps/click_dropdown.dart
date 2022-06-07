import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';


/*

final givenITapDropdownItem = given2<String, String, FlutterWorld>(RegExp(r'I tap (?:a|an|the) {string} within (?:a|an|the) {string} dropdown'), (menuItemKey, dropdownKey, context) async {
  await context.world.waitForAppToSettle();
  final finder = context.world.findBy(dropdownKey, FindType.key);

  await context.world.scrollIntoView(
    finder,
  );
  await context.world.waitForAppToSettle();
  await context.world.tap(
    finder,
    timeout: context.configuration.timeout,
  );
  await context.world.waitForAppToSettle();

  {
    final timeout =
        context.configuration.timeout ?? const Duration(seconds: 20);

    final finder = (context.world.findBy(menuItemKey, FindType.key) as Finder).last;

    final isPresent = await context.world.isPresent(
      finder,
      timeout: timeout * .2,
    );

    if (!isPresent) {
      await context.world.scrollUntilVisible(
        (context.world.findBy(menuItemKey, FindType.key) as Finder).last,
        dy: -100.0,
        timeout: timeout * .9,
      );
    }

    await context.world.tap(
      finder,
      timeout: timeout,
    );
    await context.world.waitForAppToSettle();
  }
});

*/