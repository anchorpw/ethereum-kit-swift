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
    
    struct KeystoreRow {
        var file: String
        var key: String
        var address: String
        var password: String
    }
    
    var keystores: [KeystoreRow] = [
        KeystoreRow(
            file: "keystore1",
            key: "7f8863b4261d35ba18d69a4b643f2edafbb16bf7dfdc7923895e7b773815a510",
            address: "0xbF3e861a5C643ED28226Ed789ce50804E901Bd5A",
            password: "testtesttest"
        ),
        KeystoreRow(
            file: "keystore2",
            key: "89e793748bc097b8f9a208da1658c599a2044f2154acd3c8f4e646bfe7803557",
            address: "0x6eCfFaD8f44Cd333136c464482B2134Ab7617318",
            password: "testtesttest1"
        ),
        KeystoreRow(
            file: "pbkdf2",
            key: "7a28b5ba57c53603b0b07b56bba752f7784bf506fa95edc395f5cf6c7514fe9d",
            address: "0x008AeEda4D805471dF9b2A5B0f38A0C3bCBA786b",
            password: "testpassword"
        )
    ]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testObtainFromJSONKeystore() {
        let keystoreRow = keystores[0]
        let bundle = Bundle(for: KeystoreTests.self)
        let url = bundle.url(forResource: keystoreRow.file, withExtension: "json")!
        do {
            let keystore = try Keystore.keystore(url: url)
            let privateKey = try keystore.privateKey(passphrase: keystoreRow.password) // -> PrivateKey
            XCTAssertEqual(privateKey.raw, Data(hex: keystoreRow.key))
            XCTAssertEqual(privateKey.publicKey.address(), keystoreRow.address)
        } catch {
            print(error)
            XCTFail()
        }
    }
    
    func testObtainFromPBKDF2JSONKeystore() {
        let keystoreRow = keystores[2]
        let bundle = Bundle(for: KeystoreTests.self)
        let url = bundle.url(forResource: keystoreRow.file, withExtension: "json")!
        do {
            let keystore = try Keystore.keystore(url: url)
            let privateKey = try keystore.privateKey(passphrase: keystoreRow.password) // -> PrivateKey
            XCTAssertEqual(privateKey.raw, Data(hex: keystoreRow.key))
            XCTAssertEqual(privateKey.publicKey.address(), keystoreRow.address)
        } catch {
            print(error)
            XCTFail()
        }
    }
    
    func testObtainFromPrivateKey() {
        let keystoreRow = keystores[0]
        let privateKey = Data(hex: keystoreRow.key)
        do {
            let keystore = try Keystore(privateKey: privateKey, passphrase: "qwerty")
            let key = try keystore.privateKey(passphrase: "qwerty")
            XCTAssertEqual(privateKey, key.raw)
            XCTAssertEqual(keystoreRow.address, keystore.address!)
        } catch {
            print(error)
            XCTFail()
        }
    }
    
    func testGenerateKeystore() {
        do {
            let keystore = try Keystore.create(passphrase: "qwerty")
            let privateKey = try keystore.privateKey(passphrase: "qwerty")
            
            let data = try keystore.raw()
            let keystore1 = try Keystore.keystore(rawData: data)
            let privateKey1 = try keystore1.privateKey(
                passphrase: "qwerty")
            
            XCTAssertEqual(privateKey.raw, privateKey1.raw)
            XCTAssertEqual(privateKey.publicKey.address(), privateKey1.publicKey.address())
        } catch {
            print(error)
            XCTFail()
        }
    }
    
}
