//
//  Gateway.swift
//  Gateway
//
//  Created by Vato Kostava on 7/5/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public struct Request<ResultType: Codable> {
        
    public var request: URLRequest
    public var resultDecoder: some ParameterDecodable = JSONParameterDecoder<ResultType>()
    
    
    public init(
        method: Method,
        url: URL,
        body: Data? = nil,
        headers: [String:String] = [:],
        timeoutInterval: TimeInterval = 60,
        urlParams: [String:String] = [:]
    ) {
        do {
            try self.init(method, url: url, body: body, headers: headers, timeoutInterval: timeoutInterval, urlParams: urlParams)
        } catch {
            preconditionFailure("Request couldn't be instantiated")
        }
    }
    
    public init(
        _ method: Method,
        url: URL,
        body: Data? = nil,
        headers: [String:String] = [:],
        timeoutInterval: TimeInterval = 60,
        urlParams: [String:String] = [:]
    ) throws {
        request = URLRequest(url: url)
        do {
            try encodeParametersIfNeeded(urlParameters: urlParams, headers: headers)
        } catch {
            throw GatewayError.genericError /* TODO: throw proper error here */
        }
        
        request.timeoutInterval = timeoutInterval
        request.httpMethod = method.rawValue
        request.httpBody = body
    }
    
    private mutating func encodeParametersIfNeeded(
        urlParameters: Parameters = [:],
        headers: Parameters = [:],
        body: Parameters = [:]
    ) throws {
        if !body.isEmpty {
            do {
                request = try JSONParameterEncoder.encode(parameters: body, in: request)
            } catch {
                throw GatewayError.genericError /* TODO: throw proper error here */
            }
        }
        
        if !urlParameters.isEmpty {
            do {
                request = try URLParameterEncoder.encode(parameters: urlParameters, in: request)
            } catch {
                throw GatewayError.genericError /* TODO: throw proper error here */
            }
        }
        
        if !headers.isEmpty {
            request = HeaderParameterEncoder.encode(parameters: headers, in: request)
        }
    }
    
    public func fetch(completion: @escaping (Result<ResultType, GatewayError>) -> Void) {
        let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
            if let _ = error {
                completion(.failure(GatewayError.genericError)) /* TODO: throw proper error here */
                return
            }

            // TODO: Add checks for status code
            
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(ResultType.self, from: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(GatewayError.genericError)) /* TODO: throw proper error here */
                }
                return
            }
            
        }
        task.resume()
    }
}
