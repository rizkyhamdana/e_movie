<!-- PROJECT LOGO -->
<br />
<div align="center">
    <img src="/readme/app_icon.png" alt="Logo" width="80">
  <h3 align="center">E-Movie App</h3>

  <p align="center">
    Application that show List Movie
  </p>
</div>

##

## Built With

* <a href="https://dart.dev/">
    <img src="https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg" alt="Dart" width="24"> 
  </a>  
   &nbsp;&nbsp;Dart 3.0.5
  


* <a href="https://flutter.dev/">
    <img src="https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg" alt="Flutter" width="24"> 
  </a>
   &nbsp;&nbsp;Flutter 3.10.5



## Installation

Make sure you have Flutter SDK installed on your system. If not, refer to the official Flutter documentation for installation instructions.

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/rizkyhamdana/e_movie.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Features

* Splash
* Home
* Movie List(TopRated, Now Playing, Top Rated, Popular)
* TV Show List(Top Rated, Popular, Airing Today, On The Air)
* Search(Movie/TV Show)
* Wathclist
* Details Movie
* Details TV Show
  
## Screenshots


### Splash Screen
[<img src="/readme/ss1.png" align="left"
width="200"
    hspace="10" vspace="10">](/readme/ss1.png)
    
### Main Feature List Movie/TV Show
[<img src="/readme/ss2.png" align="left"
width="200"
    hspace="10" vspace="10">](/readme/ss2.png)
[<img src="/readme/ss3.png" align="center"
width="200"
    hspace="10" vspace="10">](/readme/ss3.png)

### Search List
[<img src="/readme/ss4.png" align="center"
width="200"
    hspace="10" vspace="10">](/readme/ss4.png)
[<img src="/readme/ss5.png" align="center"
width="200"
    hspace="10" vspace="10">](/readme/ss5.png)

### Watch List
[<img src="/readme/ss6.png" align="left"
width="200"
    hspace="10" vspace="10">](/readme/ss6.png)
[<img src="/readme/ss7.png" align="center"
width="200"
    hspace="10" vspace="10">](/readme/ss7.png)
### Details
[<img src="/readme/ss8.png" align="left"
width="200"
    hspace="10" vspace="10">](/readme/ss8.png)
[<img src="/readme/ss9.png" align="center"
width="200"
    hspace="10" vspace="10">](/readme/ss9.png)
[<img src="/readme/ss10.png" align="center"
width="200"
    hspace="10" vspace="10">](/readme/ss10.png)
[<img src="/readme/ss11.png" align="center"
width="200"
    hspace="10" vspace="10">](/readme/ss11.png)

## Libraries & Tools Used

* [Flutter BLOC](https://pub.dev/packages/flutter_bloc)
* [Auto Route](https://pub.dev/packages/auto_route)
* [Injectable](https://pub.dev/packages/injectable)
* [Get-It](https://pub.dev/packages/get_it)
* [Pretty JSON](https://pub.dev/packages/pretty_json)
* [Dio](https://pub.dev/packages/dio)
* [Equtable](https://pub.dev/packages/equatable)
* [Lottie](https://pub.dev/packages/lottie)
* [Shimmer](https://pub.dev/packages/shimmer)
* [intl](https://pub.dev/packages/intl)
* [Awesome Dialog](https://pub.dev/packages/awesome_dialog)
* [Cached Network Image](https://pub.dev/packages/cached_network_image)
* [Sqflite](https://pub.dev/packages/sqflite)
* [Path](https://pub.dev/packages/path)
* [Path Provider](https://pub.dev/packages/path_provider)
### Auto Generate
* [Auto Route Generator](https://pub.dev/packages/auto_route_generator)
* [Injectable Generator](https://pub.dev/packages/injectable_generator)


## Permissions

- Full Network Access.
- View Network Connections.