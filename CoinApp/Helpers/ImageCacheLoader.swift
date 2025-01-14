//
//  ImageCacheLoader.swift
//  CoinApp
//
//  Created by Angie Mugo on 10/01/2025.
//

//import UIKit
//import SwiftSVG
//
//class ImageCacheLoader {
//    private static let shared = ImageCacheLoader()
//    private var cache: NSCache<NSString, UIImage>
//    private var ongoingTasks: [URL: Task<UIImage?, Never>] = [:]
//       private let lock = NSLock()
//
//    private init() {
//        cache = NSCache()
//    }
//
//    static func requestImage(url: URL) async -> UIImage? {
//        if let image = requestImageFromCache(url: url) {
//            return image
//        } else {
//            do {
//                print("Requesting image from URL: \(url)")
//                let (data, _) = try await URLSession.shared.data(from: url)
//                print("Received data of size: \(data.count) bytes")
//
//                // Try to create an SVG image from the data
//                let svgImage = SVGView(svgURL: url)
//
//                if let image = svgImage {
//                    shared.cache.setObject(image, forKey: url.absoluteString as NSString)
//                    return image
//                } else {
//                    print("Failed to render SVG to image")
//                    return UIImage(systemName: "bitcoinsign")
//                }
//            } catch let error as URLError {
//                print("URL Error: \(error.localizedDescription)")
//                return UIImage(systemName: "bitcoinsign")
//            } catch {
//                print("General Error: \(error.localizedDescription)")
//                return UIImage(systemName: "bitcoinsign")
//            }
//        }
//    }
//
//    static func requestImageFromCache(url: URL) -> UIImage? {
//        return shared.cache.object(forKey: url.absoluteString as NSString)
//    }
//
//    static func clearCache() {
//        shared.cache.removeAllObjects()
//    }
//}
//
//class CoinImage: UIImageView {
//
//}
