//
// VTAcknowledgementsParserTests.m
//
// Copyright (c) 2013-2018 Vincent Tourraine (http://www.vtourraine.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import Foundation;
@import XCTest;

#import <VTAcknowledgementsParser.h>
#import <VTAcknowledgement.h>

@interface VTAcknowledgementsParserTests : XCTestCase

@end


@implementation VTAcknowledgementsParserTests

- (void)testDoesNotSupportDefaultInitialization {
    XCTAssertThrows([VTAcknowledgementsParser new]);
}

- (void)testBasicParsing {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Pods-acknowledgements" ofType:@"plist"];
    VTAcknowledgementsParser *parser = [[VTAcknowledgementsParser alloc] initWithAcknowledgementsPlistPath:path];

    XCTAssertEqualObjects(parser.header, @"This application makes use of the following third party libraries:");
    XCTAssertEqualObjects(parser.footer, @"Generated by CocoaPods - http://cocoapods.org");

    XCTAssertEqual(parser.acknowledgements.count, 1);

    VTAcknowledgement *acknowledgement = parser.acknowledgements.firstObject;
    XCTAssertEqualObjects(acknowledgement.title, @"VTAcknowledgementsViewController");
    XCTAssertTrue([acknowledgement.text hasPrefix:@"Copyright (c) 2013-2016 Vincent Tourraine (http://www.vtourraine.net)"]);
}

- (void)testParsingFailure {
    VTAcknowledgementsParser *parser = [[VTAcknowledgementsParser alloc] initWithAcknowledgementsPlistPath:@""];

    XCTAssertNil(parser.header);
    XCTAssertNil(parser.footer);
    XCTAssertNil(parser.acknowledgements);
}

@end
