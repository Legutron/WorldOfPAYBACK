//
//  TransactionListMock.swift
//  
//
//  Created by Jakub Legut on 14/03/2024.
//

import Foundation

#if DEBUG
public extension TransactionList.State {
	static let mock: Self = .init(
		translations: .mock,
		transactions: .init(uniqueElements: [.mock1, .mock2, .mock3])
	)
}

public extension TransactionList.Translations {
	static let mock: Self = .init(
		title: "Transaction list",
		defaultCategoryLabel: "All",
		sumLabel: "Sum",
		selectedLabel: "selected"
	)
}
#endif
