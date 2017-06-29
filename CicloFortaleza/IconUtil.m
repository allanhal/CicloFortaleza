//
//  IconUtil.m
//  CicloFortaleza
//
//  Created by Allan on 29/06/17.
//  Copyright © 2017 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IconUtil.h"

@implementation IconUtil

+(MarkerTypeIcon)parserStringToMarkerTypeIcon:(NSString *)title;
{
    if ([title rangeOfString:@"#icon-1033"].location != NSNotFound)
        return OFICINA_LOJA;
    
    if([title rangeOfString:@"#icon-1143"].location != NSNotFound ||
       [title rangeOfString:@"#icon-503-DB4436"].location != NSNotFound)
        return BORRACHARIA;
    
    if([title rangeOfString:@"#icon-1419"].location != NSNotFound)
        return BICICLETARIO;
    
    if([title rangeOfString:@"#icon-ci-1"].location != NSNotFound ||
       [title rangeOfString:@"#icon-ci-2"].location != NSNotFound)
        return ESTACAO_COMPARTILHADA;
    
    if([title rangeOfString:@"#line-0BA9CC-5263"].location != NSNotFound ||
       [title rangeOfString:@"#poly-0BA9CC-1001-232"].location != NSNotFound ||
       [title rangeOfString:@"#line-DB4436-4875"].location != NSNotFound ||
       [title rangeOfString:@"#line-009D57-3519"].location != NSNotFound)
        return DEFAULT;

    return DEFAULT;
}

+(NSString *)realTitle:(NSString *)title
{
    NSString *toReturn = title;
    NSString *separator = @"<>";

    if([title rangeOfString:separator].location != NSNotFound){
        NSRange range = [toReturn rangeOfString:separator];
        toReturn = [toReturn substringFromIndex:(range.length+range.location)];
    }
    return toReturn;
}


@end
