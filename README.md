
EthereumKitSwift is a framework that enables you to create Ethereum wallet and use it in your app.

```swift
// BIP39: Generate seed and mnemonic sentence.

let mnemonic = Mnemonic.create()
let seed = Mnemonic.createSeed(mnemonic: mnemonic)

// BIP32: Key derivation and address generation

let wallet = try! Wallet(seed: seed, network: .main)

// Send some ether

let rawTransaction = RawTransaction(
    ether: try! Converter.toWei(ether: "0.00001"), 
    to: address, 
    gasPrice: Converter.toWei(GWei: 10), 
    gasLimit: 21000, 
    nonce: 0
)

let tx = try! wallet.signTransaction(rawTransaction)
print(tx)
```

## Features
- Mnemonic recovery phrease in [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki)
- [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)/[BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki) HD wallet
- [EIP55](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-55.md) format address encoding
- [EIP155](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-155.md) replay attack protection
- Sign transaction
- ERC20 token transfer
- [Keystore v3](https://github.com/ethereum/wiki/wiki/Web3-Secret-Storage-Definition) with PBKDF2-SHA-256 and Scrypt DK functions 

## Documentations

- [Getting Started](Documentation/GettingStarted.md)
- [ERC20 Token](Documentation/ERC20.md)
<!-- - [Keystore v3](Documentation/Keystorev3.md) -->
<!-- - [JSONRPC API](Documentation/JSONRPC.md) -->
<!-- - [Etherscan API](Documentation/Etherscan.md) -->

## Requirements

- Swift 4.1 or later
- iOS 10.0 or later

## Installation

#### [CocoaPods](https://github.com/CocoaPods/CocoaPods)

```ruby
pod 'EthereumKitSwift', git: 'git@github.com:anchorpw/ethereum-kit-swift.git', branch: 'master'
```
- Insert to your Podfile.
- Run `pod install`.

## Dependency

- [CryptoEthereumSwift](https://github.com/yuzushioh/CryptoEthereumSwift): Ethereum cryptography implementations for iOS framework
- [BigInt](https://github.com/attaswift/BigInt): Arbitrary-precision arithmetic in pure Swift
- [libscrypt](https://github.com/technion/libscrypt): A shared library that implements scrypt() functionality

## Author

- Ryo Fukuda, [@yuzushioh](https://twitter.com/yuzushioh), yuzushioh@gmail.com
- DK, d.karachentsov@gmail.com

## License
EthereumKit is released under the [Apache License 2.0](LICENSE.md).
