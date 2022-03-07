//
//  VlogrAnimation.swift
//  TestsOnTextAnimation
//
//  Created by vlogrFullName on 2021/10/13.
//

import UIKit

public struct VlogrAnimation: Decodable, Encodable {
    
    public static var folderName = "VlogrAnimation"
    
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
        //case RightFall, Oscillation
        case Oscillation
        
        // in animations
        case PushUpToCenterAnimation1, PushRightToCenterAnimation1, PushLeftToCenterAnimation1, PushDownToCenterAnimation1
        case FadeInAndScaleUpAnimation1, FadeInAndScaleUpAnimation2
        case FSPushUpToCenterAnimation1, FSPushRightToCenterAnimation1, FSPushLeftToCenterAnimation1, FSPushDownToCenterAnimation1
        case FadeInPushDownToCenterAnimation1, FadeInPushLeftToCenterAnimation1, FadeInPushRightToCenterAnimation1,
             FadeInPushUpToCenterAnimation1
        case ScaleUpAnimation1, ScaleUpAnimation2
        case FadeInAnimation1, FadeInAnimation2
        
        // out animations
        case PushDownFromCenterAnimation1, PushLeftFromCenterAnimation1, PushRightFromCenterAnimation1, PushUpFromCenterAnimation1
        case FadeOutAndScaleDownAnimation1, FadeOutAndScaleDownAnimation2
        case FSPushDownFromCenterAnimation1, FSPushLeftFromCenterAnimation1, FSPushRightFromCenterAnimation1, FSPushUpFromCenterAnimation1
        case FadeOutPushDownFromCenterAnimation1, FadeOutPushLeftFromCenterAnimation1, FadeOutPushRightFromCenterAnimation1, FadeOutPushUpFromCenterAnimation1
        case ScaleDownAnimation1, ScaleDownAnimation2
        case FadeOutAnimation1, FadeOutAnimation2
        
        public var valueFileNames: [String] {
            
            var names = [String]()
            for i in 1...5 {
                let name = self.rawValue + "\(i).txt"
                names.append(name)
            }
            
            return names
        }
    }
    
    
    public let kind: Kind
    public var appearance: AppearanceType!
    var actualAnimation: VlogrAnimationOutcome!
    
    public init(kind:Kind) {
        self.kind = kind
        
        setAppearanceAndActualAnimationObject()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private mutating func setAppearanceAndActualAnimationObject() {
        
        let folderUrl = getDocumentsDirectory().appendingPathComponent(VlogrAnimation.folderName)
        
        
        switch kind {
        case .RightFall:
            self.actualAnimation = RightFallAnimation.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
        case .Oscillation:
            self.actualAnimation = OscillationAnimation.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .RepeatAnimation
            
        // inAnimation
        case .PushUpToCenterAnimation1:
            self.actualAnimation = PushUpToCenterAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
        case .PushRightToCenterAnimation1:
            self.actualAnimation = PushRightToCenterAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .PushLeftToCenterAnimation1:
            self.actualAnimation = PushLeftToCenterAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .PushDownToCenterAnimation1:
            self.actualAnimation = PushDownToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FadeInAndScaleUpAnimation1:
            self.actualAnimation = FadeInAndScaleUpAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FadeInAndScaleUpAnimation2:
            self.actualAnimation = FadeInAndScaleUpAnimation2(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FSPushUpToCenterAnimation1:
            self.actualAnimation = FSPushUpToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FSPushRightToCenterAnimation1:
            self.actualAnimation = FSPushRightToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FSPushLeftToCenterAnimation1:
            self.actualAnimation = FSPushLeftToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FSPushDownToCenterAnimation1:
            self.actualAnimation = FSPushDownToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FadeInPushDownToCenterAnimation1:
            self.actualAnimation = FadeInPushDownToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FadeInPushLeftToCenterAnimation1:
            self.actualAnimation = FadeInPushLeftToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FadeInPushRightToCenterAnimation1:
            self.actualAnimation = FadeInPushRightToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .FadeInPushUpToCenterAnimation1:
            self.actualAnimation = FadeInPushUpToCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .ScaleUpAnimation2:
            self.actualAnimation = ScaleUpAnimation2(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        case .ScaleUpAnimation1:
            self.actualAnimation = ScaleUpAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
        case .FadeInAnimation1:
            self.actualAnimation = FadeInAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
        
        case .FadeInAnimation2:
            self.actualAnimation = FadeInAnimation2.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .InAnimation
            
        // outAnimation
        case .PushDownFromCenterAnimation1:
            self.actualAnimation = PushDownFromCenterAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
        
        case .PushLeftFromCenterAnimation1:
            self.actualAnimation = PushLeftFromCenterAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .PushRightFromCenterAnimation1:
            self.actualAnimation = PushRightFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .PushUpFromCenterAnimation1:
            self.actualAnimation = PushUpFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FadeOutAndScaleDownAnimation1:
            self.actualAnimation = FadeOutAndScaleDownAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FadeOutAndScaleDownAnimation2:
            self.actualAnimation = FadeOutAndScaleDownAnimation2(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FSPushDownFromCenterAnimation1:
            self.actualAnimation = FSPushDownFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FSPushLeftFromCenterAnimation1:
            self.actualAnimation = FSPushLeftFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FSPushRightFromCenterAnimation1:
            self.actualAnimation = FSPushRightFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FSPushUpFromCenterAnimation1:
            self.actualAnimation = FSPushUpFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FadeOutPushDownFromCenterAnimation1:
            self.actualAnimation = FadeOutPushDownFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FadeOutPushLeftFromCenterAnimation1:
            self.actualAnimation = FadeOutPushLeftFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FadeOutPushRightFromCenterAnimation1:
            self.actualAnimation = FadeOutPushRightFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FadeOutPushUpFromCenterAnimation1:
            self.actualAnimation = FadeOutPushUpFromCenterAnimation1(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .ScaleDownAnimation1:
            self.actualAnimation = ScaleDownAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .ScaleDownAnimation2:
            self.actualAnimation = ScaleDownAnimation2(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
            
        case .FadeOutAnimation1:
            self.actualAnimation = FadeOutAnimation1.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
            self.appearance = .OutAnimation
        
        case .FadeOutAnimation2:
            self.actualAnimation = FadeOutAnimation2.init(kind: kind, folderUrl: folderUrl.appendingPathComponent(kind.rawValue))
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
    
    public static func easeInBack(from t:CGFloat) -> CGFloat {
        
        let c1:CGFloat = 1.70158;
        let c3:CGFloat = c1 + 1;

        return c3 * t * t * t - c1 * t * t;
    }
    
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

protocol VlogrAnimationOutcomeArrayUnArchivable {
    var fileNames: [String] { get }
    var folderUrl: URL { get }
    func load() -> (translationX:[CGFloat], translationY:[CGFloat], rotation:[CGFloat], scale:[CGFloat], alpha:[CGFloat])
}

extension VlogrAnimationOutcomeArrayUnArchivable {
    
    func load() -> (translationX:[CGFloat], translationY:[CGFloat], rotation:[CGFloat], scale:[CGFloat], alpha:[CGFloat]) {
        
        let urls = fileNames.map({folderUrl.appendingPathComponent($0)})

        var strings = [String]()
        for url in urls {
            var str = ""
            do {
                try str = String.init(contentsOf: url)
            } catch {
                print("cannnot load file")
                continue
            }
            
            strings.append(str)
        }

        guard strings.count == 5 else {
            print("number of files unmatched")
            return ([CGFloat](),[CGFloat](),[CGFloat](),[CGFloat](),[CGFloat]())
        }
        
        // parse strings
        // expected input: 1.000, 3.000, 1.342, ... , 0.0 total 101 float values in an array
        let v1 = VlogrAnimation.unarchived(from: strings[0])
        let v2 = VlogrAnimation.unarchived(from: strings[1])
        let v3 = VlogrAnimation.unarchived(from: strings[2])
        let v4 = VlogrAnimation.unarchived(from: strings[3])
        let v5 = VlogrAnimation.unarchived(from: strings[4])
        
        return (v1,v2,v3,v4,v5)
    }
    
}

/// for archiving, unarchiving animation array values
public extension VlogrAnimation {
    public static func archivingObject(from values:[CGFloat]) -> String {
        var str = ""
        for (i,v) in values.enumerated() {
            if i > 0 {
                str = str + ","
            }
            str = str + String.init(format: "%lf", v)
        }
        return str
    }
    
    public static func unarchived(from str:String) -> [CGFloat] {
        
        var values = [CGFloat]()
        let components = str.components(separatedBy: ",")
        for component in components {
            
            if let doubleValue = Double.init(component) {
                values.append(CGFloat(doubleValue))
            }
            
        }
        
        return values
    }
}
