import Foundation

/// Keep guest memory sizing consistent for installation and boot.
struct GuestRAMPlan {
    enum Limit: Equatable { case storage, addressSpace, requested }
    let storageRoomMB: UInt64
    let addressRoomMB: UInt64
    let ramMB: UInt64

    init(requestedMB: Int, availableStorageBytes: Int64?, largestMappingMB: UInt64) {
        let reserve: Int64 = 2 << 30
        if let free = availableStorageBytes {
            storageRoomMB = free > reserve ? UInt64(free - reserve) >> 20 : 0
        } else {
            // Unknown capacity is not the same as zero available bytes.
            storageRoomMB = .max
        }
        addressRoomMB = largestMappingMB > 512 ? largestMappingMB - 512 : 0
        ramMB = min(UInt64(max(requestedMB, 0)), storageRoomMB, addressRoomMB) / 512 * 512
    }

    func limitation(minimumMB: UInt64) -> Limit? {
        guard ramMB < minimumMB else { return nil }
        if storageRoomMB < minimumMB { return .storage }
        if addressRoomMB < minimumMB { return .addressSpace }
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
