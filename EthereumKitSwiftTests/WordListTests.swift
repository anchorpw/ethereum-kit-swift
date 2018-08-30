//
//  WordListTests.swift
//  EthereumKitSwiftTests
//
//  Created by Dmitriy Karachentsov on 30/8/18.
//  Copyright © 2018 yuzushioh. All rights reserved.
//

import XCTest
@testable import EthereumKitSwift

class WordListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChineseSimplifiedWords() {
        XCTAssertNoThrow(try WordList.chineseSimplified.fileWords())
        XCTAssertTrue(WordList.chineseSimplified.words.count > 0)
    }
    
    func testChineseTraditionalWords() {
        XCTAssertNoThrow(try WordList.chineseTraditional.fileWords())
        XCTAssertTrue(WordList.chineseTraditional.words.count > 0)
    }
    
    func testEnglishWords() {
        XCTAssertNoThrow(try WordList.english.fileWords())
        XCTAssertTrue(WordList.english.words.count > 0)
    }
    
    func testFrenchWords() {
        XCTAssertNoThrow(try WordList.french.fileWords())
        XCTAssertTrue(WordList.french.words.count > 0)
    }
    
    func testItalianWords() {
        XCTAssertNoThrow(try WordList.italian.fileWords())
        XCTAssertTrue(WordList.italian.words.count > 0)
    }
    
    func testJapaneseWords() {
        XCTAssertNoThrow(try WordList.japanese.fileWords())
        XCTAssertTrue(WordList.japanese.words.count > 0)
    }
    
    func testKoreanWords() {
        XCTAssertNoThrow(try WordList.korean.fileWords())
        XCTAssertTrue(WordList.korean.words.count > 0)
    }
    
    func testSpanishWords() {
        XCTAssertNoThrow(try WordList.spanish.fileWords())
        XCTAssertTrue(WordList.spanish.words.count > 0)
    }
    
}
