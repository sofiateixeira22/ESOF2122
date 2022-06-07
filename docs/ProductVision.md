# Product Vision

## Vision Statement

**UniEats** is a find-my-meal app lists places to eat close to FEUP, and their menus, in a way that can help the academic community to know all their options. This app includes also a button to open Google Maps to show the path to reach any restaurant available.
Unlike sigarra or '[Menu FEUP](https://play.google.com/store/apps/details?id=com.pedropt.android.menufeup)', our product would provides a pleasant and easy way to find menus of different places, much more complete and in a faster way. 

## Main Features

- Google Maps Link - Button to open Google Maps with the coordinates of a chosen restaurant, allowing the user to view the shortest path to the place selected;
- Academic Login - Implemented by uni, allows the user to save a list of favorite places and create reviews;
- Search Bar - Allows to search for a specific restaurant/canteen and get information about the place;
- Restaurant/Canteen Page - Information about capacity, distance to current location, average price, integration with Google Maps to provide directions, menus, reviews of previous customers;
- Add Review - Authenticated users can add reviews to restaurants and canteens they already tried, in order to provide even more information to other users in time of decision;
- "Random Selection" Button - We implemented a Random Selection Button that returns a random restaurant within the list of restaurants. This button does not have a filter for maximum distance or price.

## Assumptions and dependencies

- Google Maps App connection - With the coordinates of the restaurant we can open the app with a pin, allowing a user to view the path to the restaurant;
- Backend support - Info for Restaurants, Reviews, Favorites and FAQs - using our own Firestore Database, a free alternative that allows us to complete our basic funcionalities that needed storage in a way that can be used by users.
- Access to menus and schedules of the various canteens/restaurantes available at [SASUP Alimentação](https://sigarra.up.pt/sasup/pt/web_base.gera_pagina?P_pagina=265689) and [sigarra FEUP](https://sigarra.up.pt/feup/pt/cantina.ementashow).