//
//  JSONParameterDecoder.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public func JSONResultDecoder<ResultType: Decodable>(data: Data?) -> ResultType? {
    guard let data = data else { return nil }
    
    return try? JSONDecoder().decode(ResultType.self, from: data)
}
