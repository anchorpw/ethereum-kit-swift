import XCTest
@testable import EthereumKitSwift

class EthereumKitTests: XCTestCase {
    
    func testMenmonic1() {
        let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
        measure {
            let mnemonic = Mnemonic.create(entropy: entropy)
            XCTAssertEqual(
                mnemonic.joined(separator: " "),
                "abandon amount liar amount expire adjust cage candy arch gather drum buyer"
            )
        }
    }
    
    func testMenmonic2() {
        let entropy2 = Data(hex: "a26a4821e36c7f7dccaa5484c080cefa")
        
        measure {
            let mnemonic2 = Mnemonic.create(entropy: entropy2)
            XCTAssertEqual(
                mnemonic2.joined(separator: " "),
                "pen false anchor short side same crawl enhance luggage advice crisp village"
            )
        }
    }
    
    func testSeedGeneration1() {
        let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
        let mnemonic = Mnemonic.create(entropy: entropy)
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "3779b041fab425e9c0fd55846b2a03e9a388fb12784067bd8ebdb464c2574a05bcc7a8eb54d7b2a2c8420ff60f630722ea5132d28605dbc996c8ca7d7a8311c0"
        )
    }
    
    func testSeedGeneration2() {
        let entropy2 = Data(hex: "a26a4821e36c7f7dccaa5484c080cefa")
        let mnemonic2 = Mnemonic.create(entropy: entropy2)
        let seed2 = try! Mnemonic.createSeed(mnemonic: mnemonic2)
        XCTAssertEqual(
            seed2.toHexString(),
            "2bb2ea75d2891584559506b2429426722bfa81958c824affb84b37def230fe94a7da1701d550fef6a216176de786150d0a4f2b7b3770139582c1c01a6958d91a"
        )
    }
    
    func testChildKeyDerivation() {
        let entropy = Data(hex: "000102030405060708090a0b0c0d0e0f")
        let mnemonic = Mnemonic.create(entropy: entropy)
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        let privateKey = HDPrivateKey(seed: seed, network: .mainnet)
        
        // BIP44 key derivation
        // m/44'
        let purpose = try! privateKey.derived(at: 44, hardens: true)
        
        // m/44'/60'
        let coinType = try! purpose.derived(at: 60, hardens: true)
        
        // m/44'/60'/0'
        let account = try! coinType.derived(at: 0, hardens: true)
        
        // m/44'/60'/0'/0
        let change = try! account.derived(at: 0)
        
        // m/44'/60'/0'/0
        let firstPrivateKey = try! change.derived(at: 0)
        XCTAssertEqual(
            firstPrivateKey.hdPublicKey().publicKey().address(),
            "0x83f1caAdaBeEC2945b73087F803d404F054Cc2B7"
        )
        XCTAssertEqual(
            firstPrivateKey.raw.toHexString(),
            "df02cbea58239744a8a6ba328056309ae43f86fec6db45e5f782adcf38aacadf"
        )
    }
    
    func testBalance() {
        let firstBalanceHex = "0x0000000000000000000000000000000000000000000000000DE0B6B3A7640000" // 1ether = 1000000000000000000 wei
        let firstBalanceWei = Wei(firstBalanceHex.lowercased().stripHexPrefix(), radix: 16)!
        let firstBalance = Balance(wei: firstBalanceWei)
        XCTAssertEqual(firstBalance.wei, Wei("1000000000000000000", radix: 10))
        XCTAssertEqual(try! firstBalance.ether(), Ether(1))
        let secondBalanceHex = "0x0000000000000000000000000000000000000000000000056BC75E2D63100000" // 100ether = 100000000000000000000 wei
        let secondBalanceWei = Wei(secondBalanceHex.lowercased().stripHexPrefix(), radix: 16)!
        let secondBalance = Balance(wei: secondBalanceWei)
        XCTAssertEqual(secondBalance.wei, Wei("100000000000000000000", radix: 10))
        XCTAssertEqual(try! secondBalance.ether(), Ether(100))
    }
}
