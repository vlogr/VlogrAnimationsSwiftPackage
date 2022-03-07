//
//  File 3.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FSPushUpToCenterAnimation1: VlogrAnimationOutcome, VlogrAnimationOutcomeArrayUnArchivable {
    
    var fileNames: [String] {
        return kind.valueFileNames
    }
    var folderUrl: URL {
        return _folderUrl
    }
    
    let kind:VlogrAnimation.Kind
    let _folderUrl:URL
    
    init(kind: VlogrAnimation.Kind, folderUrl:URL) {
        self.kind = kind
        self._folderUrl = folderUrl
    }
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        var loadedValues = VlogrAnimationValueCache.shared.cachedValues(from: kind)
        if loadedValues == nil {
            let loadedFromFile = load()
            if loadedFromFile.translationX.isEmpty == false {
                VlogrAnimationValueCache.shared.cache(kind: kind, values: loadedFromFile)
                loadedValues = VlogrAnimationValueCache.shared.cachedValues(from: kind)
            }
            
        }
        
        if let loadedValues = loadedValues {
            
            let translationXs = loadedValues.translationX
            let translationYs = loadedValues.translationY
            let rotations = loadedValues.rotation
            let scales = loadedValues.scale
            let alphas = loadedValues.alpha
            
            let index = Int((progress * 100.0).rounded())
            
            let newX = translationXs[index] + inputVariable.fixedCenter.x
            let newY = translationYs[index] + inputVariable.fixedCenter.y
            let newRotation = rotations[index] + inputVariable.fixedRotation
            let newScale = scales[index] * inputVariable.fixedScale
            let newAlpha = alphas[index]
            
            translation = CGPoint.init(x: newX, y: newY)
            rotation = newRotation
            scale = newScale
            alpha = newAlpha
            
            return
        }
        
        var sc = inputVariable.fixedScale
        
        if progress <= 0.5 {
            sc = inputVariable.fixedScale
        } else {
            sc = (VlogrAnimationTimingUtil.inOutTiming(from: (progress-0.5) * 2)) * inputVariable.fixedScale
        }
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x
        
        // y position
        let newY = 1.0 + normalizedCenter.y - (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
        
        translation = CGPoint.init(x: newX, y: newY)
        rotation = inputVariable.fixedRotation
        scale = sc
        
        if progress <= 0.75 {
            alpha = 0
        } else {
            alpha = VlogrAnimationTimingUtil.easeOutCubic(from: (progress-0.75) * 4)
        }
    }
}
