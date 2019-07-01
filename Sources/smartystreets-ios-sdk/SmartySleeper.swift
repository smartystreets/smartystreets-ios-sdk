import Foundation

class SmartySleeper {
    func sleep(seconds: Int) {
        let time = UInt32(seconds)
        Darwin.sleep(time)
    }
}
