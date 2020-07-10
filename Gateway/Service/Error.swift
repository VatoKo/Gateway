//
//  Error.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

/**
 *  Error messages are provided from this link.
 *  Link: https://www.restapitutorial.com/httpstatuscodes.html#
 */


/// Error when HTTP status code is in range: [300, 400)
public struct RedirectionError: Error {
    public let statusCode: Int
    public var localizedDescription = "The client must take additional action to complete the request."
}

/// Error when HTTP status code is in range: [400, 500)
public struct ClientError: Error {
    public let statusCode: Int
    public var localizedDescription = "The client seems to have erred"
}

/// Error when HTTP status code is in range: [500, 600)
public struct ServerError: Error {
    public let statusCode: Int
    public var localizedDescription = "The server failed to fulfill an apparently valid request."
}

/// Error when there's a connection error
public struct ConnectionError: Error {
    public var localizedDescription: String
}

/// Generic error during unknown errors
public struct GenericError: Error {
    public var localizedDescription = "Something bad happened"
}

/// Error during decoding received data
public struct FailedDecodingResultError: Error {
    public var localizedDescription = "Failed to decode the response data. "
}

/// Error when there's no data received
public struct NoDataInResponseError: Error {
    public var localizedDescription = "No data was provided in response"
}
