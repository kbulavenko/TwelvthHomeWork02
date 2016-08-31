//
//  MyArray.h
//  TwelvthHomeWork01
//
//  Created by  Z on 26.08.16.
//  Copyright © 2016 ItStep. All rights reserved.
//


/*
 
 
 BOOL    isRun   = true;
 while(isRun)
 {
 NSLog(@"1 - Добавить человека");
 NSLog(@"2 - Найти человека");
 NSLog(@"3 - Удалить человека по номеру в списке");
 NSLog(@"4 - Вывести список людей");
 NSLog(@"5 - Выход");
 */


#import <Foundation/Foundation.h>
struct Human
{
    char    lastname[32];
    char    firstname[32];
    int     age;
    BOOL    gender;
};

@interface MyArray : NSObject
{
    struct Human    *p;
    int             size;
    int             bufSize;
//    const int       bufStep;   // Если объявить константу здесь, то она будет иметь нулевое значение
}

@property (readwrite, nonatomic) int size;
@property (readwrite, nonatomic) int bufSize;
@property (readwrite, nonatomic) struct Human *p;


// Методы

- (instancetype)init;
- (void)        dealloc;
- (void)        addHuman       :   (struct Human) oneHuman;//- добавление человека в список людей
- (int) findHumanIndex     :   (struct Human) H;       //- Поиск индекса человека (вспомогательный метод)
- (BOOL)        containsHuman  :   (struct Human) H; //- поиск человека
- (void)        removeHuman    :   (struct Human) oneHuman; //- удаление человека
- (void)        removeHumanByIndex    :   (int) humansIndex; //- удаление человека по индексу

- (void)        showHumans;                                 //- вывод списка людей на экран


@end
