import Foundation
import AppKit
import Vision
import CoreImage
import CoreVideo

guard CommandLine.arguments.count == 3 else {
    fatalError("Usage: person_cutout <input> <output>")
}

let inputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let outputURL = URL(fileURLWithPath: CommandLine.arguments[2])

guard let source = NSImage(contentsOf: inputURL) else {
    fatalError("Could not open input image")
}

var proposedRect = CGRect(origin: .zero, size: source.size)
guard let sourceCG = source.cgImage(forProposedRect: &proposedRect, context: nil, hints: nil) else {
    fatalError("Could not decode input image")
}

let request = VNGeneratePersonSegmentationRequest()
request.qualityLevel = .accurate
request.outputPixelFormat = kCVPixelFormatType_OneComponent8

let handler = VNImageRequestHandler(cgImage: sourceCG, orientation: .up, options: [:])
try handler.perform([request])

guard let observation = request.results?.first else {
    fatalError("No person mask was produced")
}

let maskBuffer = observation.pixelBuffer
let sourceImage = CIImage(cgImage: sourceCG)
let scaleX = CGFloat(sourceCG.width) / CGFloat(CVPixelBufferGetWidth(maskBuffer))
let scaleY = CGFloat(sourceCG.height) / CGFloat(CVPixelBufferGetHeight(maskBuffer))
let maskImage = CIImage(cvPixelBuffer: maskBuffer)
    .transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
    .cropped(to: sourceImage.extent)

let clearImage = CIImage(color: .clear).cropped(to: sourceImage.extent)
let cutout = sourceImage.applyingFilter(
    "CIBlendWithMask",
    parameters: [
        kCIInputBackgroundImageKey: clearImage,
        kCIInputMaskImageKey: maskImage
    ]
)

let context = CIContext(options: [.useSoftwareRenderer: false])
let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
try context.writePNGRepresentation(
    of: cutout,
    to: outputURL,
    format: .RGBA8,
    colorSpace: colorSpace
)
