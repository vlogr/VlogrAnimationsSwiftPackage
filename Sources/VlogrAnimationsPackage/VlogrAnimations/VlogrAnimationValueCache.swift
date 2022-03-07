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

    
    func cachedValues(from kind:VlogrAnimation.Kind) -> ReturnValue? {
        
        if let v = cacheMap[kind.rawValue] {
            return v
        }
        
        return nil
    }
    
    func cache(kind: VlogrAnimation.Kind, values:ReturnValue) {
        cacheMap[kind.rawValue] = values
    }
}
