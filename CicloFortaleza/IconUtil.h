//
//  IconUtil.h
//  CicloFortaleza
//
//  Created by Allan on 29/06/17.
//  Copyright © 2017 Allan Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconUtil : NSObject

typedef NS_ENUM(NSInteger, MarkerTypeIcon) {
    BICICLETARIO,
    OFICINA_LOJA,
    ESTACAO_COMPARTILHADA,
    BORRACHARIA,
    DEFAULT
};

+(MarkerTypeIcon)parserStringToMarkerTypeIcon:(NSString *)title;

+(NSString *)realTitle:(NSString *)title;

@end
