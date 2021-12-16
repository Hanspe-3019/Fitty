# Fitty
OVERVIEW: Extract Heart rates from FIT Files

This command line tool uses the [FitSDK](https://developer.garmin.com/fit/overview/) to parse FIT files for heart rates.
File types supported are Activity and Monitoring.

Heart rates are written to stdout as text lines with

- Filetype REC or MON
- localized timestamp, e.g. german dd.MM.yyyy, hh:mm:ss
- Heart rate in bpm

The fields are separated by tab.

The tool also uses [swift-argument-parser](https://github.com/apple/swift-argument-parser.git) as package dependency
