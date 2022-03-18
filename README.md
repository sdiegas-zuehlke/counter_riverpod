# counter_riverpod

This small challenge shows how to implement the Flutter Counter App with Riverpod State Management.
For simplicity we work mostly in the main.dart file.

## Replace setState with Riverpod (branch: solution)
1. Create a new Flutter Project or check out the main branch to get the starting code.
2. Look at the code and make sure you can launch the app on a smartphone or simulator.
3. Add the flutter_riverpod dependency to the project and wrap your App with a ProviderScope Widget.
4. Create a new Provider which holds an integer, starting with 0.
5. Consume the provided integer and show it's current state.
6. When the user clicks on the FloatingActionButton increment it's state by one.
7. The test in the widget_test.dart file is failing, fix it.

*If you get stuck, there is a branch "solution"*

***We have successfully replaced setState with Riverpod for state management!***

## Further challenges (branch: solution2)
8. Let's also change the Text based on the displayed number (1-10: "Not enough stay tuned!", 11-20: "Not bad, come there is possible even more!", 21+: "Ok you can stop now!")
9. There are no unit tests available for the numberProvider and motivationalTextProvider, create a new file for each and write some tests for it. You might need a testing framework like mockito.