//
//  HTTPURLResponse+Successful.swift
//  Gateway
//
//  Created by Vato Kostava on 7/9/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public extension HTTPURLResponse {
    
    var isSuccessfull: Bool {
        return 200..<300 ~= statusCode
    }
    
}
