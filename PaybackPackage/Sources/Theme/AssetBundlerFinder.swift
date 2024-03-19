//
//  AssetBundleFinder.swift
//
//
//  Created by Jakub Legut on 17/03/2024.
//

import Foundation

private class AssetBundleFinder {}

// this class is to find assets in the SPM files, it keeps preview working.
public class AssetResources: NSObject {
	static var swiftUIPreviewsCompatibleModule: Bundle {
		let bundleNameIOS = "PaybackPackage_Theme"
		
		let candidates = [
			Bundle(for: AssetBundleFinder.self)
				.resourceURL,
			Bundle(for: AssetBundleFinder.self)
				.resourceURL?
				.deletingLastPathComponent(),
			Bundle(for: AssetBundleFinder.self)
				.resourceURL?
				.deletingLastPathComponent()
				.deletingLastPathComponent(),
			Bundle(for: AssetBundleFinder.self)
				.resourceURL?
				.deletingLastPathComponent()
				.deletingLastPathComponent()
				.deletingLastPathComponent(),
		]
		
		for candidate in candidates {
			let bundlePathiOS = candidate?.appendingPathComponent(bundleNameIOS + ".bundle")
			if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
				return bundle
			}
		}
		fatalError("unable to find bundle")
	}
	
	public class var bundle: Bundle {
		#if DEBUG
		return swiftUIPreviewsCompatibleModule
		#else
		return Bundle.module
		#endif
	}
}

