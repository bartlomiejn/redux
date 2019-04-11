# redux

Redux implementation in Swift based on a GitHub repository browser app. 

Contains a custom implementation of the state store, reducers and middlewares with a VIPER module adapted to use the state management infrastructure.

In retrospect, redux in iOS kind of doesn't make sense for two reasons:
- Total state management makes sense with the DOM and it's selective update
- It's easier to use with dynamic languages
