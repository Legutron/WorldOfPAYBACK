//
//  TransactionAPI.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Foundation

// MARK: - TransactionAPI
public struct TransactionListAPI: Codable {
	public let items: [TransactionAPI]
}

public struct TransactionAPI: Codable {
	public let partnerDisplayName: String
	public let alias: AliasAPI
	public let category: Int
	public let transactionDetail: TransactionDetailAPI
}

// MARK: - AliasAPI
public struct AliasAPI: Codable {
	public let reference: String
}

// MARK: - TransactionDetailAPI
public struct TransactionDetailAPI: Codable {
	public let description: String?
	public let bookingDate: String
	public let value: PriceAPI
	
	public init(
		from decoder: Decoder
	) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.description = try? container.decodeIfPresent(String.self, forKey: .description)
		self.bookingDate = try container.decode(String.self, forKey: .bookingDate)
		self.value = try container.decode(PriceAPI.self, forKey: .value)
	}
}

// MARK: - PriceAPI
public struct PriceAPI: Codable {
	public let amount: Double
	public let currency: String
}
