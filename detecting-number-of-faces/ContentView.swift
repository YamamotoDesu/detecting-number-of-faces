//
//  ContentView.swift
//  ImageClassificationSwiftUI
//
//  Created by Mohammad Azam on 2/3/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI
import Vision

struct ContentView: View {
    
    let photos = ["face","friends-sitting","people-sitting","ball","bird"]

    @State private var currentIndex: Int = 0
    @State private var classficationLabel: String = ""
    
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
    
    var body: some View {
        VStack {
            Image(photos[currentIndex])
            .resizable()
                .frame(width: 200, height: 200)
            HStack {
                Button("Previous") {
                    
                    if self.currentIndex >= self.photos.count {
                        self.currentIndex = self.currentIndex - 1
                    } else {
                        self.currentIndex = 0
                    }
                    
                    }.padding()
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .frame(width: 100)
                
                Button("Next") {
                    if self.currentIndex < self.photos.count - 1 {
                        self.currentIndex = self.currentIndex + 1
                    } else {
                        self.currentIndex = 0
                    }
                }
                .padding()
                .foregroundColor(Color.white)
                .frame(width: 100)
                .background(Color.gray)
                .cornerRadius(10)
            
                
                
            }.padding()
            
            Button("Classify") {
                // classify the image here
                self.detectFaces() { results in
                    
                    if let results = results {
                        
                        DispatchQueue.main.async {
                            self.classficationLabel = "Faces: \(results.count)"
                        }
                    }
                    
                }
                
            }.padding()
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(8)
            
            Text(classficationLabel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
