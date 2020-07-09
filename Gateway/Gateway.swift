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
    
    public typealias BodyEncoder<BodyType> = (BodyType) -> Data
    public typealias ResultDecoder<ResultType> = (Data?) -> ResultType?
    
    public var resultDecoder: ResultDecoder<ResultType>
    
    
    public init(
        method: Method = .get,
        url: URL,
        urlParams: Parameters = [:],
        body: Data? = nil,
        headers: Parameters = [:],
        timeoutInterval: TimeInterval = 60,
        resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder
    ) {
        do {
            try self.init(
                method,
                url: url,
                urlParams: urlParams,
                body: body,
                headers: headers,
                timeoutInterval: timeoutInterval,
                resultDecoder: resultDecoder
            )
        } catch {
            preconditionFailure("Request couldn't be instantiated")
        }
    }
    
    public init(
        _ method: Method,
        url: URL,
        urlParams: Parameters = [:],
        body: Data? = nil,
        headers: Parameters = [:],
        timeoutInterval: TimeInterval = 60,
        resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder
    ) throws {
        self.resultDecoder = resultDecoder
        
        request = URLRequest(url: url)
        do {
            try encodeParametersIfNeeded(urlParameters: urlParams, headers: headers)
        } catch {
            throw GatewayException.failedToEncodeException
        }
        
        request.timeoutInterval = timeoutInterval
        request.httpMethod = method.rawValue
        request.httpBody = body
    }
    
    public init<BodyType: Encodable>(
        method: Method = .post,
        url: URL,
        urlParams: [String:String] = [:],
        body: BodyType,
        headers: [String:String] = [:],
        timeoutInterval: TimeInterval = 60,
        resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder,
        bodyEncoder: BodyEncoder<BodyType>
    ) {
        let encodedBody = bodyEncoder(body)
        self.init(
            method: method,
            url: url,
            urlParams: urlParams,
            body: encodedBody,
            headers: headers,
            timeoutInterval: timeoutInterval,
            resultDecoder: resultDecoder
        )
    }
    
    public init(request: URLRequest, resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder) {
        self.request = request
        self.resultDecoder = resultDecoder
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
                throw GatewayException.failedToEncodeException
            }
        }
        
        if !urlParameters.isEmpty {
            do {
                request = try URLParameterEncoder.encode(parameters: urlParameters, in: request)
            } catch {
                throw GatewayException.failedToEncodeException
            }
        }
        
        if !headers.isEmpty {
            request = HeaderParameterEncoder.encode(parameters: headers, in: request)
        }
    }
    
    public func fetch(completion: @escaping (Result<ResultType, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: self.request) { data, response, error in
            if let error = error {
                completion(.failure(ConnectionError(localizedDescription: error.localizedDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(GenericError()))
                return
            }
            
            self.handleResponse(response: response, data: data, completion: completion)
        }
        task.resume()
    }
    
    public func cancel() {
        // TODO: calcel task
    }
    
    private func handleResponse(response: HTTPURLResponse,
                                data: Data?,
                                completion: @escaping (Result<ResultType, Error>) -> Void) {
        switch response.statusCode {
        case 200..<300:
            handleSuccessfulResponse(data: data, completion: completion)
        case 300..<400:
            completion(.failure(RedirectionError(statusCode: response.statusCode)))
        case 400..<500:
            completion(.failure(ClientError(statusCode: response.statusCode)))
        case 500..<600:
            completion(.failure(ServerError(statusCode: response.statusCode)))
        default:
            completion(.failure(GenericError()))
        }
    }
    
    private func handleSuccessfulResponse(data: Data?, completion: @escaping (Result<ResultType, Error>) -> Void) {
        guard let data = data else {
            completion(.failure(NoDataInResponseError()))
            return
        }
        
        if let decodedData = self.resultDecoder(data) {
            completion(.success(decodedData))
        } else {
            completion(.failure(FailedDecodingResultError()))
        }
        
    }
}
