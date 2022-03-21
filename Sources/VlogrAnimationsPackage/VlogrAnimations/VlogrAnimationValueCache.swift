//
//  VlogrAnimationValueCache.swift
//  VlogrAnimations
//
//  Created by vlogrFullName on 2022/03/07.
//

import UIKit

public class VlogrAnimationValueCache: NSObject {
    public static var shared: VlogrAnimationValueCache = {
        return VlogrAnimationValueCache()
    }()
    
    typealias ReturnValue = (translationX:[CGFloat], translationY:[CGFloat], rotation:[CGFloat], scale:[CGFloat], alpha:[CGFloat])
    
    // string:tuple
    private var cacheMap = [VlogrAnimation.Kind.RawValue:ReturnValue]()

    private var queue = DispatchQueue.init(label: "VlogrAnimationValueCache")
    
    
    func cachedValues(from kind:VlogrAnimation.Kind) -> ReturnValue? {
        
        var value: ReturnValue?
        
        queue.sync {
            if let v = cacheMap[kind.rawValue] {
                value = v
            }
        }
        
        return value
    }
    
    func cache(kind: VlogrAnimation.Kind, values:ReturnValue) {
        queue.sync {
            cacheMap[kind.rawValue] = values
        }
    }
}
