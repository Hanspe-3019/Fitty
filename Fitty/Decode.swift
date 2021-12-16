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
    let formatter = DateFormatter()
    var beVerbose = false
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
        if beVerbose {
            print("is type \(toText( mesg.getType() ) )")
        }
        cntFileId += 1
    }
    
    init?(path: String, verbose: Bool) {
        super.init()
        self.beVerbose = verbose
        let decoder = FITDecoder()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
       
        let broadcaster = FITMessageBroadcaster()
        decoder.mesgDelegate = broadcaster
        broadcaster.fitFileIdMesgDelegate = self
        broadcaster.mesgDelegate = self
        broadcaster.fitMonitoringMesgDelegate = self
        broadcaster.fitRecordMesgDelegate = self
        let valid = decoder.isFIT(path) && decoder.checkIntegrity(path) ? "" : "FIT File not valid"
        
        if valid.count > 0 {
            print("\n")
            return nil
        }
        if beVerbose {
            print("File: \(path) \(valid)", separator: " ", terminator: " ")
        }
    
        if decoder.decodeFile(path) {
            if beVerbose {
                print("\(cntMesg) Messages,  \(cntFileId) FileId")
            
                for num in nums.keys {
                    let cntString = String(format: "%8d", nums[num] ?? -1)
                    let keyString = "\(toText(num).padding(toLength: 20, withPad: " ", startingAt: 0))"
                    print("\(keyString): \(cntString)")
                }
            }
        } else {
            print("** Some Error happened during decodeFile() **")
        }

    }

}
