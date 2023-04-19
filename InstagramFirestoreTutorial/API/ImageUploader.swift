//
//  ImageUploader.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-18.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        //Make upload data for the image and get JpegData compressed to make it smaller
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData) { metadata, error in
            if let error = error {
                print("DEBUG:  Failed to upload image", error.localizedDescription)
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
}
