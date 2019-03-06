
README.txt for Cloudy MVVM tutorial

Based on: https://cocoacasts.com/welcome-to-mastering-mvvm-with-swift

Working directory: /Users/frankcipolla/Workspace/MVVM/Cloudy/

Using git workflow with this

Setting up xcode groups but not setting up group folders as I need to see what goes where in this design pattern.

The Model:

Finished chapter 8 - the Day View Model

Starting on chapter 9 - the Week View Model  2/19/2019

Ch 10: We used a ViewModel to supply the data for each separate section. There is a lot of duplication

Git log entry:
Completed CH10 and it runs

commit 2204a398f83b0974fb297eabaee5b239229bcf68 (tag: CH10_Start, origin/weekViewModel, weekViewModel)

Ch 11: We Use a protocol to replace the duplicate lines of code.

We make each ViewModel conform to the SettingsRepresentable protocol and within the viewController set a viewModel var to be of type SettingsRepresentable.
The Swift magic happens when we set the viewController viewModel var in each section to = the discrete section ViewController.
We can then extract the text and accessoryType values from the viewModel.

CH 12:

 // In CH 12 we let the cell be responsible for configuring itself.  The ViewController is DUMB about the contents of the cell now.

from: https://cocoacasts.com/making-table-view-cells-autoconfigurable :

Protocol-Oriented Programming
I want to highlight the role of the SettingsRepresentable protocol in the story. The SettingsRepresentable protocol serves two purposes. The most obvious task of the SettingsRepresentable protocol is defining an interface. Because the view models we defined earlier conform to this protocol, the SettingsTableViewCell class only needs to have the ability to handle an object of type SettingsRepresentable.
But the SettingsRepresentable protocol performs a more important but less obvious task. It adds a layer of abstraction. The SettingsRepresentable protocol ensures that the SettingsTableViewCell class doesn't need to know about the view models we defined (SettingsViewTimeViewModel, SettingsViewUnitsViewModel, and SettingsViewTemperatureViewModel). That's an important advantage and that's the beauty and elegance of protocol-oriented programming.

CH 16:

To guarantee that the unit tests for the DayViewViewModel struct are fast and reliable, we need stubs.
The idea is simple. We fetch a response from the Dark Sky API, save it in the unit testing bundle, and load the response when we run the unit tests for the view model.


class DayView_VM_Tests: XCTestCase {

// MARK: Properties

// from https://cocoacasts.com/using-stubs-for-better-unit-tests :
// To simplify the unit tests, we won't be instantiating a view model in each of the unit tests. Instead, we create a view model, the view model we use for testing, in the setUp() method. Let me show you how that works and what the benefits are.

