// Unavailable classes like `NSInvocation` can still be passed into Swift as
// `AnyClass` and `AnyObject`, and receive messages as `AnyClass` and
// `AnyObject` existentials.
//
// These `@objc` protocols host the method signatures so that they can be used
// with `AnyObject`.

public let NSInvocation: AnyClass = NSClassFromString("NSInvocation")!
public let NSMethodSignature: AnyClass = NSClassFromString("NSMethodSignature")!

// Signatures defined in `@objc` protocols would be available for ObjC message
// sending via `AnyObject`.
@objc public protocol ObjCClassReporting {
	// An alias for `-class`, which is unavailable in Swift.
	@objc(class)
	var objcClass: AnyClass! { get }

	@objc(methodSignatureForSelector:)
	func objcMethodSignature(for selector: Selector) -> AnyObject
}

// Methods of `NSInvocation`.
@objc public protocol ObjCInvocation {
	@objc(setSelector:)
	func objcSetSelector(_ selector: Selector)

	@objc(methodSignature)
	var objcMethodSignature: AnyObject { get }

	@objc(getArgument:atIndex:)
	func objcCopy(to buffer: UnsafeMutableRawPointer?, forArgumentAt index: Int)

	@objc(invoke)
	func objcInvoke()

	@objc(invocationWithMethodSignature:)
	static func objcInvocation(withMethodSignature signature: AnyObject) -> AnyObject
}

// Methods of `NSMethodSignature`.
@objc public protocol ObjCMethodSignature {
	@objc(numberOfArguments)
	var objcNumberOfArguments: UInt { get }

	@objc(getArgumentTypeAtIndex:)
	func objcArgumentType(at index: UInt) -> UnsafePointer<CChar>

	@objc(signatureWithObjCTypes:)
	static func objcSignature(withObjCTypes typeEncoding: UnsafePointer<Int8>) -> AnyObject
}
