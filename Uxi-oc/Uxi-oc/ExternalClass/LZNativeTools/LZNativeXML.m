//
//  LZNativeXML.m
//  Uxi-oc
//
//  Created by jecansoft on 16/9/8.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import "LZNativeXML.h"

@interface LZNativeXML()<NSXMLParserDelegate>


@end

@implementation LZNativeXML

+ (instancetype)nativeXMLData:(NSData *)data{
    return [[LZNativeXML alloc]initWithNativeXMLData:data];
}


- (instancetype)initWithNativeXMLData:(NSData *)data{
    self = [super init];
    if (self) {
        
        [self creatXMLParserData:data];
        
    }
    return self;
}


- (void)creatXMLParserData:(NSData *)data{
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    
}

#pragma mark - delegate
/*  解析到某个元素的开头 （<head>）   */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    
    
    
}

/*   解析到某个元素的结尾 （</head>）  */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
}

/*   开始解析XML  */
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
    
}

/*  解析完毕   */
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    
}






@end



