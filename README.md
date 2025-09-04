
# Ios Test App

This app is about like social media home screen, it is built with SwiftUI + MVVM architecture and Core data used for data persitence. 
This app  have two screen first one  have showing list of post created by multiple authors.

In first screen we are showing Gradient cards as list of post having different color and showing author profile, author name, author company name and post title , the data mentioned above are fetching from Api and render dynamically with adapt UI which supports all type of screen both vertical and horizontal orientation.

In second screen is post detail screen, we are fetching by id in api, and render neccessity data.Also implemented smooth  animation between two screens while navigating.


--> MVVM(Model-View-ViewModel) for clean separation.
--> SwiftUI for UI development
--> Core data for Local persitence
--> URLSession for networking

## API Reference

Base Url
```
https://jsonplaceholder.typicode.com
```
#### Get all Post(to fetch all post)

```http
  GET /posts
```
#### Get all UsersList(to fetch all usrrs)

```http
  GET /users
```


#### Get post detail by id

```http
  GET /post/${id}
```




## Screenshots

![App Screenshot](https://raw.githubusercontent.com/BalaMuruganSoftsuave/ios_Post_app/refs/heads/main/ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-09.png)

![App Screenshot](https://raw.githubusercontent.com/BalaMuruganSoftsuave/ios_Post_app/refs/heads/main/ScreenShots/Simulator%20Screenshot%20-%20iPhone%2016.png)

![App Screenshot](https://raw.githubusercontent.com/BalaMuruganSoftsuave/ios_Post_app/refs/heads/main/ScreenShots/IMG_0438.PNG)

