# Gateway
> Simple, elegant, easy-to-use network layer for Swift

Gateway is very simple, elegant and easy-to-use network layer for Swift, which will help you make HTTP requests, receive responses and parse received data into Swift's native objects.

## Installation

> TODO: Add instalation guides

## Usage example

Firsly, you should declare response's result type object.

```swift
struct User: Codable {
    var id: Int
    var name: String
    var surname: String
}
```

Then you can simply initialize Request object and make HTTP call.

```swift
let sampleUrl: URL = "http://sample.com/user"
let request = Request<User>(url: sampleUrl)
request.send { response in
    switch response {
    case let .success(user):
        print(user)
    case let .failure(error):
        print(error.localizedDescription)
    }
}
```

## Release History

* 0.0.1
    * Work in progress

## Meta

Vato Kostava – vkost16@freeuni.edu.ge
Irakli Chkuaseli – ichku14@freeuni.edu.ge

Distributed under the MIT license. See ``LICENSE`` for more information.

[VatoKo](https://github.com/VatoKo)
[irakli](https://github.com/irakli)

## Contributing

1. Fork it (<https://github.com/VatoKo/Gateway/fork>)
2. Create your feature branch (`git checkout -b feature-my-cool-feature`)
3. Commit your changes (`git commit -m 'Add my cool feature'`)
4. Push to the branch (`git push origin feature-my-cool-feature`)
5. Create a new Pull Request
