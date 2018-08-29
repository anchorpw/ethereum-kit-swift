import CryptoSwift
import BigInt

public struct EIP155Signer {
    
    private let chainID: Int
    
    public init(chainID: Int) {
        self.chainID = chainID
    }
    
    public func sign(_ rawTransaction: RawTransaction, privateKey: PrivateKey) throws -> Data {
        let transactionHash = try hash(rawTransaction: rawTransaction)
        let signiture = try privateKey.sign(hash: transactionHash)
        
        let (r, s, v) = calculateRSV(signature: signiture)
        return try RLP.encode([
            rawTransaction.nonce,
            rawTransaction.gasPrice,
            rawTransaction.gasLimit,
            rawTransaction.to.data,
            rawTransaction.value,
            rawTransaction.data,
            v, r, s
        ])
    }
    
    public func hash(rawTransaction: RawTransaction) throws -> Data {
        return Crypto.hashSHA3_256(try encode(rawTransaction: rawTransaction))
    }
    
    public func encode(rawTransaction: RawTransaction) throws -> Data {
        var toEncode: [Any] = [
            rawTransaction.nonce,
            rawTransaction.gasPrice,
            rawTransaction.gasLimit,
            rawTransaction.to.data,
            rawTransaction.value,
            rawTransaction.data]
        if chainID != 0 {
            toEncode.append(contentsOf: [chainID, 0, 0 ]) // EIP155
        }
        return try RLP.encode(toEncode)
    }

    @available(*, deprecated, renamed: "calculateRSV(signature:)")
    public func calculateRSV(signiture: Data) -> (r: BigInt, s: BigInt, v: BigInt) {
        return calculateRSV(signature: signiture)
    }

    public func calculateRSV(signature: Data) -> (r: BigInt, s: BigInt, v: BigInt) {
        return (
            r: BigInt(signature[..<32].toHexString(), radix: 16)!,
            s: BigInt(signature[32..<64].toHexString(), radix: 16)!,
            v: BigInt(signature[64]) + BigInt(chainID == 0 ? 27 : (35 + 2 * chainID))
        )
    }

    public func calculateSignature(r: BigInt, s: BigInt, v: BigInt) -> Data {
        let isOldSignitureScheme = [27, 28].contains(v)
        let suffix = isOldSignitureScheme ? v - 27 : v - BigInt(35) - BigInt(2) * BigInt(chainID)
        let sigHexStr = hex64Str(r) + hex64Str(s) + String(suffix, radix: 16)
        return Data(hex: sigHexStr)
    }

    private func hex64Str(_ i: BigInt) -> String {
        let hex = String(i, radix: 16)
        return String(repeating: "0", count: 64 - hex.count) + hex
    }
}
