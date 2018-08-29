import XCTest
@testable import EthereumKitSwift

final class SentTransactionTests: XCTestCase {
    
    func testSentTransaction() {
        let sentTransaction = SentTransaction(id: "100")
        XCTAssertEqual(sentTransaction.id, "100")
    }
}
