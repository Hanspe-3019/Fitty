//
//  main.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 10.12.21.
//

import Foundation

import ArgumentParser

struct decode: ParsableCommand {
    @Flag(help: "turn on some statistics" )
    var verbose = false
    
    @Argument(help: "One or more pathes to FIT file")
    var pathes: [String]
    
    static let commandName = URL(fileURLWithPath: CommandLine.arguments[0]).lastPathComponent
    static let configuration = CommandConfiguration(
        commandName: commandName,
        abstract: "Extract Heart rates from FIT Files",
        discussion: """
This tool uses the FitSDK to parse FIT files for heart rates.
File types supported are Activity and Monitoring.

Heart rates are written to stdout as text lines with
- Filetype REC or MON
- localized timestamp, e.g. german dd.MM.yyyy, hh:mm:ss
- Heart rate in bpm
The fields are separated by tab.
"""
    )
    
    mutating func validate() throws {

        guard !pathes.isEmpty else {
            throw ValidationError("Please provide at least one element to choose from.")
        }
        for path in pathes {
            var isDirectory : ObjCBool = false
            if FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory) {
                guard !isDirectory.boolValue else {
                    throw ValidationError("\(path) is a directory")
                }
                
            } else {
                throw ValidationError("File \(path) does not exist")
            }
        }
    }

    func run() throws {
        let decoder = DecodeWithBroadcaster(verbose: verbose)
        for the_path in pathes {
            guard try decoder.decode(the_path) else {
                throw ValidationError("Error while decoding")
            }
        }
    }
}
/* main */
decode.main()
