Dependencies
No external libraries, required iOS version is 8.4

Structure
AppDelegate - Application delegate
ViewController - Controller with UI on Main.storyboard
Tasks / - Group of tasks:
 - ALWebOperation: Base class for all operations. Subclassing: processContent should be overridden
 - ALFindCharacterOperation: task to find first 10th character
 - ALFindRepeatingCharacterOperation: task to find every 10th character
 - ALWordCountOperation: task to count instance of every word in the content
 