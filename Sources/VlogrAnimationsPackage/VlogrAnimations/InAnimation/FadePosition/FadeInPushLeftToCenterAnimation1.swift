//
//  File.swift
//  
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeInPushLeftToCenterAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        // x position
        let normalizedCenter = inputVariable.fixedCenter
        let newX = normalizedCenter.x - ((1.0 - VlogrAnimationTimingUtil.inOutTiming(from: progress)) * 1.0)
        
        // y position
        let newY = normalizedCenter.y
        
        
        translation = CGPoint.init(x: newX, y: newY)
        rotation = inputVariable.fixedRotation
        scale = inputVariable.fixedScale
        alpha = VlogrAnimationTimingUtil.inOutTiming(from: progress)
    }
}
