//
//  MyArray.m
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

#import "MyArray.h"

@implementation MyArray
@synthesize size;
@synthesize p;
@synthesize bufSize;

const int bufStep = 32;   // Шаг изменения буфера

- (void) addBuf      // Нарастить буфер
{
    struct Human    *p2;
    self->bufSize += bufStep;
    p2      = malloc(sizeof(struct Human) * self->bufSize);
    for (int i =0; i < self->size ; i++)
    {
        p2[i]   = self->p[i];
    }
    free(self->p);
    self->p = p2;
    p2      = NULL;
}

- (void) reduceBuf   // Проверить размер данных, если их мало, урезать буфер
{
    if(self->bufSize > bufStep && (self->bufSize - self->size) > bufStep*2-2)  // Если буфер больше минимального и количество значений меньше на два шага изменения буфера без двух
    {
        self->bufSize          -= bufStep;
        struct Human    *p2     = malloc(sizeof(struct Human) * self->bufSize);
        for (int i =0; i < self->size ; i++)
        {
            p2[i]   = self->p[i];
        }
        free(self->p);
        self->p = p2;
        p2      = NULL;
    }
}

- (instancetype)init
{
    self = [super init];
    if(self != nil)
    {
        self->size  = 0;
        self->bufSize     = bufStep;
        self->p     = malloc(sizeof(struct Human) * bufSize);
    }
    return self;
}
- (void)        dealloc;
{
    free(self->p);
    self->p     = NULL;
    self->size  = 0;
}

- (void) addHuman      :   (struct Human) oneHuman
{
    if( (self->size + 1)  > self->bufSize)
    {
        [self addBuf];
    }
    self->p[self->size++] = oneHuman;  // Присвоили структуру с данными нового человека в конце и добавили размеру данных единицу
}

- (int) findHumanIndex  :   (struct Human) H //- поиск индекса человека
{
    for(int i = 0; i < self->size; i++)
    {
        if(!strcmp(self->p[i].lastname, H.lastname) && !strcmp(self->p[i].firstname, H.firstname) && self->p[i].age == H.age && self->p[i].gender == H.gender )
        {
            return i;
        }
    }
    return -1;
}


- (BOOL) containsHuman  :   (struct Human) H //- поиск человека
{
    return ([self findHumanIndex:H] != -1);
}

- (void) removeHuman    :   (struct Human) oneHuman; //- удаление человека
{
    int humansIndex = [self findHumanIndex:oneHuman];
    if(humansIndex != -1)
    {
        for(int i = humansIndex; i <self->size -1 ; i++)
        {
            self->p[i] = p[i+1];
        }
        self->size--;
        [self reduceBuf];
    }
    
}
- (void)        removeHumanByIndex    :   (int) humansIndex; //- удаление человека по индексу
{
    if(humansIndex >= 0 && humansIndex < self->size)
    {
        for(int i = humansIndex; i <self->size -1 ; i++)
        {
            self->p[i] = self->p[i+1];
        }
        self->size--;
        [self reduceBuf];

    }
    else
    {
        printf("\n *** Индекс %i выходит за рамки 0 - %i\n", humansIndex, self->size);
    }
}

- (void) showHumans;
{
    for(int i = 0; i < self->size; i++)
    {
        printf("Запись № %i:  ",i);
        printf("Имя: %s ", p[i].lastname );
        printf("Фамилия: %s, ", p[i].firstname );
        printf("возраст: %i, ", p[i].age );
        printf("Пол: %s.", ((p[i].gender)?"Мужской":"Женский"));
        
        printf("\n");
        
    }
    printf("Конец базы! Обнаружено %i записей.\n", self->size);
}
@end
