import CoreLocation
import CoreMotion
import Flutter
import simd
import UIKit

public class SwiftFlutterCompassPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, CLLocationManagerDelegate {
    private var eventSink: FlutterEventSink?
    private var location = CLLocationManager()
    private var motion = CMMotionManager()
    private var orientation : UIDeviceOrientation = .portrait
    
    init(channel: FlutterEventChannel) {
        super.init()
        location.delegate = self
        location.headingFilter = 0.1
        channel.setStreamHandler(self)
        location.headingOrientation = .landscapeRight
        motion.deviceMotionUpdateInterval = 0.1
//        motion.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xMagneticNorthZVertical)
        getOrientation()
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: "hemanthraj/flutter_compass", binaryMessenger: registrar.messenger())
        _ = SwiftFlutterCompassPlugin(channel: channel)
    }

    public func onListen(withArguments arguments: Any?,
                         eventSink: @escaping FlutterEventSink) -> FlutterError?
    {
        self.eventSink = eventSink
        location.startUpdatingHeading()
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        location.stopUpdatingHeading()
        return nil
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy > 0 {
            var headingForCameraMode = newHeading.magneticHeading
            // If device orientation data is available, use it to calculate the heading out the the
            // back of the device (rather than out the top of the device).
            if let data = motion.deviceMotion?.attitude {
                // Re-map the device orientation matrix such that the Z axis (out the back of the device)
                // always reads -90deg off magnetic north. All rotation matrices use + rotation to mean
                // counter-clockwise.
                let r1 = double3x3(rows: [
                    simd_double3(0, 0, 1),
                    simd_double3(0, 1, 0),
                    simd_double3(-1, 0, 0)
                ]) // -90 around the Y axis
                let r2 = double3x3(rows: [
                    simd_double3(0, -1, 0),
                    simd_double3(1, 0, 0),
                    simd_double3(0, 0, 1)
                ]) // -90 around the Z axis
                let R = double3x3(rows: [
                    simd_double3(data.rotationMatrix.m11, data.rotationMatrix.m12, data.rotationMatrix.m13),
                    simd_double3(data.rotationMatrix.m21, data.rotationMatrix.m22, data.rotationMatrix.m23),
                    simd_double3(data.rotationMatrix.m31, data.rotationMatrix.m32, data.rotationMatrix.m33)
                ])
                let T = r2 * r1 * R
                // Calculate yaw from R and add 90deg.
                let yaw = atan2(T[0, 1], T[1, 1]) + Double.pi / 2
                headingForCameraMode = (yaw + Double.pi * 2).truncatingRemainder(dividingBy: Double.pi * 2) * 180.0 / Double.pi
            }
//            print("---")
            print(self.cardinalValue(from: headingForCameraMode));
//            print(self.cardinalValue(from: newHeading.magneticHeading));
            eventSink?([newHeading.magneticHeading, headingForCameraMode, newHeading.headingAccuracy])
        }
    }

    func getOrientation() {
        let queue = OperationQueue.main
        motion.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xMagneticNorthZVertical, to: queue, withHandler: {
            [weak self]  data, _ in
            guard let self = self ,let data = data else { return }
            let x = data.gravity.x
            let y = data.gravity.y
            let agx = fabs(data.gravity.x)
                
            let agy = fabs(data.gravity.y)
            
           if (agx < 0.1 && agy < 0.1) {
               // ignore when both values are small as this means
               // the device is flat.
               // Basically, if the value for attidude in the z axis is close to 1 or -1 then the iPad is flat (facing down or up).
               // https://nshipster.com/cmdevicemotion/
//               print(data.gravity.z)
               if  data.gravity.z < 0 {
                   self.orientation = .faceUp
               }else {
                   self.orientation = .faceDown
               }
           }else{
               if fabs(y) >= fabs(x) {
                   if y >= 0 {
                       self.orientation = .portraitUpsideDown

                   } else {
                       self.orientation = .portrait
                   }
               } else {
                   if x >= 0 {
                       self.orientation = .landscapeRight

                   } else {
                       self.orientation = .landscapeLeft
                   }
               }
           }
            let o =  self.toCLDeviceOrientation()
            if self.location.headingOrientation != o {
                self.location.headingOrientation = o
                if CLLocationManager.headingAvailable() {
                    self.location.startUpdatingHeading()
                }
            }
            print(o.rawValue)
        })
    }
    
    func toCLDeviceOrientation() -> CLDeviceOrientation {
        switch self.orientation {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        case .faceUp:
            return .faceUp
        case .faceDown:
            return .faceDown
        case .unknown:
            return .unknown
        }
    }
    
    private func cardinalValue(from heading: CLLocationDirection) -> (String, String) {
            switch heading {
            case 0 ..< 22.5:
                return ("N", "北")
            case 22.5 ..< 67.5:
                return ("NE", "东北")
            case 67.5 ..< 112.5:
                return ("E", "东")
            case 112.5 ..< 157.5:
                return ("SE", "东南")
            case 157.5 ..< 202.5:
                return ("S", "南")
            case 202.5 ..< 247.5:
                return ("SW", "西南")
            case 247.5 ..< 292.5:
                return ("W", "西")
            case 292.5 ..< 337.5:
                return ("NW", "西北")
            case 337.5 ... 360.0:
                return ("N", "北")
            default:
                return ("", "")
            }
        }
}
