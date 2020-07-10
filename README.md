# Gateway

---
> Simple, elegant, easy-to-use network layer for Swift
---

Gateway is very simple, elegant and easy-to-use network layer for Swift, which will help you make HTTP requests, receive responses and parse received data into Swift's native objects.
---

## Installation

> TODO: Add instalation guides
---

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
---

## Release History

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
