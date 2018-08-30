//
//  WordList.swift
//  CryptoSwift
//
//  Created by Dmitriy Karachentsov on 30/8/18.
//

import Foundation

public enum WordListError: LocalizedError {
    case noSuchFile(String)
    case incorrectFormat(String)
    case fileIsEmpty(String)
    
    public var errorDescription: String? {
        switch self {
        case .noSuchFile(let fileName):
            return "No such file \(fileName).json"
        case .incorrectFormat(let fileName):
            return "Incorrect format of file \(fileName).json"
        case .fileIsEmpty(let fileName):
            return "File is empty \(fileName).json"
        }
    }
}

public enum WordList: String {
    case chineseSimplified = "chinese_simplified"
    case chineseTraditional = "chinese_traditional"
    case english
    case french
    case italian
    case japanese
    case korean
    case spanish
}

extension WordList {
    
    public var words: [String] {
        guard let words = try? fileWords() else {
            fatalError("There is the problem with \(self.filename).json file")
        }
        return words
    }
    
    var filename: String {
        return self.rawValue.lowercased()
    }
    
    func fileWords() throws -> [String] {
        let words = try self.readWords(from: filename)
        guard words.count > 0 else {
            throw WordListError.fileIsEmpty(filename)
        }
        return words
    }
    
}

private class WordListClass { }

private extension WordList {
    
    func readWords(from fileName: String) throws -> [String] {
        let bundle = Bundle(for: WordListClass.self)
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw WordListError.noSuchFile(fileName)
        }
        guard let data = try? Data(contentsOf: url),
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
            let words = jsonObject as? [String] else {
                throw WordListError.incorrectFormat(fileName)
            }
        return words
    }
    
}
