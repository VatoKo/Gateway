# Gateway

---
> Simple, elegant, easy-to-use network layer for Swift
---

Gateway is very simple, elegant and easy-to-use network layer for Swift, which will help you make HTTP requests, receive responses and parse received data into Swift's native objects.
---

## Installation

**CocoaPods**
To add `Gateway` to your project you can use [`CocoaPods`](https://cocoapods.org).
* Just add `Gateway` pod to your `podfile`
```swift
    pod 'Gateway', :git => 'https://github.com/VatoKo/Gateway.git', :tag => '1.0.0'
```
* Run `pod install` command on your terminal
```swift
    pod install
```
---

## Usage example

**Simple request example**

Firstly, you should declare response's `ResultType` object.

```swift
struct User: Codable {
    var id: Int
    var name: String
    var surname: String
}
```

Then you can simply initialize `Request` object and make HTTP call.

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

**POST request with URL parameters example**

If you want to send parameters in `URL`, that's very simple.

```swift
let sampleUrl: URL = "http://sample.com"
// Just declare a dictionary with desired parameters
let parameters = [
    "name": "Jon",
    "surname": "Doe"
]
// Notice that, if there's no data in response, you can pass 'Empty' as your 'ResultType'
let request = Request<Empty>(method: .post, url: sampleUrl, urlParams: parameters)
// Here if you're not intereseted in response, you can leave completion block empty
request.send { _ in }
```

**POST request with HTTP body example**

To send some data in request's body, just pass your `Data` as a `body` parameter

```swift
let sampleUrl: URL = "http://sample.com"
let parameters = [
    "id": "123",
    "name": "Jon",
    "surname": "Doe",
    "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
]
let encodedParameters = try? JSONEncoder().encode(parameters)
// If you have any kind of data you want to send in HTTP body, just pass it as a 'body' parameter
let request = Request<Empty>(method: .post, url: sampleUrl, body: encodedParameters)
request.send { _ in }
```

If you want to send your data in `HTTP` body as a `JSON` object (as seen above), just use another `Request`-s initializer and pass your `body` parameter as a `Dictionary` directly. (The code below does the same as the code above)

```swift
let sampleUrl: URL = "http://sample.com"
let parameters = [
    "id": "123",
    "name": "Jon",
    "surname": "Doe",
    "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
]
// Here 'body' parameter is a 'Dictionary'
let request = Request<Empty>(method: .post, url: sampleUrl, body: parameters)
request.send { _ in }
```

**POST request with generic type of body**

`Gateway` is flexible enough to let you send any kind of data you want with any kind of encoding. Just use `Request`-s initializer with generic body type and also it's possible to pass your encoder function.

```swift
let sampleUrl: URL = "http://sample.com"
let list = [3, 5, 6, 3]
let request = Request<Empty>(method: .post, url: sampleUrl, body: list, bodyEncoder: { dataToEncode -> Data in
    // Encode your data however you want here. (If you omit this parameter, by default, 'Request' will encode your data as a JSON)
})
request.send { _ in }
```

**Initialize `Request` with URLRequest**

If you already have predefined `URLRequest` you can still use `Gateway` pretty easily. Just use `Request`-s initializer with `URLRequest` and let it do the job for you.

```swift
let sampleUrl: URL = "http://sample.com/user/34"
var urlRequest = URLRequest(url: sampleUrl)
urlRequest.httpMethod = "POST"
urlRequest.httpBody = "{ \"token\" = \"1717ZXASasqw43asd1#$\" }".data(using: .utf8)
urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
urlRequest.timeoutInterval = 60
let request = Request<User>(request: urlRequest)
request.send { response in 
    switch response {
    case let .success(user):
        print(user)
    case let .failure(error):
        print(error.localizedDescription)
    }
}
```

**Dispatching result handler completion block on different queues**

By default completion block in `Request`-s `send` method is executed on `background` queue. You can simply change that and make it be executed on `main` queue.

```swift
let sampleUrl: URL = "http://sample.com/user"
let request = Request<User>(url: sampleUrl)
request.send(dispatchResultOn: .main) { response in
    // Now this block of code is executed on 'main' queue and you can make UI changes here.
    switch response {
    case let .success(user):
        // Update UI according to received data
    case let .failure(error):
        print(error.localizedDescription)
    }
}
```

---

## Release History

* 1.0.0
    * First Release
* 0.0.3
    * Work in progress
    * Add pod install functionality
    * Modify podspec file
    * Add more unit test
* 0.0.2
    * Work in progress
    * Add pod install functionality
    * Add unit tests
* 0.0.1
    * Work in progress


## Team

| [Vato Kostava](https://github.com/VatoKo) | [Irakli Chkuaseli](https://github.com/irakli) |
| :---: |:---:|
| [![VatoKo](https://avatars1.githubusercontent.com/u/23338269?s=460&u=78e67779460a0b20db4999a1450c3ccabe40b8ac&v=4&s=200)](https://github.com/VatoKo)    | [![irakli](https://avatars3.githubusercontent.com/u/9796905?s=460&u=099ff334c71ed00eadb3ad931d3f4cb934661922&v=4&s=200)](https://github.com/irakli) |
| [vkost16@freeuni.edu.ge](mailto:vkost16@freeuni.edu.ge?subject=[GitHub]%20Gateway) | [ichku14@freeuni.edu.ge](mailto:ichku14@freeuni.edu.ge?subject=[GitHub]%20Gateway) |

---

## Contributing

> To get started...

### Step 1

- **Option 1**
    - 🍴 Fork this repo! (<https://github.com/VatoKo/Gateway/fork>)

- **Option 2**
    - 👯 Clone this repo to your local machine using `https://github.com/VatoKo/Gateway.git`

### Step 2

- **Create your feature branch** (`git checkout -b feature-my-cool-feature`)

### Step 3

- **Commit your changes**  (`git commit -m 'Add my cool feature'`)

### Step 4

- **Push to the branch** (`git push origin feature-my-cool-feature`)

### Step 5

- **Create a new Pull Request** (<https://github.com/VatoKo/Gateway/pulls>)

**See [``CONTRIBUTING``](https://github.com/VatoKo/Gateway/blob/master/CONTRIBUTING.md) for more information about how to make contribution.**

---

## Meta

Distributed under the MIT license. See ``LICENSE`` for more information.
