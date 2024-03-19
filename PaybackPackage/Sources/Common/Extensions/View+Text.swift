//
//  View+Text.swift
//
//
//  Created by Jakub Legut on 15/03/2024.
//

import SwiftUI
import Theme

public extension Text {
	func apply(style: FontStyle, color: Color = Asset.textPrimary.swiftUIColor) -> some View {
		self.font(style.font)
			.modifier(ViewTextModifier(color: color))
	}
}

private struct ViewTextModifier: ViewModifier {
	private let color: Color
	
	public init (color: Color) {
		self.color = color
	}
	
	public func body(content: Content) -> some View {
		content
			.foregroundColor(color)
	}
}
