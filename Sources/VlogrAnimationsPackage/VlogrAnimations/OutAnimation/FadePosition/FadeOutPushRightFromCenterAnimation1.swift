//
//  File 3.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeOutPushRightFromCenterAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x + (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
        // y position
        let newY = normalizedCenter.y
        
        
        translation = CGPoint.init(x: newX, y: newY)
        rotation = inputVariable.fixedRotation
        scale = inputVariable.fixedScale
        let newAlpha = 1.0 - VlogrAnimationTimingUtil.easeOutCubic(from: progress * 2.5)
        if newAlpha <= 0 {
            alpha = 0
        } else {
            alpha = newAlpha
        }
    }
}
