// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
import EthereumKitSwift

public enum WordsListError: LocalizedError {
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

fileprivate func readWords(fromFileWithName fileName: String) throws -> [String] {
	guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
 		throw WordsListError.noSuchFile(fileName)
	}
	guard
		let data = try? Data(contentsOf: url),
		let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
		let words = jsonObject as? [String] else {
			throw WordsListError.incorrectFormat(fileName)
		}
	return words
}

public enum WordsList {
	case chineseSimplified
	case chineseTraditional
	case english
	case french
	case italian
	case japanese
	case korean
	case spanish

	public func words() throws -> [String] {
		switch self {
        case .chineseSimplified:
			return try readWords(fromFileWithName: ChineseSimplified.fileName)
        case .chineseTraditional:
			return try readWords(fromFileWithName: ChineseTraditional.fileName)
        case .english:
			return try readWords(fromFileWithName: English.fileName)
        case .french:
			return try readWords(fromFileWithName: French.fileName)
        case .italian:
			return try readWords(fromFileWithName: Italian.fileName)
        case .japanese:
			return try readWords(fromFileWithName: Japanese.fileName)
        case .korean:
			return try readWords(fromFileWithName: Korean.fileName)
        case .spanish:
			return try readWords(fromFileWithName: Spanish.fileName)
		}
	}
}
