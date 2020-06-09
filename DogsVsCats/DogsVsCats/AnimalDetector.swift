//
//  AnimalDetector.swift
//  DogsVsCats
//
//  Created by Amr Hesham on 6/9/20.
//  Copyright © 2020 Brian Advent. All rights reserved.
//

import UIKit
import Vision
class AnimalDetector{
    static func startAnimalDetection(_ imageView:UIImageView, completion:@escaping (_ classification:[String]) -> Void) {
        
        
        let imageOrientation = CGImagePropertyOrientation(imageView.image!.imageOrientation)
        
        let visionRequestHandler = VNImageRequestHandler(cgImage: imageView.image!.cgImage!, orientation: imageOrientation, options: [:])
        
        guard let catDogModel = try? VNCoreMLModel(for: CatDogClassifier().model)
            else{print("could not load the model");return;}
        
        let animalDetectionRequest = VNCoreMLRequest(model: catDogModel) { (request, error) in
            guard let observations = request.results else{print("no results");return}
            
            let classifcations = observations
                .flatMap({$0 as? VNClassificationObservation})
                .filter({$0.confidence > 0.9})
                .map({$0.identifier})
            
            completion(classifcations)
            
        }
        
        
        
        do {
            try visionRequestHandler.perform([animalDetectionRequest])
        } catch  {
            print(error.localizedDescription)
        }
    }
}


extension CGImagePropertyOrientation {
    init(_ orientation: UIImageOrientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}
