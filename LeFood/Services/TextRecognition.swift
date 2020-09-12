//
//  TextRecognition.swift
//  LeFood
//
//  Created by Kristo Kiis on 12.08.2020.
//  Copyright © 2020 BDCApps. All rights reserved.
//

import Foundation
import Vision

struct TextRecognition {
    static func recognizeText(from image: CGImage?, checkString: String, completion: @escaping (Bool) -> Void) {
        guard let image = image else {
            completion(false)
            return
        }
        var stringFound = false
        DispatchQueue.global(qos: .background).async {
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else { return }
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                let maximumRecognitionCandidates = 1
                for observation in observations {
                    guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                    if candidate.string.contains(checkString) {
                        stringFound = true
                    }
                }
            }
            recognizeTextRequest.recognitionLevel = .fast
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            try? requestHandler.perform([recognizeTextRequest])
            DispatchQueue.main.async {
                completion(stringFound)
            }
        }
    }
}
