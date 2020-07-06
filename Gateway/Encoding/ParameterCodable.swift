//
//  ParameterCodable.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]

public protocol ParameterEncodable {
    static func encode(parameters: Parameters, in request: URLRequest) throws -> URLRequest
}

public protocol ParameterDecodable {
    associatedtype ResultType: Decodable
    func decode(data: Data?, response: URLResponse?) throws -> ResultType
}
