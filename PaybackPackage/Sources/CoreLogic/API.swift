//
//  API.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Foundation
import Common

enum BackendAPIs {
	static let prod = "https://api.payback.com/"
	static let stage = "https://api-test.payback.com/"
}

extension BackendAPIs {
	static var currentURL: String {
		if PaybackAssembler.shared.buildType == .prod {
			return BackendAPIs.prod
		} else {
			return BackendAPIs.stage
		}
	}
}

enum BackendKeys {
	static let transactions: String = "transactions"
}

public struct Api {
	public init () {}
}

public extension Api {
	func fetchTransactions() async throws -> Data {
		let url = URL(string: "\(BackendAPIs.currentURL)\(BackendKeys.transactions)")
		guard let url else {
			throw PBError.wrongURL("invalid url")
		}
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let (data, _) = try await URLSession.shared.data(for: request)
		print("🛜 \(String(describing: data.prettyPrintedJSONString))")
		return data
	}
}

extension Data {
	var prettyPrintedJSONString: NSString? {
		guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
			  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
			  let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
		return prettyPrintedString
	}
}
