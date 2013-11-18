//
//  Created by Maciej Oczko on 19/11/13.
//


#import "PLSpecialScoring.h"
#import "PLScoreModifierProtocol.h"


@implementation PLSpecialScoring {

}

- (double)scoreWithQuestions:(NSArray *)questions {
    double score = [super scoreWithQuestions:questions];
    NSArray *correctQuestions = [questions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"answeredCorrectly == YES"]];

    double factor = (double)[correctQuestions count] / (double)[questions count];

    return factor >= 0.5
            ? (self.modifier ? [self.modifier modifyScore:score] : score)
            : score;
}

@end
