//
//  Exception.swift
//  Gateway
//
//  Created by Vato Kostava on 7/9/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public enum GatewayException: Error {
    case genericException
    case urlNotFoundException
    case failedToEncodeException
}
