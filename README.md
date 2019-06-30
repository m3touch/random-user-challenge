
<p align="center">
    <img src="RandomUsersChallengeScreens_big.png" width=900>
</p>

# Random Users Challenge

This application demostrates an approach that fetches information from the [RandomUsers API](https://randomuser.me), filters them given some parameters, shows forward information about Random Users and stores user deletions to avoid showing that items in future sessions. The aim was to follow as much as possible SOLID and programming best practices through a Clean Arquitecture.

<p> INDEX <br>
  • <a href="#scenes">Scenes</a> <br>
  • <a href="#data-persistance">Data persistance</a> <br>
  • <a href="#automated-testing">Automated Testing</a> <br>
  • <a href="#project-depenedencies">Project Depenedencies</a> <br>
</p>

## Scenes

### List Scene
The users information is displayed inside an infinite table view that loads Random User basic information as the user consumes it. Given a typed text inside the search box the items can be filtered. To achieve a more conscise search, it is possible to choose between 3 different categories: Name, Surname and email.

The user can choose to not see animore a Random User by swipping over the user cell and deleting it.

### Detail Scene
This scene shows further information about the selected Random User.

## Data Persistance
The followed approach has been to store a sequence of Random User unique identifiers provided by the 'login' properties of the fetched response. This sequence is stored permanently in the Documents folder of the device in order to maintain data consistency. This system has been extracted with a protocol `DataPersistanceProtocol` in order to give flexibility at time of changing the persistance format, even the persisted data.

## Automated Testing
The project includes unit testing for the main classes and UI tests for the use cases of the app.

## Project Depenedencies
This project uses the following pod dependencies:
  • [Alamofire](https://github.com/Alamofire/Alamofire): HTTP client service management simplification.
  • [Alamofire Image](https://github.com/Alamofire/AlamofireImage): Asynchron image load from an url.
  • [Swiftlint](https://github.com/realm/SwiftLint): Code styling.
  • [OHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs): Connection response stubbing.

<b>XCode</b>: Version 10.2 (10E125)
<b>Swift</b>: Version 5.0

## Documentation

Following you can find the [application documented classes](RandomUserChallenge/docs/index.html) (generated with [Jazzy](https://github.com/realm/jazzy)).