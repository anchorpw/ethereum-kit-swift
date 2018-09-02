//
//  Data+Extension.swift
//  EthereumKitSwift
//
//  Created by Dmitriy Karachentsov on 1/9/18.
//

import Foundation

extension Data {
    
    static func randomBytes(count: Int) -> Data {
        var bytes = [UInt8](repeating: 0, count: count)
        let _  = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        return Data(bytes: bytes)
    }
    
}
