//
//  WordList1.swift
//  CryptoSwift
//
//  Created by Dmitriy Karachentsov on 30/8/18.
//

import Foundation

public enum WordListError: LocalizedError {
    case noSuchFile(String)
    case incorrectFormat(String)
    
    public var errorDescription: String? {
        switch self {
        case .noSuchFile(let fileName):
            return "No such file \(fileName).json"
        case .incorrectFormat(let fileName):
            return "Incorrect format of file \(fileName).json"
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
    
    func words() -> [String] {
        let fileName = self.rawValue.lowercased()
        do {
            return try self.readWords(from: fileName)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}

private extension WordList {
    
    func readWords(from fileName: String) throws -> [String] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw WordListError.noSuchFile(fileName)
        }
        guard
            let data = try? Data(contentsOf: url),
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
            let words = jsonObject as? [String] else {
                throw WordListError.incorrectFormat(fileName)
        }
        return words
    }
    
}
