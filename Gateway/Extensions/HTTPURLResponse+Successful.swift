//
//  HTTPURLResponse+Successful.swift
//  Gateway
//
//  Created by Vato Kostava on 7/9/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public extension HTTPURLResponse {
    
    /// Returns true if HTTP status code is in range [200, 300), false otherwise
    var isSuccessful: Bool {
        return 200..<300 ~= statusCode
    }
    
}
