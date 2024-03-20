//
//  Transaction.swift
//
//
//  Created by Jakub Legut on 14/03/2024.
//

import Foundation

public struct TransactionModel: Equatable, Identifiable {
	public let id: String
	let partnerName: String
	let aliasReference: String
	let category: Int
	let details: TransactionDetail
	
	public init(
		id: String,
		partnerName: String,
		aliasReference: String,
		category: Int,
		details: TransactionDetail
	) {
		self.id = id
		self.partnerName = partnerName
		self.aliasReference = aliasReference
		self.category = category
		self.details = details
	}
}

public struct TransactionDetail: Equatable {
	let description: String?
	let bookingDate: Date?
	let price: PriceValue
	
	public init(
		description: String?,
		bookingDate: Date?,
		price: PriceValue
	) {
		self.description = description
		self.bookingDate = bookingDate
		self.price = price
	}
}

public struct PriceValue: Equatable {
	let value: Double
	let currency: String
	
	public init(
		value: Double,
		currency: String
	) {
		self.value = value
		self.currency = currency
	}
}

#if DEBUG
public extension TransactionModel {
	static let mock1: Self = .init(
		id: "1",
		partnerName: "REWE Group",
		aliasReference: "795357452000810",
		category: 1,
		details: .init(
			description: "Punkte sammeln",
			bookingDate: Date(timeIntervalSince1970: 1710919689),
			price: .init(
				value: 123,
				currency: "PBP"
			)
		)
	)
	
	static let mock2: Self = .init(
		id: "2",
		partnerName: "dm-dogerie markt",
		aliasReference: "098193809705561",
		category: 2,
		details: .init(
			description: nil,
			bookingDate: Date(timeIntervalSince1970: 1710819589),
			price: .init(
				value: 1024,
				currency: "PBP"
			)
		)
	)
	
	static let mock3: Self = .init(
		id: "3",
		partnerName: "OTTO Group",
		aliasReference: "094844835601044",
		category: 3,
		details: .init(
			description: "Punkte sammeln",
			bookingDate: Date(timeIntervalSince1970: 1710719389),
			price: .init(
				value: 24,
				currency: "PBP"
			)
		)
	)
}

public extension TransactionDetail {
	static let mock: Self = .init(
		description: "Punkte sammeln",
		bookingDate: Date(),
		price: .mock
	)
	
}

public extension PriceValue {
	static let mock: Self = .init(
		value: 124,
		currency: "PBP"
	)
}
#endif
