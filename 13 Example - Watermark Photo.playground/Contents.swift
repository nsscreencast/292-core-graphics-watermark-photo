import UIKit

let scale: CGFloat = 2
let bounds = CGRect(x: 0, y: 0, width: 320, height: 320)
let colorSpace = CGColorSpaceCreateDeviceRGB()
let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue

let context = CGContext(
	data: nil,
	width: Int(bounds.width * scale),
	height: Int(bounds.height * scale),
	bitsPerComponent: 8,
	bytesPerRow: 0,
	space: colorSpace,
	bitmapInfo: bitmapInfo
)!

// Apply scale
context.scaleBy(x: scale, y: scale)

// Draw image
context.draw(#imageLiteral(resourceName: "San-Francisco@2x.png").cgImage!, in: bounds)

// Invert Y axis
context.translateBy(x: bounds.midX, y: bounds.midY)
context.scaleBy(x: 1, y: -1)
context.translateBy(x: -bounds.midX, y: -bounds.midY)

// Draw text
let string = "San Francisco" as NSString
let stringRect = CGRect(x: 4, y: bounds.height - 24, width: bounds.width - 8, height: 20)
UIGraphicsPushContext(context)
string.draw(in: stringRect, withAttributes: [
	NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5),
	NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
])
UIGraphicsPopContext()

let cgImage = context.makeImage()!
let image = UIImage(cgImage: cgImage, scale: scale, orientation: .up)

let data = UIImagePNGRepresentation(image)
FileManager.default.createFile(atPath: "foo@2x.png", contents: data, attributes: nil)








