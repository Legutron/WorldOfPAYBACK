//
//  File.swift
//  
//
//  Created by Jakub Legut on 13/03/2024.
//

import SwiftUI

public enum ViewDimension {
	case size4
	case size8
	case size10
	case size12
	case size16
	case size20
	case size24
	case size32
	case size40
	case size48
	case size56
	case size64
	
	public var size: CGFloat {
		switch self {
		case .size4:
			return 4
		case .size8:
			return 8
		case .size10:
			return 10
		case .size12:
			return 12
		case .size16:
			return 16
		case .size20:
			return 20
		case .size24:
			return 24
		case .size32:
			return 32
		case .size40:
			return 40
		case .size48:
			return 48
		case .size56:
			return 56
		case .size64:
			return 64
		}
	}
	
	public func verticalPadding() -> EdgeInsets {
		return EdgeInsets(
			top: self.size,
			leading: 0,
			bottom: self.size,
			trailing: 0
		)
	}
	
	public func horizontalPadding() -> EdgeInsets {
		return EdgeInsets(
			top: 0,
			leading: self.size,
			bottom: 0,
			trailing: self.size
		)
	}
}

public enum ViewCornerDimension {
	case small, normal, big
	
	var corner: CGFloat {
		switch self {
		case .small:
			return 8
		case .normal:
			return 12
		case .big:
			return 24
		}
	}
}
