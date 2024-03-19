//
//  Environment.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Foundation
import Common
import ComposableArchitecture
import TransactionFeature
import Theme
import CoreLogic

let logic = CoreLogic.liveValue

extension DependencyValues.TransactionEnvironmentKey: DependencyKey {
	public static var liveValue: TransactionEnvironment = .live
}

extension TransactionEnvironment {
	static let live: Self = TransactionEnvironment(
		fetchTransaction: transformFetchTransaction
	)
}

fileprivate func transformFetchTransaction() async throws -> [TransactionModel] {
	do {
		return try await (logic.fetchTransactions()).map { model in
			transform(model: model)
		}
	} catch {
		print("⛔️ Error: \(error.localizedDescription)")
		throw error
	}
}

private func transform(model: TransactionAPI) -> TransactionModel {
	TransactionModel(
		id: UUID().uuidString,
		partnerName: model.partnerDisplayName,
		aliasReference: model.alias.reference,
		category: model.category,
		details: .init(
			description: model.transactionDetail.description,
			bookingDate: model.transactionDetail.bookingDate.toDate(),
			price: .init(
				value: model.transactionDetail.value.amount,
				currency: model.transactionDetail.value.currency
			)
		)
	)
}
