# green-code-assignment

Record sport performance results and store them in local storage and remote storage 

## Design process: 

It is quite simple app, that consists of only two screens. List of results and form to enter new record. My goal was to create as simple app, as possible.

###  List of results
List of results have to be easily readable for the user. There is add button in the top right corner, as in Apple guidelines. Segmented control on top filters records by storage type. Cell displays all the required info. 

    Additional:
    - info with add record button, if screen is empty
    - loading and reloading ability for tableView
    - automatically sorts records, new ones are on top

### Add result form
After tapping add button, add result form is modally presented. It has cancel and save buttons in navigation bar. User enters name, place (that could be improved by picking from map or by asking for users current location). Save button checks, if all the fields were filled, then saves result and reloads list.
    

## Features:

 - Firebase Firestore storage was used, unique records for each device 
 - Local repository uses UserDefaults with property wrapper
 - I decided to work without libraries (Snapkit, PromiseKit, Swinject...), I only used FirebaseFirestore to obtain data and SwiftLint for code linting
 - MVVM-C architecture
 - Dependency injection for Remote service
 - works in portrait and landscape
 - supports dark mode
