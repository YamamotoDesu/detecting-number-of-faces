# detecting-number-of-faces

<img width="300" alt="スクリーンショット 2022-12-30 16 06 50" src="https://user-images.githubusercontent.com/47273077/210043909-9e184996-869b-4314-80da-ad27beb0dbbb.gif">


```swift
    private func detectFaces(completion: @escaping ([VNFaceObservation]?) -> Void) {
        
        guard let image = UIImage(named: photos[currentIndex]),
              let cgImage = image.cgImage,
              let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)) else {
            return completion(nil)
        }
        
        let request = VNDetectFaceLandmarksRequest()
        
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation, options: [:])
        
        DispatchQueue.global().async {
            
            try? handler.perform([request])
            
            guard let obervations = request.results else {
                return completion(nil)
            }
            
            completion(obervations)
        }
    }
    
 ```
