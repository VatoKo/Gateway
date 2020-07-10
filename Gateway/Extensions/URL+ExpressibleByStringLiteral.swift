//
//  URL+ExpressibleByStringLiteral.swift
//  Gateway
//
//  Created by Vato Kostava on 7/9/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    
    
    /// Initializes URL from string literal
    /// - Parameter value: String literal value
    ///
    /// Usage:
    ///     let url: URL = "http://sample.com"
    public init(stringLiteral value: String) {
        self.init(string: value)!
    }
    
}
