//
//  JSONParameterEncoder.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncodable {
    
    public static func encode(parameters: Parameters, in request: URLRequest) throws -> URLRequest {
        guard !parameters.isEmpty else { return request }
                
        do {
            var newRequest = request
            let encodedData = try JSONEncoder().encode(parameters)
            newRequest.httpBody = encodedData
            
            if newRequest.value(forHTTPHeaderField: ContentType.header) == nil {
                newRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: ContentType.header)
            }
            return newRequest
        } catch {
            throw GatewayError.genericError /* TODO: throw proper error here */
        }
    }
    
}
