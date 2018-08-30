//
//  ScryptTests.swift
//  EthereumKitSwiftTests
//
//  Created by Dmitriy Karachentsov on 29/8/18.
//  Copyright © 2018 yuzushioh. All rights reserved.
//

import XCTest
import CryptoSwift
import EthereumKitSwift
import libscrypt

class ScryptTests: XCTestCase {
    
    func testValidation1() {
        let password = "password".data(using: .utf8)!
        let salt = "NaCl".data(using: .utf8)!
        let data = try! Scrypt.scrypt(
            password: password,
            salt: salt,
            N: 1024,
            r: 8,
            p: 16,
            dkLen: 64)
        let hexString = data.toHexString()
        XCTAssertEqual(hexString, "fdbabe1c9d3472007856e7190d01e9fe7c6ad7cbc8237830e77376634b3731622eaf30d92e22a3886ff109279d9830dac727afb94a83ee6d8360cbdfa2cc0640")
    }
    
    func testValidation2() {
        let password = "pleaseletmein".data(using: .utf8)!
        let salt = "SodiumChloride".data(using: .utf8)!
        let data = try! Scrypt.scrypt(
            password: password,
            salt: salt,
            N: 16384,
            r: 8,
            p: 1,
            dkLen: 64)
        let hexString = data.toHexString()
        XCTAssertEqual(hexString, "7023bdcb3afd7348461c06cd81fd38ebfda8fbba904f8e3ea9b543f6545da1f2d5432955613f0fcf62d49705242a9af9e61e85dc0d651e40dfcf017b45575887")
    }
    
    func testValidation3() {
        let password = "pleaseletmein".data(using: .utf8)!
        let salt = "SodiumChloride".data(using: .utf8)!
        let data = try! Scrypt.scrypt(
            password: password,
            salt: salt,
            N: 1048576,
            r: 8,
            p: 1,
            dkLen: 64)
        let hexString = data.toHexString()
        XCTAssertEqual(hexString, "2101cb9b6a511aaeaddbbe09cf70f881ec568d574a2ffd4dabe5ee9820adaa478e56fd8f4ba5d09ffa1c6d927c40f4c337304049e8a952fbcbf45c6fa77a41a4")
    }
    
    func testCPUCostInvalidThrow() {
        let password = "pleaseletmein".data(using: .utf8)!
        let salt = "SodiumChloride".data(using: .utf8)!
        do {
            let _ = try Scrypt.scrypt(
                password: password,
                salt: salt,
                N: 1,
                r: 8,
                p: 1,
                dkLen: 64)
        }
        catch let e as Scrypt.Error {
            XCTAssertEqual(e, Scrypt.Error.cpuCostInvalid)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testCPUCostTooLargeThrow() {
        let password = "pleaseletmein".data(using: .utf8)!
        let salt = "SodiumChloride".data(using: .utf8)!
        do {
            let _ = try Scrypt.scrypt(
                password: password,
                salt: salt,
                N: 18014398509481984,
                r: 8,
                p: 1,
                dkLen: Int.max)
        }
        catch let e as Scrypt.Error {
            XCTAssertEqual(e, Scrypt.Error.cpuCostTooLarge)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testMemoryCostTooLargeThrow() {
        let password = "pleaseletmein".data(using: .utf8)!
        let salt = "SodiumChloride".data(using: .utf8)!
        do {
            let _ = try Scrypt.scrypt(
                password: password,
                salt: salt,
                N: 1048576,
                r: 33554432,
                p: 1,
                dkLen: Int.max)
        }
        catch let e as Scrypt.Error {
            XCTAssertEqual(e, Scrypt.Error.memoryCostTooLarge)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
    
    func testDesiredKeyTooLargeThrow() {
        let password = "pleaseletmein".data(using: .utf8)!
        let salt = "SodiumChloride".data(using: .utf8)!
        do {
            let _ = try Scrypt.scrypt(
                password: password,
                salt: salt,
                N: 1048576,
                r: 8,
                p: 1,
                dkLen: Int.max)
        }
        catch let e as Scrypt.Error {
            XCTAssertEqual(e, Scrypt.Error.desiredKeyTooLarge)
        }
        catch {
            XCTFail("Wrong error")
        }
    }
}
