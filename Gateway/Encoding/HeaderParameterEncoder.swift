//
//  HeaderParameterEncoder.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public struct HeaderParameterEncoder: ParameterEncodable {
    
    public static func encode(parameters: Parameters, in request: URLRequest) -> URLRequest {
        var newRequest = request
        parameters.forEach {
            newRequest.setValue($1, forHTTPHeaderField: $0)
        }
        return newRequest
    }
    
}
