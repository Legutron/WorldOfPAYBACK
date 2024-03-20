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
		assets: .mock,
		transactions: .init(uniqueElements: [.mock1, .mock2, .mock3])
	)
}

public extension TransactionList.Translations {
	static let mock: Self = .init(
		title: "Transaction list",
		defaultCategoryLabel: "All",
		sumLabel: "Sum",
		selectedLabel: "selected",
		errorTitle: "The connection failed",
		errorDescription: "We were unable to download the transaction list, please try again by pressing the button below, if the download fails after several attempts, please contact our customer support.",
		errorButton: "Retry"
	)
}

public extension TransactionList.Assets {
	static let mock: Self = .init(icon: "exclamationmark.circle.fill")
}
#endif
