//
//  RightFallAnimation.swift
//  TestsOnTextAnimation
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct RightFallAnimation: VlogrAnimationOutcome, VlogrAnimationOutcomeArrayUnArchivable {
    
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
        
        let newX = normalizedCenter.x + (progress * 0.15)
        
        // y position
        let newY = normalizedCenter.y + (VlogrAnimationTimingUtil.gravityTiming(from: progress) * 3.0)
        
//        let originalCenter = VlogrAnimationTimingUtil.worldPoint(from: normalizedCenter, worldRect: inputVariable.worldRect)
//        let newCenter = VlogrAnimationTimingUtil.worldPoint(from: CGPoint.init(x: newX, y: newY), worldRect: inputVariable.worldRect)
        
        // rotation
        let piX = (.pi/2.0) * VlogrAnimationTimingUtil.inOutTiming(from: progress)
        
        // scale
        let sc = 1.0
        
        translation = CGPoint.init(x: newX, y: newY)//CGPoint.init(x: newCenter.x - originalCenter.x, y: newCenter.y - originalCenter.y)
        rotation = piX + inputVariable.fixedRotation
        scale = inputVariable.fixedScale
    }
}
