import Foundation

/// Keep guest memory sizing consistent for installation and boot.
struct GuestRAMPlan {
    enum Limit: Equatable { case storage, addressSpace, physicalMemory, requested }
    let storageRoomMB: UInt64
    let addressRoomMB: UInt64
    let physicalCapMB: UInt64
    let ramMB: UInt64

    init(requestedMB: Int, availableStorageBytes: Int64?, largestMappingMB: UInt64, physicalCapMB: UInt64 = .max) {
        let reserve: Int64 = 2 << 30
        if let free = availableStorageBytes {
            storageRoomMB = free > reserve ? UInt64(free - reserve) >> 20 : 0
        } else {
            // Unknown capacity is not the same as zero available bytes.
            storageRoomMB = .max
        }
        addressRoomMB = largestMappingMB > 512 ? largestMappingMB - 512 : 0
        self.physicalCapMB = physicalCapMB
        ramMB = min(UInt64(max(requestedMB, 0)), storageRoomMB, addressRoomMB, physicalCapMB) / 512 * 512
    }

    func limitation(minimumMB: UInt64) -> Limit? {
        guard ramMB < minimumMB else { return nil }
        if storageRoomMB < minimumMB { return .storage }
        if addressRoomMB < minimumMB { return .addressSpace }
        if physicalCapMB < minimumMB { return .physicalMemory }
        return .requested
    }
}

/// Match the actual reported guest identity, not merely its RAM and display size.
enum ResumeIdentityKey {
    static func make(reportHost: Bool, reportModel: Bool, name: String, chip: String?, modelID: String) -> String {
        func field(_ value: String?) -> String {
            guard let value else { return "-" }
            return "\(value.utf8.count):\(value)"
        }
        guard reportHost else { return "identity-v1:virtual" }
        return "identity-v1:host|" + field(name) + "|" + field(chip) + "|" + field(reportModel ? modelID : nil)
    }
}

/// Conservative physical-memory recommendations from upstream PR #214.
/// A manual cache selection remains supported. The guest RAM cap can be disabled explicitly.
enum VMPerformancePolicy {
    static let memoryProtectionKey = "henge.perf.memoryProtection"

    static func guestCapMB(physicalMB: UInt64, enabled: Bool) -> UInt64 {
        guard enabled else { return .max }
        if physicalMB <= 6700 { return 2048 }
        if physicalMB <= 8700 { return 3072 }
        return .max
    }

    static func defaultCacheMB(physicalMB: UInt64, limitMB: UInt64) -> Int {
        if limitMB < 3500 { return 512 }
        if limitMB >= 5500 && physicalMB > 9 * 1024 { return 1536 }
        return 1024
    }

    /// These are pre-existing engine knobs. The defaults remain off for the experimental paths.
    static func tlbOptions(sleepWait: Bool, batchDrop: Bool) -> [String: String] {
        ["HV_SYNC_WAIT": sleepWait ? "1" : "0", "HV_RANGE_DROP": batchDrop ? "256" : "0"]
    }
}
