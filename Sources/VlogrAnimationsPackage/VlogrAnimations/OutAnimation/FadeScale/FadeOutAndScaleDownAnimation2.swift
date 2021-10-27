//
//  File.swift
//
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct FadeOutAndScaleDownAnimation2: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        var sc = (1.0 - VlogrAnimationTimingUtil.easeOutElastic(from: progress)) * inputVariable.fixedScale
        
        if sc <= 0.0 {
            sc = 0.0
        }
        
        translation = inputVariable.fixedCenter
        rotation = inputVariable.fixedRotation
        scale = sc
        
        alpha = 1.0 - VlogrAnimationTimingUtil.easeOutElastic(from: progress)
    }
}
