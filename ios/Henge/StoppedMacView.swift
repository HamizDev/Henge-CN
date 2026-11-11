import SwiftUI

/// Terminal state after the engine has released the previous guest.
struct StoppedMacView: View {
    let outcome: Int32
    let reason: String
    var start: (() -> Void)? = nil
    let close: () -> Void

    private var title: String {
        switch outcome {
        case Int32(HENGE_VM_OUTCOME_SHUTDOWN.rawValue): return NSLocalizedString("Mac shut down", comment: "虚拟机结束状态")
        case Int32(HENGE_VM_OUTCOME_RESTART.rawValue): return NSLocalizedString("Mac requested a restart", comment: "虚拟机结束状态")
        case Int32(HENGE_VM_OUTCOME_HOST_STOP.rawValue): return NSLocalizedString("Mac stopped", comment: "虚拟机结束状态")
        default: return NSLocalizedString("Mac stopped unexpectedly", comment: "虚拟机结束状态")
        }
    }

    private var detail: String {
        let next = NSLocalizedString("You can start this Mac again or return to your Macs.", comment: "虚拟机结束后操作")
        switch outcome {
        case Int32(HENGE_VM_OUTCOME_SHUTDOWN.rawValue), Int32(HENGE_VM_OUTCOME_HOST_STOP.rawValue): return next
        case Int32(HENGE_VM_OUTCOME_RESTART.rawValue): return NSLocalizedString("The Mac is ready to start again.", comment: "虚拟机重新启动")
        default: return String(format: NSLocalizedString("The Mac stopped: %@. %@", comment: "虚拟机异常终止"), reason, next)
        }
    }

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "power").font(.system(size: 30))
            Text(title).font(.headline)
            Text(detail).font(.subheadline).foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
            if let start { Button("Start Mac", action: start).buttonStyle(.borderedProminent) }
            Button("Close", action: close).buttonStyle(.bordered)
        }
        .foregroundStyle(.white)
        .padding(24)
        .frame(maxWidth: 360)
        .background(Color(white: 0.10), in: RoundedRectangle(cornerRadius: 22))
        .accessibilityIdentifier("stopped-mac")
    }
}
