//
//  PaybackApp.swift
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

public func setBuildType(_ type: BuildType) {
	PaybackAssembler.shared.setBuildType(type)
}

let initialTransactionListView: TransactionList.State = .init(
	translations: .init(
		title: L10n.transactionListTitle,
		defaultCategoryLabel: L10n.transactionListDefaultCategory,
		sumLabel: L10n.transactionListSum,
		selectedLabel: L10n.transactionListSelectedLabel,
		errorTitle: L10n.transactionConnectionErrorTitle,
		errorDescription: L10n.transactionConnectionErrorDescription,
		errorButton: L10n.transactionConnectionErrorButton
	),
	transactions: .init(uniqueElements: [])
)
