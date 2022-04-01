## Requirements
 In this section, it's described the requirements for the projects model: functional and non-functional requirements.

### Use case model

Academic Login - Saves previous searches (history) and a list of favorite places.

- Search Bar - Allows to search for a specific restaurant/canteen and get information about the place.
- Search Filters - Filters the search for restaurants/canteens to search type of food (fast-food, tradicional, vegan...), maximum distance to the local, price range, etc. 

- Restaurant/Canteen Page - Information about capacity, distance to current location, average price, integration with Google Maps to help with pi   cking, reviews of previous customers 

 ![CaseDiagram](/images/UseCaseDiagram.png)


 

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

### Domain model

The Conceptual Domain Model contains the identification and description of the entities of the domain and the relationships between them in an UML class diagram.
For each class, the attributes, associations and constraints are included in the following diagram.

 ![Domain Model](/images/DomainModel.png)

#### Brief Description of each class

- **User** - SuperClass of the users with a registered account in *UniEats*, its only attribute saves the full name of the account holder. This class subclasses are: 
    - **AcademicUser** - For accounts with a valid *Sigarra* login, i. e. students and faculty. They can login in to the app with their unique academic code (ex.: up201901010) and their *Sigarra* password. This type of user can keep a favourite places to eat list, a history of previously viewed places. They can also write reviews in Restaurant Pages to describe their experience.

    - **RestaurantUser** - This accounts can be created in our app so that a Restaurant Owner can add their Restaurant as an available on in our app, allowing people from the academic community acess to their menus. Their login is made with a username and a password, defined at time of register. 

- **PlacetoEat** - This class saves relevant information of a Canteen or Restaurant present in our app so that possible customers can view it. The goal of the information saved by this class is to help people decide that a certain place is where they want to eat today.  

- **Menu** - This class saves the set of meals available in a certain day for the restaurant selected.

- **Meal** - This class saves the specific meal available at a certain date in a restaurant. With a short description, a mealType ("Carne", "Dieta", "Peixe" or "Vegetariano"), and a price well defined, it provides a more simple way of deciding what to eat and where each day.

- **Address** - This class keeps all the important information about the location of a "PlaceToEat", so that people can find it more easily.

- **Review** - It represents a comment made by an Academic User about a certain restaurant, allowing other users more information about, for instance, community favourite dishes and best our of the day to visit that place to eat. The star rating defined by the reviewer will influence the general PlaceToEat starRating, so that it is always updated.

- **FAQ** - This class saves frequently asked questions, allowing users a fast response to some doubts they might have.
