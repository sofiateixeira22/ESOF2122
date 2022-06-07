# Product Vision

## Vision Statement

**UniEats** is a find-my-meal app that aims to list places to eat close to UP, and their menus, ordering them by relative distance to help the academic community know all their options. This app would also include a shortcut to Google Maps to show the way there.
Unlike sigarra, our product would provide an easy way to find menus of different places, much more complete and in a faster way. 

> ### 📱 What happened in the end? 
> 
> We believe we were able to deliver on our product vision because the current state of our app allows users to view menus of the restaurants closer to FEUP and the path to reach that restaurant (in Google Maps) in a very fast and pleasant way.

## Main Features

- Restaurant Login - We provide account creation and login for restaurants without online menus, in order for them to add their options to our app.
- Google Maps Link - Add information of the shortest path to the place selected
- Add Menus - To keep the information of the menus updated.
- Academic Login - Saves previous searches (history) and a list of favorite places.
- Search Bar - Allows to search for a specific restaurant/canteen and get information about the place.
- Search Filters - Filters the search for restaurants/canteens to search type of food (fast-food, traditional, vegan...), maximum distance to the local, price range, etc. 
- Sorting search results - Order the results of a specific search by price, distance, etc.
- Restaurant/Canteen Page - Information about capacity, distance to current location, average price, integration with Google Maps to help with picking, reviews of previous customers 
- Add Review - Authenticated users can add reviews to restaurants and canteens they already tried, in order to provide even more information to other users in time of decision.
- "Random Selection" Button - Choose maximum distance/price and get a recomendation

> ### 📱 What happened in the end? 
> 
> Some of this features were not implemented or only partially implemented. This happend due to either the feature not being necessary anymore or lack of better time management.
>
> These features are not implemented:
> - Restaurant Login - No longer necessary, we are using a fetcher to information from Sigarra.
> - Add Menus - Since we are using the fetcher, there was no longer a need to add a menu to a canteen/restaurant.
> - Search Filters - Due to some difficulties and lack of time in the last few weeks for the development of the project, we were unable to implement this functionality.
> - Sorting search results.
>
> This feature was partially implented:
> - "Random Selection" Button - We implemented a Random Selection Button that returns a random restaurant within the list of restaurants. This button does not have a filter for maximum distance or price.

## Assumptions and dependencies

- Google Maps API
- Access to menus, prices and schedules of the various canteens/restaurantes available at SASUP Alimentação (https://sigarra.up.pt/sasup/pt/web_base.gera_pagina?P_pagina=265689).
- Access to menus, prices, schedules, capacity of various restaurants (not related to UP - ex. Campus S.João Restaurants, Circunvalação Restaurants).
- Restaurant account (username, password) and backend support for adding menus, reviews, etc.
- Backend support for user meal history and favorites

> ### 📱 What happened in the end? 
> 
> Some of this dependencies were not needed and some were replaced by alternatives: <br>
> - Google Maps API - after some trouble regarding the required payment methods for this API. Because of that, we ended up implementing a way to open the Google Maps app directly from our app, which we think is a worthy replacement. 
> For Backend support - Info for Restaurants, Reviews, Favorites, FAQs - we ended up using our own Firestore Database, as it is a free alternative that allows us to complete our basic funcionalities that needed storage in a way that can be used by users. 