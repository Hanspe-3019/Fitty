//
//  onmonitor.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 13.12.21.
//

import Foundation
import ObjcFIT
import SwiftFIT


extension DecodeWithBroadcaster:
    FITMonitoringMesgDelegate
{
    
    
    func onMonitoringMesg(_ mesg: FITMonitoringMesg) {
        let msgid = "MON-\(cntMesg)".padding(toLength: 10, withPad: " ", startingAt: 0)
        let hr = mesg.getHeartRate()
        let hasHR = hr < FITUInt8.max
        let steps = mesg.getSteps()
        let hasSteps = steps < FITUInt32.max
        if hasSteps {
            lastSteps = steps
        }
        
        
        let fitDate = mesg.getTimestamp()
        var date = fitDate.date
        let timestamp = fitDate.timestamp
        let hasTimestamp = ( timestamp < FITDateTime.max )
        if hasTimestamp {
            // merke timestamp
            lastTimestamp = mesg.getTimestamp().timestamp
        } else {
            let timestamp16 = mesg.getTimestamp16()
            assert(timestamp16 < FITUInt16.max, "Oje!")
            
            let step1 = (lastTimestamp & 0xffff0000)
            let step2 = step1 + UInt32(timestamp16)
            date = FITDate(timestamp: step2).date
        }
        if hasHR {
        print("\(msgid) HR: \(hr)  \(date)")
        }
    }
    

}
