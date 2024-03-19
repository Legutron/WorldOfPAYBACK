//
//  CoreLogic.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Common
import ComposableArchitecture
import Foundation

// MARK: CoreLogic
public struct CoreLogic {
	public var fetchTransactions: @Sendable () async throws -> [TransactionAPI]
}

extension CoreLogic: DependencyKey {
	public static let liveValue = Self(
		fetchTransactions: {
			if randomBool() {
				print("⛔️ RANDOM ERROR GENERATED")
				throw PBError.randomError("Random error :)")
			} else {
				if PaybackAssembler.shared.buildType == .debugWithMock {
					return try await fetchMockedTransactions()
				} else {
					return try await fetchApiTransactions()
				}
			}
		}
	)
	
	public static let testValue = Self(
		fetchTransactions: unimplemented("\(Self.self).fetchTransactions")
	)
}

fileprivate func randomBool() -> Bool {
	return arc4random_uniform(2) == 0
}

fileprivate func fetchMockedTransactions() async throws -> [TransactionAPI] {
	let file = "PBTransactions"
	if let url = Bundle.module.url(forResource: file, withExtension: "json") {
		do {
			let data = try Data(contentsOf: url)
			let jsonData = try PaybackAssembler.shared.decoder.decode(
				TransactionListAPI.self,
				from: data
			)
			return jsonData.items
		} catch {
			print("error:\(error)")
		}
	}
	return []
}

fileprivate func fetchApiTransactions() async throws -> [TransactionAPI] {
	let data = try await Api().fetchTransactions()
	let decodedData = try PaybackAssembler.shared.decoder.decode(TransactionListAPI.self, from: data)
	return decodedData.items
}

