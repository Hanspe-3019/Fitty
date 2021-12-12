//
//  MesgNum.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 12.12.21.
//

import Foundation
import ObjcFIT
let mesgNums : [ FITMesgNum : String ] = [
    0 :   "FileId",
    1 :   "Capabilities",
    2 :   "DeviceSettings",
    3 :   "UserProfile",
    4 :   "HrmProfile",
    5 :   "SdmProfile",
    6 :   "BikeProfile",
    7 :   "ZonesTarget",
    8 :   "HrZone",
    9 :   "PowerZone",
    10 :  "MetZone",
    12 :  "Sport",
    15 :  "Goal",
    18 :  "Session",
    19 :  "Lap",
    20 :  "Record",
    21 :  "Event",
    23 :  "DeviceInfo",
    26 :  "Workout",
    27 :  "WorkoutStep",
    28 :  "Schedule",
    30 :  "WeightScale",
    31 :  "Course",
    32 :  "CoursePoint",
    33 :  "Totals",
    34 :  "Activity",
    35 :  "Software",
    37 :  "FileCapabilities",
    38 :  "MesgCapabilities",
    39 :  "FieldCapabilities",
    49 :  "FileCreator",
    51 :  "BloodPressure",
    53 :  "SpeedZone",
    55 :  "Monitoring",
    72 :  "TrainingFile",
    78 :  "Hrv",
    80 :  "AntRx",
    81 :  "AntTx",
    82 :  "AntChannelId",
    101 : "Length",
    103 : "MonitoringInfo",
    105 : "Pad",
    106 : "SlaveDevice",
    127 : "Connectivity",
    128 : "WeatherConditions",
    129 : "WeatherAlert",
    131 : "CadenceZone",
    132 : "Hr",
    142 : "SegmentLap",
    145 : "MemoGlob",
    148 : "SegmentId",
    149 : "SegmentLeaderboardEntry",
    150 : "SegmentPoint",
    151 : "SegmentFile",
    158 : "WorkoutSession",
    159 : "WatchfaceSettings",
    160 : "GpsMetadata",
    161 : "CameraEvent",
    162 : "TimestampCorrelation",
    164 : "GyroscopeData",
    165 : "AccelerometerData",
    167 : "ThreeDSensorCalibration",
    169 : "VideoFrame",
    174 : "ObdiiData",
    177 : "NmeaSentence",
    178 : "AviationAttitude",
    184 : "Video",
    185 : "VideoTitle",
    186 : "VideoDescription",
    187 : "VideoClip",
    188 : "OhrSettings",
    200 : "ExdScreenConfiguration",
    201 : "ExdDataFieldConfiguration",
    202 : "ExdDataConceptConfiguration",
    206 : "FieldDescription",
    207 : "DeveloperDataId",
    208 : "MagnetometerData",
    209 : "BarometerData",
    210 : "OneDSensorCalibration",
    225 : "Set",
    227 : "StressLevel",
    258 : "DiveSettings",
    259 : "DiveGas",
    262 : "DiveAlarm",
    264 : "ExerciseTitle",
    268 : "DiveSummary",
    285 : "Jump",
    317 : "ClimbPro",
]
func toText(_ mesgNum:  FITMesgNum) -> String {
    return mesgNums[mesgNum] ?? "unknown (\(mesgNum))"
}