//
//  CoreLogic.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Common
import ComposableArchitecture
import Foundation
import Network

// MARK: CoreLogic
public struct CoreLogic {
	public var fetchTransactions: @Sendable () async throws -> [TransactionAPI]
	public var checkConnection: @Sendable () async throws -> Void
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
		},
		checkConnection: {
			try await withCheckedThrowingContinuation { continuation in
				let monitor = NWPathMonitor()
				monitor.pathUpdateHandler = { path in
					if path.status == .satisfied {
						continuation.resume()
					} else {
						continuation.resume(throwing: PBError.noConnection("no internet connection"))
					}
					monitor.cancel()
				}
				let queue = DispatchQueue(label: "NetworkMonitor")
				monitor.start(queue: queue)
			}
		}
	)
	
	public static let testValue = Self(
		fetchTransactions: unimplemented("\(Self.self).fetchTransactions"),
		checkConnection: unimplemented("\(Self.self).checkConnection")
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

