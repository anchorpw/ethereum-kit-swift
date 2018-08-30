//
//  Keystore.swift
//  EthereumKitSwift
//
//  Created by Dmitriy Karachentsov on 30/8/18.
//

public final class Keystore {

    public var publicKey: PublicKey!
    
    private var crypto: KeystoreCrypto!
    
    init(url: URL) {
        
    }
    
    init(privateKey: Data, passphrase: String) {
        
    }
    
    class func create(network: Network = .mainnet, passphrase: String) -> Keystore {
        let mnemonic = Mnemonic.create()
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        let wallet = try! Wallet(seed: seed, network: network, debugPrints: true)
        let privateKey = wallet.privateKey()
        return Keystore(
            privateKey: privateKey,
            passphrase: passphrase)
    }
    
    func privateKey(passphrase: String) -> Data {
        return Data()
    }
    
    func raw() -> Data {
        return Data()
    }
    
    private static func crypto(fromPrivateKey privateKey: Data) -> KeystoreCrypto {
        return KeystoreCrypto()
    }
    
    private static func crypto(fromRaw raw: Data) -> KeystoreCrypto {
        return KeystoreCrypto()
    }
    
}

protocol Kdf {
    var params: [String: Any] { get }
}

protocol Cipher {
    var params: [String: Any] { get }
}

private final class ScryptKdf: Kdf {
    
    var salt: Data
    var n: Int
    var r: Int
    var p: Int
    var dkLen: Int
    
    var params: [String : Any] {
        return [:]
    }
    
    init(salt: Data, n: Int, r: Int, p: Int, dkLen: Int) {
        self.salt = salt
        self.n = n
        self.r = r
        self.p = p
        self.dkLen = dkLen
    }
    
}

private final class Aes128CtrCipher {
    
    var ciphertext: Data
    var cipherIv: Data
    
    var params: [String : Any] {
        return [:]
    }
    
    init(ciphertext: Data, cipherIv: Data) {
        self.ciphertext = ciphertext
        self.cipherIv = cipherIv
    }
}

private final class KeystoreCrypto {
    
    enum CipherType: String {
        case aes128ctr = "aes-128-ctr"
    }
    
    enum KdfType: String {
        case scrypt = "scrypt"
    }
    
    var cipherType: CipherType = .aes128ctr
    
    var kdfType: KdfType = .scrypt
    
}
