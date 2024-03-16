//
//  Array+unique.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Foundation

public extension Array where Element: Equatable {
	var unique: [Element] {
		var uniqueValues: [Element] = []
		forEach { item in
			guard !uniqueValues.contains(item) else { return }
			uniqueValues.append(item)
		}
		return uniqueValues
	}
}
