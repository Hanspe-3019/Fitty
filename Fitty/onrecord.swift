//
//  onrecord.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 14.12.21.
//

import Foundation
import ObjcFIT
import SwiftFIT


extension DecodeWithBroadcaster:
    FITRecordMesgDelegate
{
    func onRecordMesg(_ mesg: FITRecordMesg) {
        let msgid = "REC-\(cntMesg)".padding(toLength: 10, withPad: " ", startingAt: 0)
        let hr = mesg.getHeartRate()
                
        let fitDate = mesg.getTimestamp()
        let date = fitDate.date
        
        if ( fitDate.timestamp < FITDateTime.max ) && hr < FITUInt8.max {
            print("\(msgid) HR: \(hr)  \(date)")
        }
    }
    

}
