//
//  main.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 10.12.21.
//

import Foundation
import ObjcFIT
import SwiftFIT

final class DecodeWithBroadcaster:
    NSObject,
    FITMesgDelegate,
    FITFileIdMesgDelegate,
    FITMonitoringMesgDelegate
{
    
    var cntMesg = 0
    var cntFileId = 0
    var nums: [FITMesgNum: Int] = [:]

    func onMesg(_ mesg: FITMessage) {
        cntMesg += 1
        nums[mesg.getNum(), default: 0] += 1
        return
    }
    
    func onFileIdMesg(_ mesg: FITFileIdMesg) {
        print("\(mesg.description) \(mesg.getType())")
        cntFileId += 1
    }
    
    func onMonitoringMesg(_ mesg: FITMonitoringMesg) {
        let ts = mesg.getTimestamp()
        print("HR: \(mesg.getHeartRate())  \(ts) = \(ts.date)")
    }
    
    init(path: String) {
        super.init()
        print("Hello, World!")
        let decoder = FITDecoder()
        
        let broadcaster = FITMessageBroadcaster()
        decoder.mesgDelegate = broadcaster
        broadcaster.fitFileIdMesgDelegate = self
        broadcaster.mesgDelegate = self
        broadcaster.fitMonitoringMesgDelegate = self
        
        print(
            path,
            decoder.isFIT(path),
            decoder.checkIntegrity(path)
        )
    
        if decoder.decodeFile(path) {
            print("\(cntMesg) Messages,  \(cntFileId) FileId")

            for num in nums.keys {
                let cntString = String(format: "%8d", nums[num] ?? -1)
                print(
                    "\(toText(num).padding(toLength: 20, withPad: " ", startingAt: 0))" +
                    ": \(cntString)"
                )
            }
        } else {
            print("** Some Error **")
        }

    }

}
                                         
/* main */

_ = DecodeWithBroadcaster(path: "/Users/mb/Downloads/FIT/forerunner/Monitor/MCA00000.fit")
