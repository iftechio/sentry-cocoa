import Sentry
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static let defaultDSN = "https://a92d50327ac74b8b9aa4ea80eccfb267@o447951.ingest.sentry.io/5428557"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // For testing purposes, we want to be able to change the DSN and store it to disk. In a real app, you shouldn't need this behavior.
        let dsn = DSNStorage.shared.getDSN() ?? AppDelegate.defaultDSN
        DSNStorage.shared.saveDSN(dsn: dsn)
        
        SentrySDK.start { options in
            options.dsn = dsn
            options.beforeSend = { event in
                return event
            }
            options.debug = true
            // Sampling 100% - In Production you probably want to adjust this
            options.tracesSampleRate = 1.0
            options.sessionTrackingIntervalMillis = 5_000
            options.enableFileIOTracking = true
            options.enableCoreDataTracking = true
            options.enableProfiling = true
        }
        
        return true
    }
}
