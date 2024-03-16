//
//  FontStyle.swift
//  
//
//  Created by Jakub Legut on 15/03/2024.
//

import SwiftUI

public enum FontStyle: CaseIterable {
	case h1
	case h2
	case body1
	case body2
	case normal
	case caption
}

extension FontStyle {
	public var font: Font {
		switch self {
		case .h1:
			return Font.system(
				size: 24,
				weight: .bold
			)
		case .h2:
			return Font.system(
				size: 20,
				weight: .bold
			)
		case .body1:
			return Font.system(
				size: 20,
				weight: .semibold
			)
		case .body2:
			return Font.system(
				size: 12,
				weight: .semibold
			)
		case .normal:
			return Font.system(
				size: 12,
				weight: .regular
			)
		case .caption:
			return Font.system(
				size: 8,
				weight: .regular
			)
		}
	}
}
