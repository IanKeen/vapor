import HTTP
import Routing

@_exported import HTTPRouting
@_exported import TypeSafeRouting

extension Droplet: RouteBuilder {
    public typealias Value = Responder

    public func add(
        path: [String],
        value: Value
    ) {
        router.add(path: path, value: value)
    }
}

extension RouteBuilder where Value == Responder {
    public func group(_ middleware: Middleware ..., closure: (RouteGroup<Value, Self>) ->()) {
        group(prefix: ["*", "*"], path: [], map: { handler in
            return Request.Handler { request in
                return try middleware.chain(to: handler).respond(to: request)
            }
        }, closure: closure)
    }
}
