//
//  CustomImageView.swift
//  Employee Directory Application
//

import UIKit
import Foundation

class CustomImageView: UIImageView {

    // MARK: - Constants

    let imageCache = NSCache<NSString, AnyObject>()

    // MARK: - Properties

    var imageURLString: String?

    func downloadImageFrom(_ urlString: String, _ imageMode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url,imageMode)
    }

    func downloadImageFrom(_ url: URL, _ imageMode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
                addSubview(activityIndicator)
                activityIndicator.startAnimating()
                activityIndicator.center = self.center
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                    activityIndicator.removeFromSuperview()
                }
            }.resume()
        }
    }
}
