//
//  Decode.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 13.12.21.
//

import Foundation
import ObjcFIT
import SwiftFIT

enum MyError: Error {
    case noFIT(reason :String)
    case decodeError

}
final class DecodeWithBroadcaster:
    NSObject,
    FITMesgDelegate,
    FITFileIdMesgDelegate
{
    let formatter = DateFormatter()
    
    let decoder = FITDecoder()
    
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
    func decode(_ path : String) throws -> Bool {
        
        let isFIT = decoder.isFIT(path)
        let isOkFIT = decoder.checkIntegrity(path)
        let valid = !isFIT ? "no FIT file" : !isOkFIT ? "FIT File not valid" : ""
        
        if beVerbose {
            print("File: \(path) \(valid)", separator: " ", terminator: " ")
        }
    
        if valid.count > 0 {
            throw MyError.noFIT(reason: valid)
        }
        
        cntMesg = 0
        cntFileId = 0
        lastTimestamp = 0
        lastSteps = 0
        nums = [:]
        guard decoder.decodeFile(path)  else {
            throw MyError.decodeError
        }
        if beVerbose {
            print("\t\(cntMesg) Messages,  \(cntFileId) FileId")
        
            for num in nums.keys {
                let cntString = String(format: "%8d", nums[num] ?? -1)
                let keyString = "\(toText(num).padding(toLength: 20, withPad: " ", startingAt: 0))"
                print("\t\(keyString): \(cntString)")
            }
        }
        return true
    }
    
    init(verbose: Bool) {
        super.init()
        self.beVerbose = verbose
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
       
        let broadcaster = FITMessageBroadcaster()
        decoder.mesgDelegate = broadcaster
        broadcaster.fitFileIdMesgDelegate = self
        broadcaster.mesgDelegate = self
        broadcaster.fitMonitoringMesgDelegate = self
        broadcaster.fitRecordMesgDelegate = self
    }

}
