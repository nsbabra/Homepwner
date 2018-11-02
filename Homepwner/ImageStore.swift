//
//  ImageStore.swift
//  Homepwner
//
//  Created by Navneet Babra on 10/26/18.
//  Copyright © 2018 nsbabra. All rights reserved.
//

import UIKit

class ImageStore {

    let cache = NSCache<NSString,UIImage>()

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)

        let url = imageURL(forKey: key)

        if let data = UIImagePNGRepresentation(image) {
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }

    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }

        let url = imageURL(forKey: key)

        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }

        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }

    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)

        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing image from disk: \(error)")
        }
    }

    func imageURL(forKey key: String) -> URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!

        return documentDirectory.appendingPathComponent(key)
    }
}
