//
//  File 2.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeInPushRightToCenterAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = -1.0 + normalizedCenter.x + (VlogrAnimationTimingUtil.inOutTiming(from: progress) * 1.0)
        
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
