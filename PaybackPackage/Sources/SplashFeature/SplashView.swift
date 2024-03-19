//
//  SplashView.swift
//
//
//  Created by Jakub Legut on 13/03/2024.
//

import ComposableArchitecture
import Common
import SwiftUI
import Theme

@Reducer
public struct Splash {
	@ObservableState
	public struct State: Equatable {
		let translations: Splash.Translations
		let assets: Splash.Assets
		
		var isNetworErrorVisible: Bool = false
		
		public init(
			translations: Splash.Translations,
			assets: Splash.Assets
		) {
			self.translations = translations
			self.assets = assets
		}
	}
	
	public enum Action {
		case view(ViewAction)
		case logic(LogicAction)
		case delegate(DelegateAction)
		
		public enum ViewAction {
			case onAppear
			case errorRetryTapped
		}
		
		public enum LogicAction {
			case checkConnection
			case checkConnectionResult(TaskResult<Void>)
		}
		
		public enum DelegateAction {
			case navigateToHome
		}
	}
	
	public init() {}
	
	@Dependency(\.splash) var env
	
	public var body: some Reducer<State, Action> {
		Reduce { state, action in
			switch action {
			case let .view(action):
				switch action {
				case .onAppear:
					return .send(.logic(.checkConnection))
				case .errorRetryTapped:
					state.isNetworErrorVisible = false
					return .send(.logic(.checkConnection))
				}
				
			case let .logic(action):
				switch action {
				case .checkConnection:
					return .run { send in
						await send(.logic(.checkConnectionResult(TaskResult {
							try await self.env.checkConnection()
						})))
					}
				case .checkConnectionResult(.success):
					return .send(.delegate(.navigateToHome))
				case .checkConnectionResult(.failure):
					state.isNetworErrorVisible = true
					return .none
				}
				
			case .delegate:
				return .none
			}
		}
	}
	
}

public extension Splash {
	struct Translations: Equatable {
		let errorTitle: String
		let errorDescription: String
		let errorButton: String
		
		public init(
			errorTitle: String,
			errorDescription: String,
			errorButton: String
		) {
			self.errorTitle = errorTitle
			self.errorDescription = errorDescription
			self.errorButton = errorButton
		}
	}
	
	struct Assets: Equatable {
		let icon: String
		
		public init(icon: String) {
			self.icon = icon
		}
	}
}

public struct SplashView: View {
	@Bindable var store: StoreOf<Splash>
	
	public init(store: StoreOf<Splash>) {
		self.store = store
	}
	
	public var body: some View {
		VStack {
			Spacer()
			if store.isNetworErrorVisible {
				VStack {
					ErrorView(
						icon: store.assets.icon,
						title: store.translations.errorTitle,
						description: store.translations.errorDescription,
						buttonLabel: store.translations.errorButton,
						action: {
							store.send(.view(.errorRetryTapped))
						}
					)
				}
			} else {
				ProgressView()
					.tint(Asset.primary.swiftUIColor)
			}
			Spacer()
		}
		.backgroundFull(Asset.background.swiftUIColor)
		.onAppear {
			store.send(.view(.onAppear))
		}
	}
}

#if DEBUG
#Preview {
	NavigationView {
		SplashView(
			store: Store(
				initialState: .mock
			) {
				Splash()
			}
		)
	}
	.navigationViewStyle(.stack)
}
#endif

