//
//  Decode.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 13.12.21.
//

import Foundation
import ObjcFIT
import SwiftFIT

final class DecodeWithBroadcaster:
    NSObject,
    FITMesgDelegate,
    FITFileIdMesgDelegate
{
    var cntMesg = 0
    var cntFileId = 0
    var lastTimestamp: FITDateTime = 0
    var lastSteps: FITUInt32 = 0
    var nums: [FITMesgNum: Int] = [:]

    func onMesg(_ mesg: FITMessage) {
        cntMesg += 1
        nums[mesg.getNum(), default: 0] += 1
        return
    }
    
    func onFileIdMesg(_ mesg: FITFileIdMesg) {
        print("is type \(toText( mesg.getType() ) )")
        cntFileId += 1
    }
    
    init?(path: String) {
        super.init()
        let decoder = FITDecoder()
        
        let broadcaster = FITMessageBroadcaster()
        decoder.mesgDelegate = broadcaster
        broadcaster.fitFileIdMesgDelegate = self
        broadcaster.mesgDelegate = self
        broadcaster.fitMonitoringMesgDelegate = self
        let valid = decoder.isFIT(path) && decoder.checkIntegrity(path) ? "" : "FIT File not valid"
        
        if valid.count > 0 {
            print("\n")
            return nil
        }
        
        print("File: \(path) \(valid)", separator: " ", terminator: " ")
    
        if decoder.decodeFile(path) {
            print("\(cntMesg) Messages,  \(cntFileId) FileId")

            for num in nums.keys {
                let cntString = String(format: "%8d", nums[num] ?? -1)
                let keyString = "\(toText(num).padding(toLength: 20, withPad: " ", startingAt: 0))"
                print("\(keyString): \(cntString)")
            }
        } else {
            print("** Some Error happened during decodeFile() **")
        }

    }

}
