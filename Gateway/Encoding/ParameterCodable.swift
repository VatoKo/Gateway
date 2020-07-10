//
//  ParameterCodable.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]


/// Protocol which declares parameters encoding method into URLRequest
public protocol ParameterEncodable {
    
    /// Encodes passed parameters into URLRequest
    /// - Parameters:
    ///   - parameters: Parameters to encode
    ///   - request: URLRequest to encode into
    func encode(parameters: Parameters, in request: URLRequest) throws -> URLRequest
}
