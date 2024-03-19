//
//  View+Padding.swift
//
//
//  Created by Jakub Legut on 14/03/2024.
//

import SwiftUI

public extension View {
	func padding(_ dimension: ViewDimension) -> some View {
		self.padding(dimension.size)
	}
	
	func verticalPadding(_ dimension: ViewDimension) -> some View {
		self.padding(dimension.verticalPadding())
	}
	
	func horizontalPadding(_ dimension: ViewDimension) -> some View {
		self.padding(dimension.horizontalPadding())
	}
}

