//
//  Reachability.swift
//
//  Created by jlandy on 20/10/22.
//  Copyright © 2022 eurekadevelopers. All rights reserved.
//

import Foundation
import SystemConfiguration

class Reachability : NSObject {
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
    private var flags = SCNetworkReachabilityFlags()
   
    override init() {
        SCNetworkReachabilityGetFlags(reachability!, &flags)
    }
    
    @objc public func isReachable() -> Bool{
        if !isNetworkReachable(with: flags) {
            // Device doesn't have internet connection
            return false
        } else {
            if flags.contains(.isWWAN) {
                    // Device is using mobile data
                return true
            }
            return true
        }
    }
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
}
