//
//  Cipher+Extension.swift
//  EthereumKitSwift
//
//  Created by Dmitriy Karachentsov on 2/9/18.
//

import CryptoSwift

extension CryptoSwift.Cipher {
    
    func encrypt(input: Data) throws -> Data {
        let encryptedInput = try self.encrypt(input.bytes)
        return Data(bytes: encryptedInput)
    }
    
    func decrypt(input: Data) throws -> Data {
        let encryptedInput = try self.decrypt(input.bytes)
        return Data(bytes: encryptedInput)
    }
    
}

