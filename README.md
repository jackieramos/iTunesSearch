# iTunesSearch

## Overview

This Application is built using the MVVM design patter. It basically takes advantage of the view model concept to help separate the view's construction/declaration codes from the business logic and state representation. Decoupling this parts of code allows the architecture to independently manage responsibilities making it clean, readable and organized in a sensible way while having the flexibility for different purposes. It provides component testability, scalable and reusable solution by not having interconnected dependencies from each other.

It uses RxSwift/RxCocoa for data binding.

## Networking

This app uses Alamofire in doing API calls for a more versatile network layer.

## State Management

The state management is being implemented thru Core Data. The last state view model is being saved so that it can be easily accessed again.
