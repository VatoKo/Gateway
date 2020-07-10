//
//  ContentType.swift
//  Gateway
//
//  Created by Vato Kostava on 7/6/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation


/// HTTP Header
public enum ContentType: String {
    case json = "application/json"
    case xml = "application/xml"
    case urlEncoded = "application/x-www-form-urlencoded; charset=urt-8"
    case multipart = "multipart/form-data; boundary="
    
    public static var header: String {
        "Content-Type"
    }
}
