//
//  File.swift
//  EthereumKitSwift
//
//  Created by Dmitriy Karachentsov on 2/9/18.
//

import Foundation

struct ScryptKdf: Codable {
    var dklen: Int
    var n: Int
    var r: Int
    var p: Int
    var salt: String
}

extension ScryptKdf {
    
    func scrypt(password: Data) throws -> Data {
        let scrypt = try Scrypt.scrypt(
            password: password,
            salt: Data(hex: salt),
            N: UInt64(n),
            r: UInt32(r),
            p: UInt32(p),
            dkLen: dklen)
        return scrypt
    }
    
}
