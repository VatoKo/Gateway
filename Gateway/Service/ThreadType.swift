//
//  ThreadType.swift
//  Gateway
//
//  Created by Vato Kostava on 7/10/20.
//  Copyright © 2020 Vato Kostava. All rights reserved.
//

import Foundation

public enum ThreadType {
    case main
    case background
    
    func async(execute code: @escaping () -> Void) {
        switch self {
        case .main:
            DispatchQueue.main.async {
                code()
            }
        case .background:
            DispatchQueue.global().async {
                code()
            }
        }
    }
}
