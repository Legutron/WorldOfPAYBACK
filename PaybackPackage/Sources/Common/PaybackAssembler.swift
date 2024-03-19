//
//  PaybackAssembler.swift
//
//
//  Created by Jakub Legut on 15/03/2024.
//

import Foundation

public class PaybackAssembler {
	public let decoder: JSONDecoder
	public let dateFormatter: DateFormatter
	public var buildType: BuildType = .prod
	
	private init(
		decoder: JSONDecoder,
		dateFormatter: DateFormatter
	) {
		self.decoder = decoder
		self.dateFormatter = dateFormatter
	}
	
	public static let shared = PaybackAssembler(
		decoder: .init(),
		dateFormatter: .init()
	)
}

public extension PaybackAssembler {
	func setBuildType(_ type: BuildType) {
		print("BUILD TYPE \(type)")
		self.buildType = type
	}
}
