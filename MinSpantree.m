//
//  main.m
//  MinSpantree
//
//  Created by Carl Friess on 10/05/2017.
//  Copyright © 2017 Carl Friess. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Scanner : NSObject
{
    NSFileHandle* source;
    NSScanner* buffer;
}

- (int)nextInt;

@end

@implementation Scanner

- (instancetype)init
{
    self = [super init];
    if (self) {
        source = [NSFileHandle fileHandleWithStandardInput];
    }
    return self;
}

- (int)nextInt
{
    if (buffer == nil || buffer.atEnd) {
        NSString* nextInput = [[NSString alloc] initWithData:source.availableData encoding:NSUTF8StringEncoding];
        if (nextInput != nil) {
            buffer = [[NSScanner alloc] initWithString: nextInput];
        }
    }
    int value = -1;
    [buffer scanInt:&value];
    return value;
}

@end


@interface Vertex : NSObject
{
    int value;
    Vertex* parent;
}

@property Vertex* parent;

- (Vertex*)getRoot;

@end

@implementation Vertex

- (instancetype)initWithValue:(int)defaultValue
{
    self = [super init];
    if (self) {
        value = defaultValue;
        parent = self;
    }
    return self;
}

@synthesize parent;

-(Vertex *)getRoot
{
    
    return parent == self ? self : [parent getRoot];
    
}

@end


@interface Edge : NSObject
{
    Vertex* u;
    Vertex* v;
    int weight;
}

@property Vertex* u;
@property Vertex* v;
@property int weight;

@end

@implementation Edge

@synthesize u;
@synthesize v;
@synthesize weight;

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Scanner* scanner = [[Scanner alloc] init];
        
        for (int numTests = [scanner nextInt]; numTests > 0; numTests--) {
            
            int numVertices = [scanner nextInt];
            int numEdges = [scanner nextInt];
            
            NSMutableArray* vertices = [NSMutableArray arrayWithCapacity:numVertices];
            NSMutableArray* edges = [NSMutableArray arrayWithCapacity:numEdges];
            
            for (int i = 0; i < numVertices; i++) {
                [vertices addObject:[[Vertex alloc]initWithValue:i]];
            }
            
            for (int i = 0; i < numEdges; i++) {
                
                int uValue = [scanner nextInt] - 1;
                int vValue = [scanner nextInt] - 1;
                
                Edge* edge = [[Edge alloc] init];
                
                edge.u = vertices[uValue];
                edge.v = vertices[vValue];
                edge.weight = [scanner nextInt];
                
                [edges addObject:edge];
                
            }
            
            [edges sortUsingComparator:^NSComparisonResult(Edge* first, Edge* second) {
                return first.weight > second.weight;
            }];
            
            int totalWeight = 0;
            
            Edge* edge;
            for (edge in edges) {
                if ([edge.u getRoot] != [edge.v getRoot]) {
                    [edge.v getRoot].parent = [edge.u getRoot];
                    totalWeight += edge.weight;
                }
            }
            
            printf("%d\n", totalWeight);
            
        }
        
    }
    return 0;
}
