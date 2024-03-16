//
//  View+Background.swift
//
//
//  Created by Jakub Legut on 15/03/2024.
//

import SwiftUI

public extension View {
	func backgroundFull(_ color: Color) -> some View {
		self.modifier(FullViewColorModifier(color: color))
	}
}

private struct FullViewColorModifier: ViewModifier {
	private let color: Color
	
	public init (
		color: Color
		
	) {
		self.color = color
	}
	
	public func body(content: Content) -> some View {
		ZStack {
			color
				.ignoresSafeArea()
			content
		}
	}
}
