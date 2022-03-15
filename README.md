# Team name

## Members

| Name | UP Number |
| :----: | :-----: |
| Ana Matilde Guedes Perez da Silva Barra |	201904795 |
| Ana Rita Antunes Ramada	| 201904565 |
| Maria Sofia Diogo Figueiredo	| 201904675 |
| Pedro Manuel Bernardo Azevedo	| 201905966 |
| Ana Sofia de Castro Teixeira	| 201906031 |

# UniEats

## Vision Stament

- UniEats is a find-my-meal app that aims to list places to eat close to UP, and their menus, ordering them by relative distance to help the academic community know all their options. This app would also include a shortcut to Google Maps to show the way there.
Unlike sigarra, our product would provide an easy way to find menus of different places, much more complete and in a faster way. 

## Main Features

- Restaurant Login - We provide account creation and login for restaurants without online menus, in order for them to add their options to our app.
- Google Maps Link - Add information of the shortest path to the place selected
- Add Menus - To keep the information of the menus updated.
- Academic Login - Saves previous searches (history) and a list of favorite places.
- Search Bar - Allows to search for a specific restaurant/canteen and get information about the place.
- Search Filters - Filters the search for restaurants/canteens to search type of food (fast-food, tradicional, vegan...), maximum distance to the local, price range, etc. 
- Sorting search results - Order the results of a specific search by price, distance, etc.
- Restaurant/Canteen Page - Information about capacity, distance to current location, average price, integration with Google Maps to help with pi   cking, reviews of previous customers 
- Add Review - Authenticated users can add reviews to restaurants and canteens they already tried, in order to provide even more information to other users in time of decision.
- "Random Selection" Button - Choose maximum distance/price and get a recomendation

## Required API's

- Google Maps API
- Access to menus, prices and schedules of the various canteens/restaurantes available at SASUP Alimentação (https://sigarra.up.pt/sasup/pt/web_base.gera_pagina?P_pagina=265689)
- Access to menus, prices, schedules, capacity of various restaurants (not related to UP)
- Restaurant account (username, password) and backend support for adding menus, reviews, etc.
- Backend support for user meal history and favorites

## Use Case Diagrams

Academic Login - Saves previous searches (history) and a list of favorite places.

- Search Bar - Allows to search for a specific restaurant/canteen and get information about the place.
- Search Filters - Filters the search for restaurants/canteens to search type of food (fast-food, tradicional, vegan...), maximum distance to the local, price range, etc. 

## User Stories - list (depois passar para o github)

- Restaurant Login (all)
- Academic Login (all)
- Restaurant Register (all)
- Logout (all users)
- Recover Password (all users)
- Add Menu (Restaurant Login only)

- Search Restaurant (visitor)
- Search Restaurant with filters (visitor)
- View search history (academic user)
- Favourite restaurant (academic user)
- View favorite list (academic user)

- Random Restaurant ()
- Review Restaurant (academic user)


- See Home (all)
- See About (all)
- Consult FAQ (all)
- Consult Contacts (all)

- Visitor:
As a Visitor,
I want to login into the system,
So that I can access private features and information.

As a Visitor,
I want to register into the system,
So that I can authenticate myself into the system.

As a Visitor,
I want to sign in into the system,
So that I can access private features and information.

As a Visitor,
I want to be able to search restaurants,
So that I can access their information.

As a Visitor,
I want to be able to filter my search,
So that I can find restaurants easier.





- Academic user
As an authenticated user I want to save a favorite restaurant, so that later I can have a faster access to it.

As an authenticated user I want to view my favorite list, so that I can have a faster access to the restaurants I'm most interested in.

As an authenticated user I want to


- Restaurant User
- Academic User
- Admin
- User