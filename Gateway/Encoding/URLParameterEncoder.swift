//
//  URLParameterEncoder.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation


/// Encodes additional URL parameters into URLRequest
public struct URLParameterEncoder: ParameterEncodable {
    
    
    /// Encodes additional URL parameters into URLRequest
    /// - Parameters:
    ///   - parameters: URL parameters to encode
    ///   - request: URLRequest to encode into
    /// - Throws: URL not found exception
    /// - Returns: New URLRequest with encoded parameters
    public func encode(parameters: Parameters, in request: URLRequest) throws -> URLRequest {
        
        guard let url = request.url else { throw GatewayException.urlNotFoundException }
        
        var newRequest = request
        
        if !parameters.isEmpty {
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
                urlComponents.queryItems = parameters.map {
                    URLQueryItem(name: $0, value: "\($1)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                }
                newRequest.url = urlComponents.url
            }
        }
        
        if newRequest.value(forHTTPHeaderField: ContentType.header) == nil {
            newRequest.setValue(ContentType.urlEncoded.rawValue, forHTTPHeaderField: ContentType.header)
        }
        
        return newRequest
    }
    
}
