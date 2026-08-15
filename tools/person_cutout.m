#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Vision/Vision.h>
#import <CoreImage/CoreImage.h>
#import <CoreVideo/CoreVideo.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc != 3) {
            NSLog(@"Usage: person_cutout <input> <output>");
            return 2;
        }

        NSString *inputPath = [NSString stringWithUTF8String:argv[1]];
        NSString *outputPath = [NSString stringWithUTF8String:argv[2]];
        NSImage *source = [[NSImage alloc] initWithContentsOfFile:inputPath];
        if (!source) {
            NSLog(@"Could not open input image");
            return 3;
        }

        NSRect proposedRect = NSMakeRect(0, 0, source.size.width, source.size.height);
        CGImageRef sourceCG = [source CGImageForProposedRect:&proposedRect context:nil hints:nil];
        if (!sourceCG) {
            NSLog(@"Could not decode input image");
            return 4;
        }

        VNGenerateForegroundInstanceMaskRequest *request = [[VNGenerateForegroundInstanceMaskRequest alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        request.usesCPUOnly = YES;
#pragma clang diagnostic pop

        VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:sourceCG options:@{}];
        NSError *error = nil;
        if (![handler performRequests:@[request] error:&error]) {
            NSLog(@"Segmentation failed: %@", error);
            return 5;
        }

        VNInstanceMaskObservation *observation = request.results.firstObject;
        if (!observation) {
            NSLog(@"No person mask was produced");
            return 6;
        }

        CVPixelBufferRef maskedBuffer = [observation
            generateMaskedImageOfInstances:observation.allInstances
            fromRequestHandler:handler
            croppedToInstancesExtent:NO
            error:&error];
        if (!maskedBuffer) {
            NSLog(@"Could not create cutout: %@", error);
            return 7;
        }
        CIImage *cutout = [CIImage imageWithCVPixelBuffer:maskedBuffer];

        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer: @NO}];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceSRGB);
        NSURL *outputURL = [NSURL fileURLWithPath:outputPath];
        BOOL wrote = [context writePNGRepresentationOfImage:cutout
                                                      toURL:outputURL
                                                      format:kCIFormatRGBA8
                                                  colorSpace:colorSpace
                                                     options:@{}
                                                       error:&error];
        CGColorSpaceRelease(colorSpace);
        CVPixelBufferRelease(maskedBuffer);
        if (!wrote) {
            NSLog(@"Could not write output: %@", error);
            return 8;
        }
    }
    return 0;
}
