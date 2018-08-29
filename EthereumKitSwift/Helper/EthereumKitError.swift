public enum EthereumKitError: Error {
    
    public enum CryptoError: Error {
        case failedToSign
        case failedToEncode(Any)
        case keyDerivateionFailed
        case invalidMnemonic
    }
    
    public enum ContractError: Error {
        case containsInvalidCharactor(Any)
        case invalidDecimalValue(Any)
    }
    
    public enum ConvertError: Error {
        case failedToConvert(Any)
    }
    
    case cryptoError(CryptoError)
    case contractError(ContractError)
    case convertError(ConvertError)
}
