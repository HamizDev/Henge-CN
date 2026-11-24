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
        // Physical RAM limits protect smaller phones and tablets, without changing the stored request.
        precondition(VMPerformancePolicy.guestCapMB(physicalMB: 6200, enabled: true) == 2048)
        precondition(VMPerformancePolicy.guestCapMB(physicalMB: 8000, enabled: true) == 3072)
        precondition(VMPerformancePolicy.guestCapMB(physicalMB: 12000, enabled: true) == .max)
        precondition(VMPerformancePolicy.guestCapMB(physicalMB: 8000, enabled: false) == .max)
        let capped = GuestRAMPlan(requestedMB: 6144, availableStorageBytes: ample, largestMappingMB: 16896, physicalCapMB: 3072)
        precondition(capped.ramMB == 3072 && capped.limitation(minimumMB: 4096) == .physicalMemory)
        precondition(capped.limitation(minimumMB: 2048) == nil)
        precondition(VMPerformancePolicy.defaultCacheMB(physicalMB: 8000, limitMB: 8000) == 1024)
        precondition(VMPerformancePolicy.defaultCacheMB(physicalMB: 12000, limitMB: 6200) == 1536)
        precondition(VMPerformancePolicy.defaultCacheMB(physicalMB: 6000, limitMB: 3200) == 512)
        precondition(VMPerformancePolicy.tlbOptions(sleepWait: false, batchDrop: false) == ["HV_SYNC_WAIT": "0", "HV_RANGE_DROP": "0"])
        precondition(VMPerformancePolicy.tlbOptions(sleepWait: true, batchDrop: false) == ["HV_SYNC_WAIT": "1", "HV_RANGE_DROP": "0"])
        precondition(VMPerformancePolicy.tlbOptions(sleepWait: false, batchDrop: true) == ["HV_SYNC_WAIT": "0", "HV_RANGE_DROP": "256"])
        precondition(VMPerformancePolicy.tlbOptions(sleepWait: true, batchDrop: true) == ["HV_SYNC_WAIT": "1", "HV_RANGE_DROP": "256"])
        print("VM safety and performance policy checks passed")
    }
}
