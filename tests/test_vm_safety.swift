import Foundation

@main
struct VMSafetyTests {
    static func main() {
        let ample: Int64 = 90 << 30
        let constrained = GuestRAMPlan(requestedMB: 4096, availableStorageBytes: ample, largestMappingMB: 2048)
        precondition(constrained.ramMB == 1536 && constrained.limitation(minimumMB: 2048) == .addressSpace)
        let released = GuestRAMPlan(requestedMB: 4096, availableStorageBytes: ample, largestMappingMB: 16896)
        precondition(released.ramMB == 4096 && released.limitation(minimumMB: 2048) == nil)
        let full = GuestRAMPlan(requestedMB: 4096, availableStorageBytes: 0, largestMappingMB: 16896)
        precondition(full.ramMB == 0 && full.limitation(minimumMB: 2048) == .storage)
        let unknown = GuestRAMPlan(requestedMB: 4096, availableStorageBytes: nil, largestMappingMB: 16896)
        precondition(unknown.ramMB == 4096)
        let invalid = GuestRAMPlan(requestedMB: -1, availableStorageBytes: ample, largestMappingMB: 16896)
        precondition(invalid.ramMB == 0 && invalid.limitation(minimumMB: 1024) == .requested)
        let vm = ResumeIdentityKey.make(reportHost: false, reportModel: false, name: "A", chip: nil, modelID: "a")
        let host = ResumeIdentityKey.make(reportHost: true, reportModel: false, name: "A", chip: "M5", modelID: "a")
        let model = ResumeIdentityKey.make(reportHost: true, reportModel: true, name: "A", chip: "M5", modelID: "a")
        precondition(vm != host && host != model)
        precondition(model != ResumeIdentityKey.make(reportHost: true, reportModel: true, name: "A", chip: "M5", modelID: "b"))
        precondition(vm == ResumeIdentityKey.make(reportHost: false, reportModel: true, name: "B", chip: "M4", modelID: "b"))
        print("VM safety checks passed")
    }
}
