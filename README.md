# 3LEIC02T4

## UniEats Development Report

Welcome to the documentation pages of **UnitEats**!

You can find here detailed information about our product, from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by the discipline of Software Engineering:
- Business modeling
  - Product Vision
  - Elevator Pitch
- Requirements
  - Use Case Model
  - User Stories
  - Domain Model
- Architecture and Design
  - Logical Architecture
  - Physical Architecture
  - Vertical Prototype
  

## Members

| Name | UP Number |
| :----: | :-----: |
| Ana Matilde Guedes Perez da Silva Barra |	201904795 |
| Ana Rita Antunes Ramada	| 201904565 |
| Maria Sofia Diogo Figueiredo	| 201904675 |
| Pedro Manuel Bernardo Azevedo	| 201905966 |
| Ana Sofia de Castro Teixeira	| 201906031 |

## Use Case Diagrams

Academic Login - Saves previous searches (history) and a list of favorite places.

- Search Bar - Allows to search for a specific restaurant/canteen and get information about the place.
- Search Filters - Filters the search for restaurants/canteens to search type of food (fast-food, tradicional, vegan...), maximum distance to the local, price range, etc. 

- Restaurant/Canteen Page - Information about capacity, distance to current location, average price, integration with Google Maps to help with pi   cking, reviews of previous customers 

 ![CaseDiagram](/UseCaseDiagram.png)

|||
| --- | --- |
| *Name* | Search Restaurants |
| *Actor* |  Customer | 
| *Description* | The customer searches for restaurants using a search word or by categories. |
| *Preconditions* | - The customer has a phone and can type??? <br> - There are restaurants registered in the app |
| *Postconditions* | -  |
| *Normal flow* | 1. The customer accesses the uniEats app<br> 2. The system shows the search bar and category options.<br> 3. The customer types the search/query word<br> 4. If wanted, the costumer may choose categories<br> 5. The system shows the search results matching the search word and categories<br> 6. The system redirects the customer to Electronic Payment.<br> 7. The system delivers the electronic tickets to the customer with a unique identifier and QR code. |
| *Alternative flows and exceptions* | 1. [Search failure]  In a case where no restaurants are found, i.e. no restaurants exist with said name, the user receives an error message.|

|||
| --- | --- |
| *Name* | View Restaurant Info and Menu |
| *Actor* | User | 
| *Description* | The user opens a restaurant info page andsee the menu, their Reviews/rating and the way to them |
| *Preconditions* | - The User has a phone and the app <br> - There are restaurants registered in the app  <br> - The restaurant location |
| *Postconditions* | - the user has access to the path to the restaurant  <br> - The user get restaurant menu <br> - The user get Reviews/rating of the restaurant |
| *Normal flow* | 1. The user accesses the uniEats app search bar <br> 2. The system shows restauurants <br> 3. The user types access the restauurant <br> 4. The system shows the info of the Restaurant (rate, normal prices ...) <br> 5. If wanted, the user may choose to see menu <br> 6. If wanted, the user may choose to see Reviews <br> 7.  If wanted, the user may access the path to restaurant (google Maps) |
| *Alternative flows and exceptions* | 1. [page  does not exist] In a case where does not exist restaurant page , the user receives an error message. <br> 2. [page fault] information that has been corrupted or missing is replaced by a general message|


## Acceptence Tests

### **Feature**: Login

**Scenario**: Visitor wants to login
Given a valid username *xpto* and a valid password *abc*
When Visitor is on the login page and clicks the button *Login*
Then the Visitor becomes a User and will be redirected to the Homepage.

### **Feature**: Register

**Scenario**: Visitor wants to register
Given an unused username *xpto* and a strong password *abc*
When Visitor is on the register page and clicks the button *Register*
Then the Visitor becomes a User and will be redirected to the Homepage.

### **Feature**: Recover password

**Scenario**: Visitor forgot password
Given a valid username *xpto* and a valid email *123@456.com*
When Visitor wants to recover password and clicks the button *Forgot Password*
Then Visitor will be redirected to a Recover Password page and will be able to input a new password *abc*.

### **Feature**: Information pages

**Scenario**: User wants to see Homepage
Given the User is on any page of the app
When User clicks on the Homepage button *Homepage*
Then it will be redirected to the Homepage.

**Scenario**: User wants to see FAQ page
Given the User is on any page of the app
When User cliks on the FAQ button *FAQ*
Then it will be redirected to the FAQ page.

**Scenario**: User wants to see About page
Given the User is on any page of the app
When User cliks on the About button *About*
Then it will be redirected to the About page.

**Scenario**: User wants to see Contacts page
Given the User is on any page of the app
When User cliks on the Contacts button *Contacts*
Then it will be redirected to the Contacts page.

### **Feature**: User Profile

**Scenario**: Academic User wants to see own profile
Given a logged in session and the Academic User is on any page of the app
When Academic User clicks on the Profile button *My Profile*
Then it will be redirected to their Profile page.

**Scenario**: Academic User search history
Given a logged in session and the Academic User is on their Profile page
When Academic User clicks on the button *View History*
Then it will be redirected to their Search History page.

**Scenario**: Academic User favorite restaurant
Given a logged in session and the Academic User is on a Restaurant page
When Academic User clicks on the button *Like*
Then the restaurant will be added to Academic User's favorites list.

**Scenario**: Academic User favorite list
Given a logged in session and the Academic User is on their Profile page
When Academic User clicks on the button *Favorites*
Then it will be redirected to their Favorites List page.

### **Feature**: Add Menu

**Scenario**: Restaurant Owner adds menu
Given a logged in session
When Restaurant Owner wants to add a menu
Then Menu is added to Restaurant

### **Feature**: Block account

**Scenario**: Admin blocks an account
Given a valid username *xpto* and user is not blocked
When Admin wants to block an Authenticated User
Then Authenticated User account is blocked

### **Feature**: Unblock account

**Scenario**: Admin blocks an account
Given a valid username *xpto* and user is blocked
When Admin wants to unblock an Authenticated User
Then Authenticated User account is unblocked

### **Feature**: Delete account

**Scenario**: Restaurant Owner deletes own account
Given a logged in session
When Restaurant Owner wants to delete their own account
Then Restaurant O is deleted

**Scenario**: Admin deletes an account
Given a valid username *xpto*
When Admin wants to delete an Authenticated User
Then Authenticated User account is deleted

