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
    
    private var parameterEncoder: ParameterEncodable
    private var resultDecoder: ResultDecoder<ResultType>
    
    
    /// Initializes Request object
    /// - Parameters:
    ///   - method: HTTP method
    ///   - url: URL to make request to
    ///   - urlParams: Additional URL parameters
    ///   - body: HTTP body
    ///   - headers: HTTP headers
    ///   - timeoutInterval: Request timeout interval
    ///   - parameterEncoder: Body parameters encoder object
    ///   - resultDecoder: Function which decodes received response data into desired ResultType
    public init(
        method: Method = .get,
        url: URL,
        urlParams: Parameters = [:],
        body: Data? = nil,
        headers: Parameters = [:],
        timeoutInterval: TimeInterval = 60,
        parameterEncoder: ParameterEncodable = JSONParameterEncoder(),
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
                parameterEncoder: parameterEncoder,
                resultDecoder: resultDecoder
            )
        } catch {
            preconditionFailure("Request couldn't be instantiated")
        }
    }
    
    
    /// Initializes Request object with generic body
    /// - Parameters:
    ///   - method: HTTP method
    ///   - url: URL to make request to
    ///   - urlParams: Additional URL parameters
    ///   - body: Generic body that encapsulates HTTP body
    ///   - headers: HTTP headers
    ///   - timeoutInterval: Request timeout interval
    ///   - resultDecoder: Function which decodes received response data into desired ResultType
    ///   - bodyEncoder: Generic body encoder function
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
    
    
    /// Initializes Request object
    /// - Parameters:
    ///   - method: HTTP method
    ///   - url: URL to make request to
    ///   - urlParams: Additional URL parameters
    ///   - body: HTTP body parameters
    ///   - headers: HTTP headers
    ///   - timeoutInterval: Request timeout interval
    ///   - parameterEncoder: Body parameters encoder object
    ///   - resultDecoder: Function which decodes received response data into desired ResultType
    public init(
        method: Method = .post,
        url: URL,
        urlParams: Parameters = [:],
        body: Parameters,
        headers: Parameters = [:],
        timeoutInterval: TimeInterval = 60,
        parameterEncoder: ParameterEncodable = JSONParameterEncoder(),
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
                parameterEncoder: parameterEncoder,
                resultDecoder: resultDecoder
            )
        } catch {
            preconditionFailure("Request couldn't be instantiated")
        }
    }
    
    /// Initializes multipart POST request.
    /// - Parameters:
    ///   - url: URL
    ///   - urlParams: URL parameters
    ///   - name: Name
    ///   - fileName: File name
    ///   - data: Data to send
    ///   - mimeType: Data MIME type
    ///   - headers: HTTP Headers
    ///   - timeoutInterval: Request timeout
    ///   - parameterEncoder: Parameter encoder
    ///   - resultDecoder: Decoder
    public init(
        url: URL,
        urlParams: Parameters = [:],
        name: String,
        fileName: String,
        data: Data,
        mimeType: String,
        headers: Parameters = [:],
        timeoutInterval: TimeInterval = 60,
        parameterEncoder: ParameterEncodable = JSONParameterEncoder(),
        resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder
    ) {
        do {
            try self.init(
                url,
                urlParams: urlParams,
                name: name,
                fileName: fileName,
                data: data,
                mimeType: mimeType,
                headers: headers,
                timeoutInterval: timeoutInterval,
                parameterEncoder: parameterEncoder,
                resultDecoder: resultDecoder
            )
        } catch {
            preconditionFailure("Request couldn't be instantiated")
        }
    }
    
    
    /// Initializes Request object with custom URLRequest
    /// - Parameters:
    ///   - request: predefined URLRequest
    ///   - parameterEncoder: Body parameters encoder object
    ///   - resultDecoder: Function which decodes received response data into desired ResultType
    public init(request: URLRequest, parameterEncoder: ParameterEncodable = JSONParameterEncoder(), resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder) {
        self.request = request
        self.parameterEncoder = parameterEncoder
        self.resultDecoder = resultDecoder
    }
    
    /// Initializes Request object
    /// - Parameters:
    ///   - method: HTTP method
    ///   - url: URL to make request to
    ///   - urlParams: Additional URL parameters
    ///   - body: HTTP body
    ///   - headers: HTTP headers
    ///   - timeoutInterval: Request timeout interval
    ///   - parameterEncoder: Body parameters encoder object
    ///   - resultDecoder: Function which decodes received response data into desired ResultType
    private init(
           _ method: Method,
           url: URL,
           urlParams: Parameters = [:],
           body: Data? = nil,
           headers: Parameters = [:],
           timeoutInterval: TimeInterval = 60,
           parameterEncoder: ParameterEncodable = JSONParameterEncoder(),
           resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder
       ) throws {
           self.parameterEncoder = parameterEncoder
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
    
    /// Initializes multipart POST request.
    /// - Parameters:
    ///   - url: URL
    ///   - urlParams: URL parameters
    ///   - name: Name
    ///   - fileName: File name
    ///   - data: Data to send
    ///   - mimeType: Data MIME type
    ///   - headers: HTTP Headers
    ///   - timeoutInterval: Request timeout
    ///   - parameterEncoder: Parameter encoder
    ///   - resultDecoder: Decoder
    private init(
        _ url: URL,
        urlParams: Parameters = [:],
        name: String,
        fileName: String,
        data: Data,
        mimeType: String,
        headers: Parameters = [:],
        timeoutInterval: TimeInterval = 60,
        parameterEncoder: ParameterEncodable = JSONParameterEncoder(),
        resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder
    ) throws {
        self.resultDecoder = resultDecoder
        self.parameterEncoder = parameterEncoder
        
        let boundary = UUID().uuidString
        var multipartData = Data()
        
        multipartData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        multipartData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        multipartData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        multipartData.append(data)

        multipartData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request = URLRequest(url: url)
        do {
            try encodeParametersIfNeeded(urlParameters: urlParams, headers: headers)
        } catch {
            throw GatewayException.failedToEncodeException
        }
        
        request.setValue(ContentType.multipart.rawValue + boundary, forHTTPHeaderField: ContentType.header)
        request.timeoutInterval = timeoutInterval
        request.httpMethod = Method.post.rawValue
        request.httpBody = multipartData
    }
    
    /// Initializes Request object
    /// - Parameters:
    ///   - method: HTTP method
    ///   - url: URL to make request to
    ///   - urlParams: Additional URL parameters
    ///   - body: HTTP body parameters
    ///   - headers: HTTP headers
    ///   - timeoutInterval: Request timeout interval
    ///   - parameterEncoder: Body parameters encoder object
    ///   - resultDecoder: Function which decodes received response data into desired ResultType
    private init(
        _ method: Method = .post,
        url: URL,
        urlParams: Parameters = [:],
        body: Parameters,
        headers: Parameters = [:],
        timeoutInterval: TimeInterval = 60,
        parameterEncoder: ParameterEncodable = JSONParameterEncoder(),
        resultDecoder: @escaping ResultDecoder<ResultType> = JSONResultDecoder
    ) throws {
        self.resultDecoder = resultDecoder
        self.parameterEncoder = parameterEncoder
     
         request = URLRequest(url: url)
         do {
             try encodeParametersIfNeeded(urlParameters: urlParams, headers: headers, body: body)
         } catch {
             throw GatewayException.failedToEncodeException
         }
         
         request.timeoutInterval = timeoutInterval
         request.httpMethod = method.rawValue
    }
    
    
    /// Adds necessary parameters to URLRequest object
    /// - Parameters:
    ///   - urlParameters: Additional URL parameters
    ///   - headers: HTTP headers
    ///   - body: HTTP body parameters
    /// - Throws: Encoding failed exception
    private mutating func encodeParametersIfNeeded(
        urlParameters: Parameters = [:],
        headers: Parameters = [:],
        body: Parameters = [:]
    ) throws {
        if !body.isEmpty {
            do {
                request = try parameterEncoder.encode(parameters: body, in: request)
            } catch {
                throw GatewayException.failedToEncodeException
            }
        }
        
        if !urlParameters.isEmpty {
            do {
                request = try URLParameterEncoder().encode(parameters: urlParameters, in: request)
            } catch {
                throw GatewayException.failedToEncodeException
            }
        }
        
        if !headers.isEmpty {
            request = HeaderParameterEncoder().encode(parameters: headers, in: request)
        }
    }
    
    
    /// Sends HTTP request and parses received response data into passed ResultType
    /// - Parameter completion: Completion block which takes as a parameter Result which
    ///                         encapsulates succesfully decoded data or proper error
    public func send(completion: @escaping (Result<ResultType, Error>) -> Void) {
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
    
    
    /// Handles received response according to HTTP status code
    /// - Parameters:
    ///   - response: Recevied HTTPURLResponse
    ///   - data: Received data
    ///   - completion: Completion block which takes as a parameter Result which
    ///                 encapsulates succesfully decoded data or proper error
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
    
    
    /// Handles successful HTTP response
    /// - Parameters:
    ///   - data: Received data
    ///   - completion: Completion block which takes as a parameter Result which
    ///                 encapsulates succesfully decoded data or proper error
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
