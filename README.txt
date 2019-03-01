
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





