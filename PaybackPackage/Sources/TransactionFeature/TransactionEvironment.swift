//
//  TransactionEnvironment.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Common
import ComposableArchitecture

public struct TransactionEnvironment {
	var fetchTransaction: () async throws -> [TransactionModel]
	
	public init(
		fetchTransaction: @escaping () async throws -> [TransactionModel]
	) {
		self.fetchTransaction = fetchTransaction
	}
}

public extension TransactionEnvironment {
	static let unimplemented: Self = .init(
		fetchTransaction: XCTUnimplemented("fetchTransaction")
		
	)
}

public extension DependencyValues {
	var transaction: TransactionEnvironment {
		get { self[TransactionEnvironmentKey.self] }
		set { self[TransactionEnvironmentKey.self] = newValue }
	}

	enum TransactionEnvironmentKey: TestDependencyKey {
		public static var testValue: TransactionEnvironment = .unimplemented
	}
}
