// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
import EthereumKitSwift

fileprivate func readWords(fromFileWithName fileName: String) -> [String] {
	guard
		let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
		let data = try? Data(contentsOf: url),
		let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
		let words = jsonObject as? [String] else {
			return []
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

	public var words: [String] {
		switch self {
        case .chineseSimplified:
			return readWords(fromFileWithName: ChineseSimplified.fileName)
        case .chineseTraditional:
			return readWords(fromFileWithName: ChineseTraditional.fileName)
        case .english:
			return readWords(fromFileWithName: English.fileName)
        case .french:
			return readWords(fromFileWithName: French.fileName)
        case .italian:
			return readWords(fromFileWithName: Italian.fileName)
        case .japanese:
			return readWords(fromFileWithName: Japanese.fileName)
        case .korean:
			return readWords(fromFileWithName: Korean.fileName)
        case .spanish:
			return readWords(fromFileWithName: Spanish.fileName)
		}
	}
}
