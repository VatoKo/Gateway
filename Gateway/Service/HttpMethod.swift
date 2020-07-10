//
//  HttpMethod.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation


/// HTTP Methods
public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
