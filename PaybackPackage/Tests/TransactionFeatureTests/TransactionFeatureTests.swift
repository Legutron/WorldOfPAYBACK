import XCTest
import ComposableArchitecture
@testable import TransactionFeature

final class PaybackPackageTests: XCTestCase {
	
	@MainActor
	func testTransactionFetchingSuccess() async {
		let transactions: [TransactionModel] = [.mock1, .mock2, .mock3]
		let clock = TestClock()
		let store = TestStore(
			initialState: TransactionList.State.init(
				translations: .mock,
				assets: .mock,
				transactions: .init(uniqueElements: [])
			)
		) {
			TransactionList()
		} withDependencies: {
			$0.continuousClock = ImmediateClock()
			$0.transaction = .init(
				fetchTransaction: { transactions }
			)
		}
		
		await store.send(.view(.onAppear)) {
			$0.isAppeared = true
		}
		await store.receive(\.logic.fetchTransaction) {
			$0.isLoading = true
		}
		
		await clock.advance(by: .seconds(2))
		
		await store.receive(\.logic.fetchTransactionResult.success) {
			$0.isLoading = false
			$0.transactions = .init(uniqueElements: transactions)
		}
		
		await store.receive(\.logic.filterByCategory) {
			$0.transactionsFiltered = $0.transactions
		}
	}
	
	@MainActor
	func testTransactionFetchingFailure() async {
		enum PBError: Error {
			case randomError(String)
		}
		let error: PBError = .randomError("Random error")
		let clock = TestClock()
		let store = TestStore(
			initialState: TransactionList.State.init(
				translations: .mock,
				assets: .mock,
				transactions: .init(uniqueElements: [])
			)
		) {
			TransactionList()
		} withDependencies: {
			$0.continuousClock = ImmediateClock()
			$0.transaction = .init(
				fetchTransaction: { throw error }
			)
		}
		
		await store.send(.view(.onAppear)) {
			$0.isAppeared = true
		}
		await store.receive(\.logic.fetchTransaction) {
			$0.isLoading = true
		}
		
		await clock.advance(by: .seconds(2))
		
		await store.receive(\.logic.fetchTransactionResult.failure) {
			$0.isLoading = false
			$0.isErrorActive = true
		}
	}
	
	@MainActor
	func testSecondAppear() async {
		let clock = TestClock()
		let store = TestStore(
			initialState: TransactionList.State.init(
				translations: .mock,
				assets: .mock,
				transactions: .init(uniqueElements: []),
				isAppeared: true
			)
		) {
			TransactionList()
		} withDependencies: {
			$0.continuousClock = ImmediateClock()
		}
		await store.send(.view(.onAppear))
	}
	
	@MainActor
	func testRefreshList() async {
		let transactions1: [TransactionModel] = [.mock1, .mock2]
		let transactions2: [TransactionModel] = [.mock1, .mock2, .mock3]
		let clock = TestClock()
		let store = TestStore(
			initialState: TransactionList.State.init(
				translations: .mock,
				assets: .mock,
				transactions: .init(uniqueElements: transactions1),
				isAppeared: true
			)
		) {
			TransactionList()
		} withDependencies: {
			$0.continuousClock = ImmediateClock()
			$0.transaction = .init(
				fetchTransaction: { transactions2 }
			)
		}
		
		await store.send(.view(.onAppear))
		
		await store.send(.view(.refreshTapped))
		
		await store.receive(\.logic.fetchTransaction) {
			$0.isLoading = true
		}
		
		await clock.advance(by: .seconds(2))
		
		await store.receive(\.logic.fetchTransactionResult.success) {
			$0.isLoading = false
			$0.transactions = .init(uniqueElements: transactions2)
		}
		
		await store.receive(\.logic.filterByCategory) {
			$0.transactionsFiltered = $0.transactions
		}
	}
	
	@MainActor
	func testCategorySelection() async {
		let transactions: [TransactionModel] = [.mock1, .mock2, .mock3]
		let category: TransactionList.Category = .init(
			id: 2,
			label: "Cat: 2"
		)
		let clock = TestClock()
		let store = TestStore(
			initialState: TransactionList.State.init(
				translations: .mock,
				assets: .mock,
				transactions: .init(uniqueElements: transactions),
				isAppeared: true
			)
		) {
			TransactionList()
		} withDependencies: {
			$0.continuousClock = ImmediateClock()
		}
		
		await store.send(.view(.onAppear))
		
		await store.send(.view(.categoryChanged(category))) {
			$0.selectedCategory = category
		}
		
		await store.receive(\.logic.filterByCategory) {
			$0.transactionsFiltered = .init(uniqueElements: [.mock2])
		}
	}
	
	@MainActor
	func testFilterDate() async {
		let transactions: [TransactionModel] = [.mock2, .mock1, .mock3]
		let clock = TestClock()
		let store = TestStore(
			initialState: TransactionList.State.init(
				translations: .mock,
				assets: .mock,
				transactions: .init(uniqueElements: [])
			)
		) {
			TransactionList()
		} withDependencies: {
			$0.continuousClock = ImmediateClock()
			$0.transaction = .init(
				fetchTransaction: { transactions }
			)
		}
		
		await store.send(.view(.onAppear)) {
			$0.isAppeared = true
		}
		await store.receive(\.logic.fetchTransaction) {
			$0.isLoading = true
		}
		
		await clock.advance(by: .seconds(2))
		
		await store.receive(\.logic.fetchTransactionResult.success) {
			$0.isLoading = false
			$0.transactions = .init(uniqueElements: [.mock1, .mock2, .mock3])
		}
		
		await store.receive(\.logic.filterByCategory) {
			$0.transactionsFiltered = $0.transactions
		}
	}
}
