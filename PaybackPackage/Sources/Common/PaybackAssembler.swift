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
	
	private init(
		decoder: JSONDecoder,
		dateFormatter: DateFormatter
	) {
		self.decoder = decoder
		self.dateFormatter = dateFormatter
	}
	
	static let shared = PaybackAssembler(
		decoder: .init(),
		dateFormatter: .init()
	)
}
