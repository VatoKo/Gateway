//
//  Error.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public enum GatewayError: Error {
    case genericError
}

/**
 *  Error messages are provided from this link.
 *  Link: https://www.restapitutorial.com/httpstatuscodes.html#
 */

public struct RedirectionError: Error {
    public let statusCode: Int
    public var localizedDescription = "The client must take additional action to complete the request."
}

public struct ClientError: Error {
    public let statusCode: Int
    public var localizedDescription = "The client seems to have erred"
}

public struct ServerError: Error {
    public let statusCode: Int
    public var localizedDescription = "The server failed to fulfill an apparently valid request."
}

public struct ConnectionError: Error {
    public var localizedDescription: String
}

public struct GenericError: Error {
    public var localizedDescription = "Something bad happened"
}

public struct FailedDecodingResultError: Error {
    public var localizedDescription = "Failed to decode the response data. "
}

public struct NoDataInResponseError: Error {
    public var localizedDescription = "No data was provided in response"
}
