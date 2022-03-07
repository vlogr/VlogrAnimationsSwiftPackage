//
//  File 3.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeInPushUpToCenterAnimation1: VlogrAnimationOutcome, VlogrAnimationOutcomeArrayUnArchivable {
    
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
    
    private var cachedTranslationXs = [CGFloat]()
    private var cachedTranslationYs = [CGFloat]()
    private var cachedRotations = [CGFloat]()
    private var cachedScales = [CGFloat]()
    private var cachedAlphas = [CGFloat]()
    private var isCached = false
    
    public mutating func loadFromFilesIfNeeded() {
        let loadedValues = load()
        if loadedValues.translationX.isEmpty == false {
            self.cachedTranslationXs = loadedValues.translationX
            self.cachedTranslationYs = loadedValues.translationY
            self.cachedRotations = loadedValues.rotation
            self.cachedScales = loadedValues.scale
            self.cachedAlphas = loadedValues.alpha
            
            self.isCached = true
        }
    }
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        if isCached == true {
            
            let translationXs = self.cachedTranslationXs
            let translationYs = self.cachedTranslationYs
            let rotations = self.cachedRotations
            let scales = self.cachedScales
            let alphas = self.cachedAlphas
            
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
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x
        
        // y position
        let newY = 1.0 + normalizedCenter.y - (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
        
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
