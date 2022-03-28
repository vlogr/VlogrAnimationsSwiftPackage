//
//  File.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeInPushLeftToCenterAnimation1: VlogrAnimationOutcome, VlogrAnimationOutcomeArrayUnArchivable {
    
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
        
        /*
        var cachedValues = VlogrAnimationFileManager.shared.cachedValues(from: kind)
        
        if cachedValues == nil {
            VlogrAnimationFileManager.shared.loadIfNeeded(fileNames: fileNames, folderUrl: folderUrl, kind: kind)
            cachedValues = VlogrAnimationFileManager.shared.cachedValues(from: kind)
        }
        
        if let cachedValues = cachedValues,
           cachedValues.translationX.count > 100,
           cachedValues.translationY.count > 100,
           cachedValues.rotation.count > 100,
           cachedValues.scale.count > 100,
           cachedValues.alpha.count > 100 {
            
            let translationXs = cachedValues.translationX
            let translationYs = cachedValues.translationY
            let rotations = cachedValues.rotation
            let scales = cachedValues.scale
            let alphas = cachedValues.alpha
            
            // trim index so that 0 to 100
            var index = Int((progress * 100.0).rounded())
            if index < 0 {
                index = 0
            } else if index > 100 {
                index = 100
            }
            
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
        */
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = 1.0 + normalizedCenter.x - (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
        // y position
        let newY = normalizedCenter.y
        
        
        translation = CGPoint.init(x: newX, y: newY)
        rotation = inputVariable.fixedRotation
        scale = inputVariable.fixedScale
        
        if progress <= 0.7 {
            alpha = VlogrAnimationTimingUtil.inOutTiming(from: 0.0)
        } else {
            
            let newProgress = (progress - 0.7) * (1.0/0.3)
            alpha = VlogrAnimationTimingUtil.inOutTiming(from: newProgress)
        }
    }
}
