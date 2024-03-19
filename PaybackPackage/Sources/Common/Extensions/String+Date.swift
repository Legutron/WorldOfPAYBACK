//
//  String+Date.swift
//
//
//  Created by Jakub Legut on 17/03/2024.
//

import Foundation

public extension String {
	func toDate() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DateFormat.ISO8601.fullWithNoDecimals
		return dateFormatter.date(from: self)
	}
}
