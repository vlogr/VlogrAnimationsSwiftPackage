//
//  ScaleDownEasyInoutAnimation.swift
//  VlogrAnimations
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct ScaleDownEasyInoutAnimation: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        ScaleUpEasyInoutAnimation.init().result(translation: &translation, rotation: &rotation, scale: &scale, alpha: &alpha, progress: (1.0 - progress), inputVariable: inputVariable)
    }
}