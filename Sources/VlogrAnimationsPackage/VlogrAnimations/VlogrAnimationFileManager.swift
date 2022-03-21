//
//  VlogrAnimationFileManager.swift
//  VlogrAnimations
//
//  Created by vlogrFullName on 2022/03/21.
//

import UIKit

class VlogrAnimationFileManager: NSObject {
    public static var shared: VlogrAnimationFileManager = {
        return VlogrAnimationFileManager()
    }()
    
    private var queue = DispatchQueue.init(label: "VlogrAnimationFileManager")
    
    func load(fileNames:[String], folderUrl:URL) -> (translationX:[CGFloat], translationY:[CGFloat], rotation:[CGFloat], scale:[CGFloat], alpha:[CGFloat]) {
        
        var returnValues: (translationX:[CGFloat], translationY:[CGFloat], rotation:[CGFloat], scale:[CGFloat], alpha:[CGFloat]) = ([CGFloat](),[CGFloat](),[CGFloat](),[CGFloat](),[CGFloat]())
        
        queue.sync {
            let urls = fileNames.map({folderUrl.appendingPathComponent($0)})

            var strings = [String]()
            for url in urls {
                var str = ""
                do {
                    try str = String.init(contentsOf: url)
                } catch {
                    print("cannnot load file")
                    continue
                }
                
                strings.append(str)
            }

            if strings.count == 5 {
                print("number of files unmatched")
                
                // parse strings
                // expected input: 1.000, 3.000, 1.342, ... , 0.0 total 101 float values in an array
                let v1 = VlogrAnimation.unarchived(from: strings[0])
                let v2 = VlogrAnimation.unarchived(from: strings[1])
                let v3 = VlogrAnimation.unarchived(from: strings[2])
                let v4 = VlogrAnimation.unarchived(from: strings[3])
                let v5 = VlogrAnimation.unarchived(from: strings[4])
                
                returnValues = (v1, v2, v3, v4, v5)
            }
        }
        
        return returnValues
    }
    
    fileprivate func saveToFile(translationXs: [CGFloat], translationYs: [CGFloat], rotations: [CGFloat], scales: [CGFloat], alphas: [CGFloat], urls:[URL]) -> Bool {
        
        var returnValue = false
        
        queue.sync {
            let tx = VlogrAnimation.archivingObject(from: translationXs)
            let ty = VlogrAnimation.archivingObject(from: translationYs)
            let r = VlogrAnimation.archivingObject(from: rotations)
            let s = VlogrAnimation.archivingObject(from: scales)
            let a = VlogrAnimation.archivingObject(from: alphas)
            
            if let _ = try? tx.write(to: urls[0], atomically: true, encoding: .utf8),
               let _ = try? ty.write(to: urls[1], atomically: true, encoding: .utf8),
               let _ = try? r.write(to: urls[2], atomically: true, encoding: .utf8),
               let _ = try? s.write(to: urls[3], atomically: true, encoding: .utf8),
               let _ = try? a.write(to: urls[4], atomically: true, encoding: .utf8) {
                
                returnValue = true
            }
        }
        
        return returnValue
    }
    
}

