//
//  File.swift
//  
//
//  Created by Jakub Legut on 13/03/2024.
//

import SwiftUI
import Common
import ComposableArchitecture
import TransactionFeature
import Theme

public let liveApp = TransactionListView(
	store: Store(
		initialState: initialTransactionListView
	) {
		TransactionList()
			.signpost()
			._printChanges()
	}
)

let initialTransactionListView: TransactionList.State = .init(
	translations: .init(
		title: L10n.transactionListTitle,
		defaultCategoryLabel: L10n.transactionListDefaultCategory,
		sumLabel: L10n.transactionListSum,
		selectedLabel: L10n.transactionListSelectedLabel
	),
	transactions: .init(uniqueElements: [.mock1, .mock2, .mock3])
)
