/* ********************************************************************* 
                  _____         _               _
                 |_   _|____  _| |_ _   _  __ _| |
                   | |/ _ \ \/ / __| | | |/ _` | |
                   | |  __/>  <| |_| |_| | (_| | |
                   |_|\___/_/\_\\__|\__,_|\__,_|_|

 Copyright (c) 2008 - 2010 Satoshi Nakagawa <psychs AT limechat DOT net>
 Copyright (c) 2010 — 2014 Codeux Software, LLC & respective contributors.
        Please see Acknowledgements.pdf for additional information.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Textual and/or "Codeux Software, LLC", nor the 
      names of its contributors may be used to endorse or promote products 
      derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 SUCH DAMAGE.

 *********************************************************************** */

#import "TextualApplication.h"

@implementation TVCBasicTableView

#pragma mark -
#pragma mark Table View

- (NSInteger)countSelectedRows
{
	return [[self selectedRowIndexes] count];
}

- (NSArray *)selectedRows
{
    NSMutableArray *allRows = [NSMutableArray array];
    
    NSIndexSet *indexes = [self selectedRowIndexes];
	
	for (NSNumber *index in [indexes arrayFromIndexSet]) {
		[allRows addObject:index];
	}
    
    return allRows;
}

- (void)selectItemAtIndex:(NSInteger)index
{
	[self selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
	
	[self scrollRowToVisible:index];
}

- (void)selectRows:(NSArray *)indices
{
	[self selectRows:indices extendSelection:NO];
}

- (void)selectRows:(NSArray *)indices extendSelection:(BOOL)extend
{
	NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
	
	for (NSNumber *n in indices) {
		[set addIndex:[n integerValue]];
	}
	
	[self selectRowIndexes:set byExtendingSelection:extend];
}

- (void)rightMouseDown:(NSEvent *)e
{
	NSPoint p = [self convertPoint:e.locationInWindow fromView:nil];
	
	NSInteger i = [self rowAtPoint:p];
	
	if (i >= 0) {
		if ([[self selectedRowIndexes] containsIndex:i] == NO) {
			[self selectItemAtIndex:i];
		}
	}
	
	[super rightMouseDown:e];
}

- (void)textDidEndEditing:(NSNotification *)note
{
	if ([self.textEditingDelegate respondsToSelector:@selector(textDidEndEditing:)]) {
		[self.textEditingDelegate textDidEndEditing:note];
	} else {
		[super textDidEndEditing:note];
	}
}

@end
