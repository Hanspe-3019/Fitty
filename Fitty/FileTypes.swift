//
//  FileTypes.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 12.12.21.
//

import Foundation
import ObjcFIT
let files : [ FITFile: String] = [
    1 :  "Device",
    2 :  "Settings",
    3 :  "Sport",
    4 :  "Activity",
    5 :  "Workout",
    6 :  "Course",
    7 :  "Schedules",
    9 :  "Weight",
    10 : "Totals",
    11 : "Goals",
    14 : "BloodPressure",
    15 : "MonitoringA",
    20 : "ActivitySummary",
    28 : "MonitoringDaily",
    32 : "MonitoringB",
    34 : "Segment",
    35 : "SegmentList",
    40 : "ExdConfiguration",
]

func toText(_ file:  FITFile) -> String {
    return files[file] ?? "unknown (\(file))"
}
