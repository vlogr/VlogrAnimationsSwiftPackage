//
//  File.swift
//  
//
//  Created by vlogrFullName on 2021/10/25.
//

import UIKit

public struct ScaleDownEasyOutElasticAnimation: VlogrAnimationOutcome {
    
    public func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
        
        ScaleUpEasyOutElasticAnimation.init().result(translation: &translation, rotation: &rotation, scale: &scale, alpha: &alpha, progress: (1.0 - progress), inputVariable: inputVariable)
    }
}