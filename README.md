# PAYBACK Coding Challenge

## 👨 Author: Jakub Legut
 - [LinkedIn](https://www.linkedin.com/in/jakub-legut/)
 
 ## 🧾 Description:
 The project is built on the **Composable Architecture** (TCA v1.9.2) using *Async Await*. SPM is used to properly distribute the project into modules - making it scalable and enabling collaboration among multiple individuals on a single project. The application logic and views are separated, facilitating easier management of changes. `TransactionList` is a view of transaction lists, with two icons in the top right corner: one for filtering by categories, and the other for data refresh (useful in case of random fail implementation). Additional packages have been prepared for future application functionalities (Feed, Settings...). **Tests** have also been written for the `TransactionList` (located in the `TransactionFeatureTests` file).
 
 ## 💾 Scheme Descriptions:

- **Mock-WorldOfPAYBACKApp:** Utilizes hardcoded JSON as the data source.
- **Stage-WorldOfPAYBACKApp:** Utilizes the test API [https://api-test.payback.com/transactions](https://api-test.payback.com/transactions).
- **Prod-WorldOfPAYBACKApp:** Utilizes the production API [https://api-test.payback.com/transactions](https://api-test.payback.com/transactions).

However, all versions have support for random fail.

## ⚙️ Project Tech stack
- [Xcode](https://developer.apple.com/xcode/)
- [Swift](https://swift.org/)
- [SwiftGen](https://github.com/SwiftGen/SwiftGen)
- [Fastlane](https://github.com/fastlane/fastlane)
- [ComposableArchitecture](https://github.com/pointfreeco/swift-composable-architecture)

## 🛠 Project Setup
- fetching strings command [Terminal]: `fastlane appStrings`
- generate Localizations /PaybackPackage [Terminal]: `swiftgen config run`

```
                                                                                                                          
                                                     +----------------------+                                             
                                                     |                      |                                             
                                                     | World of Payback App |                                             
                                                     |                      |                                             
                                                     +-----------|----------+                                             
                                                                 |                                                        
                                                                 |                                                        
                                                           PaybackPackage                                                 
                                                                 |                                                        
         +-------------------------------------------------------|-------------------------------------------------------+
         |                                            +----------------------+                                           |
         |                                            |                      |                                           |
         |                            +-------------- |    PaybackPackage    | ---------------+                          |
         |                            |               |                      |                |                          |
         |                            |               +----------------------+                |                          |
         |                                                                                                               |
         |                +----------------------+                                +----------------------+               |
         |                |                      |                                |                      |               |
         |           +--- |       CoreLogic      |---+                        +---|          UI          |---+           |
         |           |    |                      |   |                        |   |                      |   |           |
         |           |    +----------------------+   |                        |   +----------------------+   |           |
         |   +-------------------+       +-------------------+        +-------------------+      +-------------------+   |
         |   |                   |       |                   |        |                   |      |                   |   |
         |   |      Logic A      |       |      Logic B      |        |     Feature A     |      |     Feature B     |   |
         |   |                   |       |                   |        |                   |      |                   |   |
         |   +-------------------+       +-------------------+        +-------------------+      +-------------------+   |
         |                                                                                                               |
         |                                                                                                               |
         +---------------------------------------------------------------------------------------------------------------+
                                                                                                                          
```
diagram source: `https://textik.com/#c92777c71a477457`

A new App named **WorldOfPAYBACK** is planned to be released. One of its first features involves displaying a list of transactions, and a corresponding detail screen for each.

## "WorldOfPAYBACK" App - Requirements

Please create a SwiftUI App based on the following User-Stories:

* ✅ As a user of the App, I want to see a list of (mocked) transactions. Each item in the list displays `bookingDate`, `partnerDisplayName`, `transactionDetail.description`, `value.amount` and `value.currency`. *(see attached JSON File)*
* ✅ As a user of the App, I want to have the list of transactions sorted by `bookingDate` from newest (top) to oldest (bottom).
* ✅ As a user of the App, I want to get feedback when loading of the transactions is ongoing or an Error occurs. *(Just delay the mocked server response for 1-2 seconds and randomly fail it)*
* ✅ As a user of the App, I want to see an error if the device is offline.
* ✅ As a user of the App, I want to filter the list of transactions by `category`.
* ✅ As a user of the App, I want to see the sum of filtered transactions somewhere on the Transaction-list view. *(Sum of `value.amount`)*
* ✅ As a user of the App, I want to select a transaction and navigate to its details. The details-view should just display `partnerDisplayName` and `transactionDetail.description`.
* ✅ As a user of the App, I like to see nice UI in general. However, for this coding challenge fancy UI is not required.

## "WorldOfPAYBACK" App - General Information

* Attached you will find a JSON File (`PBTransactions.json`) which contains a list of transactions. Just assume that the Backend is not ready yet and the App needs to work with mocked data meanwhile. For now, the Backend-Team has just provided the name of the endpoints for the new Service: 
	* Production Environment: "GET https://api.payback.com/transactions"
	* Test Environment: "GET https://api-test.payback.com/transactions"
* The App is planned to be maintained over a long period of time. New Features will be added by a growing Team in the near future.
* The App is planned to be available worldwide supporting many different languages and region related formatting (e.g. Date and Number formatting).
* The Feature you are currently working on is the first out of many. Multiple Teams will add more features in the near future (overall Team size is about 8 Developers and growing). The following list of Features (which are not part of this coding challenge) will give you an idea of what's planned for the upcoming releases.
 
	1. 	"Feed"-Feature: Displays different, user-targeted content (displayed via webviews, images, ads etc.). **Note:** It is also planned to display the sum of all Transactions from the "Transaction"-Feature.
	2. "Online Shopping"-Feature: Lists PAYBACK Partners and gives the possibility to jump to their App/Website.
	3. "Settings"-Feature: Gives the possibility to adjust general Settings.

## PAYBACK Environment

* We are currently in a transition phase of moving from UIKit to SwiftUI.
* We use Reactive programming and are currently moving from a self built Reactive-Library to Combine. For asynchronous code we are moving to Swift Concurrency.
* We try to keep to as few external dependencies as possible. However, we use Swift Package Manager when we need to add a dependency.
* We are using Jenkins to build, test and deploy our Apps.

## Disclaimer

All rights reserved, 2022 Loyalty Partner GmbH. Any transfer to third parties and/or reproduction is not permitted.
