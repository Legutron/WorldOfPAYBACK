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
		let transactions: IdentifiedArrayOf<Transaction>
		var transactionsFiltered: IdentifiedArrayOf<Transaction>
		
		let defaultCategory: Category
		var selectedCategory: Category
		
		var sum: Int {
			// assuming it's the same currency
			let prices = transactionsFiltered.map { $0.details.price.value }
			return prices.reduce(0, +)
		}
		
		var currency: String {
			transactionsFiltered.first?.details.price.currency ?? ""
		}
		
		var categories: [Category] {
			let categoryIDs = transactions.map { $0.category }
			var categories: [Category] = Array(Set(categoryIDs))
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
			transactions: IdentifiedArrayOf<Transaction>
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
		case logic(logicAction)
		case delegate(DelegateAction)
		case categoryChanged(Category)
		
		public enum ViewAction {
			case onAppear
		}
		
		public enum logicAction {
			case filterByCategory
		}
		
		public enum DelegateAction {
			case todo
		}
	}
	
	public init() {}
	
	public var body: some Reducer<State, Action> {
		Reduce { state, action in
			switch action {
			case let .view(action):
				switch action {
				case .onAppear:
					return .none
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
				}
				
			case .delegate:
				return .none
			case .categoryChanged(let category):
				state.selectedCategory = category
				return .send(.logic(.filterByCategory))
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
				if !store.isDefaultCategory {
					Text("\(store.translations.selectedLabel) \(store.selectedCategory.label)")
				}
				ForEach(store.transactionsFiltered) { transaction in
					NavigationLink(
						destination: {
							Text("Transaction Detail will be added soon... :)")
						},
						label: {
							TransactionListItemView(transaction: transaction)
						}
					)
				}
				HStack {
					Spacer()
					Text("\(store.translations.sumLabel) \(store.sum) \(store.currency)")
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
					selection: $store.selectedCategory.sending(\.categoryChanged)
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
		
		let transaction: Transaction
		
		var body: some View {
			HStack {
				VStack(alignment: .leading) {
					Text(transaction.details.bookingDate.prettyDate)
						.apply(style: .normal)
					Text(transaction.partnerName)
						.apply(style: .h2)
					if let description = transaction.details.description {
						Text(transaction.details.description ?? "")
							.apply(style: .normal)
					}
				}
				Spacer()
				Text("\(transaction.details.price.value) \(transaction.details.price.currency)")
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

