//
//  TransactionErrorView.swift
//
//
//  Created by Jakub Legut on 19/03/2024.
//

import SwiftUI
import Theme
import Common

public struct TransactionErrorView: View {
	
	let title: String
	let description: String
	let buttonLabel: String
	var action: () -> Void
	
	public init(
		title: String,
		description: String,
		buttonLabel: String,
		action: @escaping () -> Void
	){
		self.title = title
		self.description = description
		self.buttonLabel = buttonLabel
		self.action = action
	}
	
	public var body: some View {
		VStack {
			Text(title)
				.apply(style: .h1, color: Asset.textWarning.swiftUIColor)
			
			Text(description)
				.apply(style: .normal)
				.multilineTextAlignment(.center)
				.verticalPadding(.size12)
			
			Button(
				action: action,
				label: {
					HStack {
						Text(buttonLabel)
							.apply(style: .body1, color: Asset.textSecondary.swiftUIColor)
					}
					.verticalPadding(.size8)
					.horizontalPadding(.size12)
					.background(Asset.primary.swiftUIColor)
					.cornerRadius(ViewDimension.size12.size)
				}
			)
		}
		.padding()
		.background(Asset.surface.swiftUIColor)
		.cornerRadius(ViewDimension.size16.size)
		.verticalPadding(.size32)
		.horizontalPadding(.size16)
	}
}

#if DEBUG
#Preview {
	NavigationView {
		TransactionErrorView(
			title: "The connection failed",
			description: "We were unable to download the transaction list, please try again by pressing the button below, if the download fails after several attempts, please contact our customer support.",
			buttonLabel: "Retry",
			action: {
				print("Retry tapped")
			}
		)
	}
	.navigationViewStyle(.stack)
}
#endif
