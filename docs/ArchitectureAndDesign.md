## Architecture and Design

The uniEats project will be organized in three main packages, the User Interface package, the Logic package and the Storage Package. There will also be packages to deal with interactions with external systems, such as the Google Maps API and the Backend API

### Logical architecture

- The **uniEats UI** package will deal with the display and user interface
- The **uniEats Logic** package will deal with the users' requests, such as searching for a restaurant, reviewing a restaurant. This package will communicate with the Backend and Google Maps via the packages **Google Maps API** and **Backend API**, respectively
- The **Storage** package will serve to store local information on the users' phone, such as search history
- The **Google Maps API** will serve as an interface to communicate with Google Maps
- The **Backend API** will serve as an interface to communicate with the Backend Server

The following diagram explains this package structure.

![DeploymentView](/images/PackagesDiagram.png)

### Physical architecture

- The **uniEats app** artifact will be the app running on users' phones.
- The **Backend API** will be running on the Backend server and receiving http requests from the **uniEats app**
- The **SIGARRA Website** will be running in the SIGARRA Server and will be accessed by the **Backend API**
- The **Google Maps API** will be running in some Google Server and will be used directly be the uniEats app

> ### 📱 What happened in the end? 
> 
> Instead of using a backend API we ended up using a database Firebase developed by Google.
>
> Our database stores:
> - List of restaurants - contains all the restaurants/canteens the app is using.
> - Favorites - contains the list of favorite restaurants added by a user.
> - Reviews - contains the list of reviews for a restaurant.
> - Faqs - contains all the frequently asked questions and their answers for the app.
<br>

![DeploymentView](/images/DeploymentDiagram.png)

### Vertical prototype

As a first iteration (number #0) on our **uniEats app** we began our project with the most recent version of the **uni app**, allowing an easier integration with this app in the future. 

As a way to explore flutter technologies, we implemented initial versions of various screens for our app. 
#### Features Implemented:

- Button in Navigation Drawer of **uni** to access **uniEats app**:

![UniEats access Button](/images/vertical_prototype/unieats_access_button.png)

- "HomePage" with buttons to access the 'favourites' and the 'history' pages and Restaurant Card Placeholders:

![UniEats Homepage](/images/vertical_prototype/unieats_home_page.png)

- UniEats Navigation Drawer with "Favourites", "History", "About" and "Return to **Uni**":

![UniEats Navigation Drawer](/images/vertical_prototype/unieats_nav_drawer.png)

- Favourites page:

![UniEats Favourites Page](/images/vertical_prototype/unieats_favourites_page.png)

- History page:

![UniEats History Page](/images/vertical_prototype/unieats_history_page.png)

- About page, with our app credits: 

![UniEats About Page](/images/vertical_prototype/unieats_about_page.png)