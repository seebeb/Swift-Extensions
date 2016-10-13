//
//  SwiftyBeaver+Ex.swift
//
//  Created by Augus on 9/13/16.
//  Copyright © 2016 iAugus. All rights reserved.
//

#if DEBUG

    import SwiftyBeaver

    public let log = SwiftyBeaver.self

    public extension SwiftyBeaver {

        static func setup() {

            // add log destinations. at least one is needed!

            let console = ConsoleDestination()

            // ⚫️🔴🔵⚪️🎾🌕🌎
            console.levelColor.verbose = "⚪️ "
            console.levelColor.debug = "🎾 "
            console.levelColor.info = "🔵 "
            console.levelColor.warning = "🌕 "
            console.levelColor.error = "🔴 "

            // log to Xcode Console
            log.addDestination(console)

            // colors

            //        let file = FileDestination()  // log to default swiftybeaver.log file
            //        let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123") // to cloud
            //        log.addDestination(file)
            //        log.addDestination(cloud)
            //
            //        // Now let’s log!
            //        log.verbose("not so important")  // prio 1, VERBOSE in silver
            //        log.debug("something to debug")  // prio 2, DEBUG in green
            //        log.info("a nice information")   // prio 3, INFO in blue
            //        log.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
            //        log.error("ouch, an error did occur!")  // prio 5, ERROR in red
            
        }
    }

#else

    struct SwiftyBeaver {
        static func setup() {}
    }

    public struct log {
        static func verbose(_ log: Any?) {}
        static func debug(_ log: Any?) {}
        static func info(_ log: Any?) {}
        static func warning(_ log: Any?) {}
        static func error(_ log: Any?) {}
    }
#endif
