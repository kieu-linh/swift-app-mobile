import SwiftUI

extension View {
    func fullWidth() -> some View {
        self.frame(maxWidth: .infinity)
    }

    func fullHeight() -> some View {
        self.frame(maxHeight: .infinity)
    }

    func fullSize() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func onTapDismissKeyboard() -> some View {
        self.onTapGesture {
            hideKeyboard()
        }
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
}

struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
