//
//  VlogrAnimation.swift
//  TestsOnTextAnimation
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct VlogrAnimation: Decodable, Encodable {
    
    public struct InputVariable {
        // normalized value
        let fixedCenter:CGPoint
        let fixedRotation:CGFloat
        let fixedScale:CGFloat
        
        public init(fixedCenter:CGPoint, fixedRotation:CGFloat, fixedScale:CGFloat) {
            self.fixedCenter = fixedCenter
            self.fixedRotation = fixedRotation
            self.fixedScale = fixedScale
        }
    }
    
    public enum AppearanceType: String {
        case InAnimation, OutAnimation, RepeatAnimation
    }
    
    public enum Kind: String, CaseIterable, Codable {
        // custom animations
        case RightFall, Oscillation
        
        // in animations
        case PushUpAnimation, ScaleUpAnimation, FadeInAnimation
        
        // out animations
        case PushDownAnimation, ScaleDownAnimation, FadeOutAnimation
    }
    
    
    public let kind: Kind
    public var appearance: AppearanceType!
    private var actualAnimation: VlogrAnimationOutcome!
    
    public init(kind:Kind) {
        self.kind = kind
        
        setAppearanceAndActualAnimationObject()
    }
    
    private mutating func setAppearanceAndActualAnimationObject() {
        switch kind {
        case .RightFall:
            self.actualAnimation = RightFallAnimation.init()
            self.appearance = .OutAnimation
        case .Oscillation:
            self.actualAnimation = OscillationAnimation.init()
            self.appearance = .RepeatAnimation
        case .PushDownAnimation:
            self.actualAnimation = PushDownAnimation.init()
            self.appearance = .OutAnimation
        case .PushUpAnimation:
            self.actualAnimation = PushUpAnimation.init()
            self.appearance = .InAnimation
        case .ScaleUpAnimation:
            self.actualAnimation = ScaleUpAnimation.init()
            self.appearance = .InAnimation
        case .FadeInAnimation:
            self.actualAnimation = FadeInAnimation.init()
            self.appearance = .InAnimation
        case .ScaleDownAnimation:
            self.actualAnimation = ScaleDownAnimation.init()
            self.appearance = .OutAnimation
        case .FadeOutAnimation:
            self.actualAnimation = FadeOutAnimation.init()
            self.appearance = .OutAnimation
        }
    }
    
    // MARK: - Encodable, Decodable
    enum CodingKeys: String, CodingKey {
        case kind
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        kind = try container.decode(Kind.self, forKey: .kind)
        setAppearanceAndActualAnimationObject()
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(kind, forKey: .kind)
    }
    
    // read values from designed animation object
    public func result(translation: inout CGPoint, rotation: inout CGFloat, scale: inout CGFloat, alpha: inout CGFloat, progress: CGFloat, inputVariable: InputVariable) {
        return actualAnimation.result(translation: &translation, rotation: &rotation, scale: &scale, alpha: &alpha, progress: progress, inputVariable: inputVariable)
    }
    
    // MARK: - Convenient functions
    public func resultTransform(progress: CGFloat, inputVariable: InputVariable, worldRect:CGRect) -> (CGAffineTransform, CGFloat) {
        var centerPoint = CGPoint.zero
        var rotation: CGFloat = 0
        var scale: CGFloat = 0
        var alpha: CGFloat = 1.0
        
        result(translation: &centerPoint, rotation: &rotation, scale: &scale, alpha: &alpha, progress: progress, inputVariable: inputVariable)
        
        let originalCenter = VlogrAnimationTimingUtil.worldPoint(from: inputVariable.fixedCenter, worldRect: worldRect)
        let newCenter = VlogrAnimationTimingUtil.worldPoint(from: centerPoint, worldRect: worldRect)
        let translationPoint = CGPoint.init(x: newCenter.x - originalCenter.x, y: newCenter.y - originalCenter.y)
        
        let transform1 = CGAffineTransform.init(rotationAngle: rotation)
        let transform2 = CGAffineTransform.init(translationX: translationPoint.x, y: translationPoint.y)
        let transform3 = CGAffineTransform.init(scaleX: scale, y: scale)
        return (transform1.concatenating(transform2).concatenating(transform3), alpha)
    }

}


// MARK: - Timing Functions
public struct VlogrAnimationTimingUtil {
    public static func inOutTiming(from t:CGFloat) -> CGFloat {
        let sqrt = t * t
        
        return sqrt / (2.0 * (sqrt - t) + 1.0)
    }
    
    public static func gravityTiming(from t:CGFloat) -> CGFloat {
        return t * t
    }
    
    public static func inOutCubicTiming(from t:CGFloat) -> CGFloat {
        return t < 0.5 ? 4 * t * t * t : 1 - pow(-2 * t + 2, 3) / 2;
    }
    
    public static func easeOutCubic(from t:CGFloat) -> CGFloat {
        return 1 - pow(1 - t, 3);
    }
    
    public static func easeOutElastic(from t:CGFloat) -> CGFloat {
        let c4 = (2.0 * .pi) / 3
        
        if t == 0 {
            return 0
        } else if t == 1 {
            return 1
        } else {
            return pow(2, -10 * t) * sin(t * 10 - 0.75) * c4 + 1
        }
    }
/*
    function easeOutElastic(x: number): number {
    const c4 = (2 * Math.PI) / 3;

    return x === 0
      ? 0
      : x === 1
      ? 1
      : pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
    }
*/
    public static func normalizedPoint(from pt:CGPoint, worldRect:CGRect) -> CGPoint {
        let x = pt.x / worldRect.width
        let y = pt.y / worldRect.height
        return CGPoint.init(x: x, y: y)
    }
    
    public static func worldPoint(from pt:CGPoint, worldRect:CGRect) -> CGPoint {
        let x = worldRect.width * pt.x
        let y = worldRect.height * pt.y
        return CGPoint.init(x: x, y: y)
    }
}

public protocol VlogrAnimationOutcome {
    func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha:inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable)
}
