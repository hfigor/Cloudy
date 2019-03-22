
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

CH 19:
from: https://cocoacasts.com/what-are-the-options

Unfortunately, Swift currently doesn't have bindings. You can roll your own implementation using closures or key-value-observing. I like to refer to such solutions as "DIY bindings", "Do It Yourself bindings". That's the solution we start with. But this solution isn't scalable and it isn't terribly elegant.

Complex applications need a better solution. There are several options available, such as Bond, RxSwift, and ReactiveCocoa. The solution we'll be using in this series is RxSwift. It's the most popular option and the one I have come to appreciate most. It's also easy to pick up.

CH 24:
from: https://cocoacasts.com/refactoring-the-view-model

in the AddLocationView_VM:
We are implementing RxSwift and RxCocoa to utilize Drivers as a stream or sequence of values.
We also remove the responsibility of tracking the State (results of the geocode requests) from the ViewModel. We use Drivers for this:

We declare a constant, private property _locations of type BehaviorRelay. The BehaviorRelay is of type [Location].
You can think of a BehaviorRelay as the pipeline and [Location] as the data that flows through that pipeline.
We initialize the pipeline with an empty array of locations.

We expose two computed properties and we simply return the private behavior relays as drivers.
Let's clean up the pieces we no longer need. We can remove a few properties:
the locations property
the old query property
and the old querying property
And while we're at it, we no longer need:
the queryingDidChange property
and the locationsDidChange property

Great. The last thing we need to do is make a few changes to how the view model accesses the array of locations. The changes are minor. A reactive BehaviorRelay exposes its current value through its value property. This means we need to update:
the numberOfLocations computed property
the location(at:) method
and the geocode(addressString:) method

CH 25:
from: https://cocoacasts.com/refactoring-the-view-controller

A search bar emits a sequence of String values. We ask it for a reference to that sequence. The orEmpty operator converts any nil values to an empty string.
The asDriver() method turns the sequence into a driver. We pass this driver of type String to the initializer of the AddLocationViewViewModel class.

We can remove the remaining lines from the viewDidLoad() method.
Instead, we're going to use bindings to update the user interface if the view model performs a geocoding request and when it receives a response.

You may be wondering what we gained by introducing the Model-View-ViewModel pattern and the AddLocationViewViewModel class in the AddLocationViewController class.
Let's take a look. The view controller is no longer in charge of forward geocoding. In fact, it doesn't even know about the Core Location framework.
That's our first accomplishment. But, more important, the view controller no longer manages state. This is thanks to Rx and the Model-View-ViewModel pattern.
The less state your application manages the better and this is especially true for view controllers.

CH 26: Protocol Oriented Programing and Dependency Injection

If we want to test the AddLocationViewViewModel class, we need the ability to stub the responses of the geocoding requests we make to Apple's location services.
Only then can we write fast and reliable unit tests. Being in control of your environment is essential if your goal is creating a robust test suite.

But how do we stub the responses of the geocoding requests we make? The Core Location framework is a system framework.
We cannot mock the CLGeocoder class. The solution is simple, but it requires a bit of work.

A Plan of Action
The solution involves three steps:
First, we need to create a service that's in charge of performing the geocoding requests. That service needs to be injected into the view model.
The view model shouldn't be in charge of instantiating the service.

Second, the service we inject into the view model conforms to a protocol we define. The protocol is nothing more than a definition of an interface
that allows the view model to initiate a geocoding request. It initiates the geocoding request, it doesn't perform the geocoding request.

Third, the service conforms to the protocol and we inject an instance of the service into the view model.

Not only does this solution decouple the view model from the Core Location framework, the view model won't even know which service it's using, that is,
as long as the service conforms to the protocol we define. Don't worry if this sounds confusing. Let's start by creating the protocol for the service.
We can draw inspiration from the current implementation of the AddLocationViewViewModel class. It shows us what the protocol should look like.


CH 28: Where Do we Go From Here? (Synopsis)
from: https://cocoacasts.com/mastering-mvvm-with-swift-where-to-go-from-here

Putting the View Controllers On a Diet
First and foremost, the view controllers of the project have become skinnier, lightweight, and focused. They no longer deal with data manipulation.
In fact, the view controllers are not aware of or keep a reference to the models used in the project. Keep in mind that the goal of the Model-View-ViewModel pattern
isn't merely removing code from view controllers and dumping it into a view model. The goal is more ambitious and some benefits are more subtle.
The week view controller doesn't keep a reference to the weather data. It now uses a view model instead. It doesn't declare properties for date formatters to format dates.
They're no longer needed. And, the most substantial change, it's no longer responsible for configuring the table view cells of the table view.
The view model hands the table view a view model for each table view cell and, with the help of a protocol, the latter knows exactly how to configure itself using the view model.
You also learned that the Model-View-ViewModel pattern can be used in view controllers that aren't driven by data. The settings view controller is an example of this.
It doesn't use a model to populate itself. It merely shows the user a table view with their preferences.
The Model-View-ViewModel pattern is a good fit for almost any type of view controller. The add location view controller also underwent a dramatic change.
Before its facelift, it was in charge of handling user interaction, data manipulation, forward geocoding, and data visualization. That's no longer true after the refactoring operation.
We gained a number of key benefits. The view model is in charge of performing forward geocoding requests and the view controller no longer manages state.
Nor does the view model. Thanks to reactive programming, we only deal with streams of data. That's a significant change.
The add location view controller is focused and lightweight. It's only task is handling user interaction and displaying data to the user.
In other words, it's a view controller in the purest sense. That's something we accomplished by implementing the Model-View-ViewModel pattern.

Introducing View Models
The code we removed from the view controllers now lives in the view models we introduced in the project. What I like about these view models is their simplicity.
In their most basic form, the view models convert the raw values of the model they manage to values the view controller can directly display in the view it manages.
Even though the add location view view model is a bit more advanced, it remains focused.
We also included the logic of the user's preferences in several view models. The result is that the interface of the view models is clear and concise.
Using the view models in the view controllers and the table view cells is as simple as asking for a value to display. That's the essence of the Model-View-ViewModel pattern.

Improved Testability
I have to admit that I don't like writing unit tests, but this isn't much of a problem when testing view models. The reason is simple, writing unit tests for view models is easy.
Because you can carefully control the model that's used to instantiate the view model, unit testing becomes almost painless.
And remember that, if we were to write unit tests for the view controllers to unit test the same functionality, we would have to deal with a bunch of issues
and the setup would look more complex. Improved testability is another key benefit of the Model-View-ViewModel pattern. I hope this series has convinced you of that.

More Flexibility
It's no coincidence that the pattern is named Model-View-ViewModel and not Model-View-Controller-ViewModel. The controller still plays a part,
but you need to understand that the Model-View-ViewModel pattern is quite flexible. The implementation of the week view controller shows this.
The week view controller asks its view model for a view model for a weather day table view cell. The view controller isn't involved in configuring the table view cell itself.
The Model-View-ViewModel pattern helps configure views with view models. The view controller is still involved, but its role can sometimes be minimal.
Just remember what the Model-View-ViewModel pattern tries to accomplish and don't try to think in terms of the Model-View-Controller pattern too much.

Where to Start
You now have the knowledge to create applications that use the Model-View-ViewModel pattern.
But chances are that you have one or more projects that use the Model-View-Controller pattern. This isn't a problem, though.
It's easy to start with the Model-View-ViewModel pattern in an existing project. You don't need to spend weeks or months refactoring.
Start small. For existing projects, you don't need to choose between MVC and MVVM. Remember that MVVM is in many ways similar to MVC.

I hope you enjoyed this series on the Model-View-ViewModel pattern. If you have any questions or feedback, reach out to me. I'm here to help.
