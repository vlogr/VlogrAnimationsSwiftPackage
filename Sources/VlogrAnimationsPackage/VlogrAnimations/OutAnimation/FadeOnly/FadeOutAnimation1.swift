//
//  FadeOutAnimation1.swift
//  VlogrAnimations
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct FadeOutAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        translation = inputVariable.fixedCenter
        rotation = inputVariable.fixedRotation
        scale = inputVariable.fixedScale
        alpha = 1.0 - VlogrAnimationTimingUtil.inOutTiming(from: progress)
    }
}
