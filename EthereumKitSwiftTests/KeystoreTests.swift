//
//  KeystoreTests.swift
//  EthereumKitSwiftTests
//
//  Created by Dmitriy Karachentsov on 30/8/18.
//  Copyright © 2018 yuzushioh. All rights reserved.
//

import XCTest
@testable import EthereumKitSwift

class KeystoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testObtainFromJSONKeystore() {
        let url = URL(string: "")!
        let keystore = Keystore(url: url)
        let _ = keystore.privateKey(passphrase: "") // -> PrivateKey
        let _ = keystore.raw() // -> Data (json)
    }
    
    func testObtainFromPrivateKey() {
        let privateKey = "".data(using: .utf8)!
        let keystore = Keystore(privateKey: privateKey, passphrase: "qwerty")
        let _ = keystore.privateKey(passphrase: "") // -> PrivateKey
        let _ = keystore.raw() // -> Data (json)
    }
    
    func testGenerateKeystore() {
        let keystore = Keystore.create(passphrase: "qwerty")
        let _ = keystore.privateKey(passphrase: "") // -> Data
        let _ = keystore.raw() // -> Data (json)
    }
    
}
