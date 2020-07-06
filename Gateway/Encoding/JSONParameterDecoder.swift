//
//  JSONParameterDecoder.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public struct JSONParameterDecoder<ResultType: Decodable>: ParameterDecodable {
    public typealias ResultType = ResultType
    
    public func decode(data: Data?, response: URLResponse?) throws -> ResultType {
        guard let data = data else { throw GatewayError.genericError  /* TODO: throw proper error here */ }
        
        do {
            return try JSONDecoder().decode(ResultType.self, from: data)
        } catch {
            throw GatewayError.genericError  /* TODO: throw proper error here */
        }
        
    }
}
