import Foundation

extension String {
    func consume<T>(with transform: (String) -> T) -> [T] {
        indices.map { i in
            let sub = String(self[i...])
            return transform(sub)
        }
    }
}
