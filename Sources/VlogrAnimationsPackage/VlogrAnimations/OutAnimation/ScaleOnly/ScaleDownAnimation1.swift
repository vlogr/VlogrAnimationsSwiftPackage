//
//  ScaleDownAnimation1.swift
//  VlogrAnimations
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct ScaleDownAnimation1: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        let sc = (1.0 - VlogrAnimationTimingUtil.inOutTiming(from: progress)) * inputVariable.fixedScale
        
        translation = inputVariable.fixedCenter
        rotation = inputVariable.fixedRotation
        scale = sc
    }
}
