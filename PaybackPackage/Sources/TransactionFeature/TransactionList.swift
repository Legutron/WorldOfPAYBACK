//
//  TransactionList.swift
//
//
//  Created by Jakub Legut on 13/03/2024.
//

import ComposableArchitecture
import Common
import SwiftUI
import Theme

@Reducer
public struct TransactionList {
	@ObservableState
	public struct State: Equatable {
		let translations: TransactionList.Translations
		var transactions: IdentifiedArrayOf<TransactionModel>
		var transactionsFiltered: IdentifiedArrayOf<TransactionModel>
		
		let defaultCategory: Category
		var selectedCategory: Category
		
		var isLoading: Bool = false
		
		var sum: Double {
			// assuming it's the same currency
			transactionsFiltered
				.map(\.details.price.value)
				.reduce(0, +)
		}
		
		var sumLabel: String {
			"\(translations.sumLabel) \(sum) \(currency)"
		}
		
		var currency: String {
			transactionsFiltered.first?.details.price.currency ?? ""
		}
		
		var categories: [TransactionList.Category] {
			let categoryIDs = transactions.map { $0.category }
			var categories: [TransactionList.Category] = Array(Set(categoryIDs))
				.map {
					.init(id: $0, label: "Cat: \($0)")
				}
			categories.append(defaultCategory)
			categories.sort { $0.id < $1.id }
			return categories
		}
		
		var isDefaultCategory: Bool {
			selectedCategory == defaultCategory
		}
		
		public init(
			translations: TransactionList.Translations,
			transactions: IdentifiedArrayOf<TransactionModel>
		) {
			self.translations = translations
			self.transactions = transactions
			self.transactionsFiltered = transactions
			let defaultCategory = Category(
				id: 0,
				label: translations.defaultCategoryLabel
			)
			self.defaultCategory = defaultCategory
			self.selectedCategory = defaultCategory
		}
	}
	
	public enum Action {
		case view(ViewAction)
		case logic(LogicAction)
		case delegate(DelegateAction)
		
		@CasePathable
		public enum ViewAction {
			case onAppear
			case categoryChanged(Category)
		}
		
		public enum LogicAction {
			case filterByCategory
			case fetchTransaction
			case fetchTransactionResult(TaskResult<[TransactionModel]>)
		}
		
		public enum DelegateAction {
			case todo
		}
	}
	
	public init() {}
	
	@Dependency(\.transaction) var env
	
	public var body: some Reducer<State, Action> {
		Reduce { state, action in
			switch action {
			case let .view(action):
				switch action {
				case .onAppear:
					return .send(.logic(.fetchTransaction))
				case .categoryChanged(let category):
					state.selectedCategory = category
					return .send(.logic(.filterByCategory))
				}
				
			case let .logic(action):
				switch action {
				case .filterByCategory:
					if state.isDefaultCategory {
						state.transactionsFiltered = state.transactions
						return .none
					} else {
						state.transactionsFiltered = state.transactions.filter(
							{ $0.category == state.selectedCategory.id }
						)
						return .none
					}
				case .fetchTransaction:
					state.isLoading = true
					return .run { send in
						await send(.logic(.fetchTransactionResult(TaskResult {
							try await self.env.fetchTransaction()
						})))
					}
				case .fetchTransactionResult(.success(var transactions)):
					state.isLoading = false
					transactions.sort {
						($0.details.bookingDate ?? Date.distantPast) < ($1.details.bookingDate ?? Date.distantPast)
					}
					state.transactions = .init(uniqueElements: transactions)
					return .send(.logic(.filterByCategory))
				case .fetchTransactionResult(.failure(let error)):
					state.isLoading = false
					return .none
				}
				
			case .delegate:
				return .none
			}
		}
	}
	
}

public extension TransactionList {
	struct Category: Identifiable, Equatable, Hashable {
		public let id: Int
		let label: String
	}
	
	struct Translations: Equatable {
		let title: String
		let defaultCategoryLabel: String
		let sumLabel: String
		let selectedLabel: String
		
		public init(
			title: String,
			defaultCategoryLabel: String,
			sumLabel: String,
			selectedLabel: String
		) {
			self.title = title
			self.defaultCategoryLabel = defaultCategoryLabel
			self.sumLabel = sumLabel
			self.selectedLabel = selectedLabel
		}
	}
}

public struct TransactionListView: View {
	@Bindable var store: StoreOf<TransactionList>
	
	public init(store: StoreOf<TransactionList>) {
		self.store = store
	}
	
	public var body: some View {
		NavigationView {
			ScrollView {
				ForEach(store.transactionsFiltered) { transaction in
					NavigationLink(
						destination: {
							TransactionDetailView(transaction: transaction)
						},
						label: {
							TransactionListItemView(transaction: transaction)
						}
					)
				}
				HStack {
					Spacer()
					Text(store.sumLabel)
						.apply(style: .body1, color: Asset.textSecondary.swiftUIColor)
						.padding()
						.background(Asset.primary.swiftUIColor)
						.cornerRadius(ViewDimension.size12.size)
				}
				.horizontalPadding(.size24)
			}
			.onAppear {
				store.send(.view(.onAppear))
			}
			.backgroundFull(Asset.background.swiftUIColor)
			.navigationTitle(store.translations.title)
			.toolbar {
				Picker(
					"Category",
					selection: $store.selectedCategory.sending(\.view.categoryChanged)
				) {
					ForEach(store.categories, id: \.id) { item in
						Text(item.label)
							.apply(style: .body2, color: Asset.primary.swiftUIColor)
							.tag(item)
					}
				}
			}
		}
	}
	
	struct TransactionListItemView: View {
		
		let transaction: TransactionModel
		
		var price: String {
			String(format: "%.2f %@", transaction.details.price.value, transaction.details.price.currency)
		}
		
		var body: some View {
			HStack {
				VStack(alignment: .leading) {
					Text(transaction.details.bookingDate?.prettyDate ?? "Date missing")
						.apply(style: .body2, color: Asset.primary.swiftUIColor)
					Text(transaction.partnerName)
						.apply(style: .h2)
					if let description = transaction.details.description {
						Text(description)
							.apply(style: .normal)
					}
				}
				Spacer()
				Text(price)
					.apply(style: .body1, color: Asset.primary.swiftUIColor)
				
			}
			.padding(.size12)
			.background(Asset.surface.swiftUIColor)
			.cornerRadius(ViewDimension.size12.size)
			.horizontalPadding(.size12)
		}
	}
}

#if DEBUG
#Preview {
	NavigationView {
		TransactionListView(
			store: Store(
				initialState: .mock
			) {
				TransactionList()
			}
		)
	}
	.navigationViewStyle(.stack)
}
#endif

