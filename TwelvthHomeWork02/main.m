//
//  main.m
//  TwelvthHomeWork01
//
//  Created by  Z on 26.08.16.
//  Copyright © 2016 ItStep. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyArray.h"

struct Human  makeHuman()
{
    struct Human oneHuman;
    printf("Введите имя :");
    scanf("%s",oneHuman.lastname);
    //scanf("%*c");
    printf("Введите фамилию :");
    scanf("%s",oneHuman.firstname);
    printf("Введите возраст :");
    scanf("%i",&oneHuman.age);
    do
    {
    printf("Введите пол (1 - мужской, 0- женский ) :");
    scanf("%i",&oneHuman.gender);
    }while(!(oneHuman.gender == 1 || oneHuman.gender == 0) );
    return oneHuman;
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BOOL    isRun   = true;
        MyArray *A = [[MyArray alloc] init];
       // MyArray *B = [[MyArray alloc] init];
        while(isRun)
        {
            NSLog(@"1 - Добавить человека");
            NSLog(@"2 - Найти человека");
            NSLog(@"3 - Удалить человека по номеру в списке");
            NSLog(@"4 - Вывести список людей");
            
            NSLog(@"5 - Выход");
            NSLog(@"Дополнительные функции:");
            NSLog(@"6 - Записать данные в файл.");
            NSLog(@"7 - Считать данные из файла в память.");
            //NSLog(@"8 - Записать данные в базу данных MySQL");
            //NSLog(@"9 - Считать данные из базы MySQL");
            
            int     a;
            scanf("%i",&a);
            
            switch (a)
            {
                case 1:
                {
                    
                    struct	Human	N	= makeHuman();
                    [A addHuman : N];
                    break;
                }
                    
                case 2 :
                {
                    struct Human	N	= makeHuman();
                    if ( [A containsHuman : N])
                    {
                        NSLog(@"Есть такой человек. Номер в базе %i", [A findHumanIndex:N]);
                    }
                    else
                    {
                        NSLog(@"Нет такого человека");
                    }
                    break;
                }
                case 3:
                {
                    //struct Human	N	= makeHuman();
                    [A showHumans];
                    int humansIndex;
                    
                    printf("Введите номер человека для удаления из базы (0 - %i) :", ((A.size-1)<0?0:(A.size-1)) );
                    scanf("%i", &humansIndex);
                    if(A.size > 0)
                    {
                        [A removeHumanByIndex:humansIndex];
                    }
                    else
                    {
                        printf("Нет данных для удаления. \n");
                    }
                    break;
                }
                case 4:
                {
                    [A showHumans];
                    break;
                }
                case 5:
                {
                    //printf("%i");
                    isRun = false;
                    break;
                }
                case 6:
                {
                    FILE *fileDescriptor = NULL;
                    //char path[200] = "~/Documents/";
                    char fullPath[255] = "/Users/";
                    char fileName[155];
                    printf("Введите имя файла /Users/");
                    scanf("%s",fileName);
                    strcat(fullPath, fileName);
                    NSLog(@"%s",fullPath);
                    fileDescriptor = fopen(fullPath, "w");
                    
                    if(fileDescriptor == NULL)
                    {
                        
                        printf("%s",fullPath);
                        perror("Ошибка при открытии ");
                        
                        return EXIT_FAILURE;
                        //NSLog(@"Ошибка открытия файла");
                        //exit(-1);
                    }
                    else
                    {
                        unsigned long magicNumber = 123434567654321; // Это просто метка для файла, это не магическое число ))
                        unsigned long fwriteRet;
                        fwriteRet = fwrite(&magicNumber, sizeof(unsigned long), 1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        int size1 = [A size];
                        fwriteRet = fwrite(&size1, sizeof(size1), 1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        fwriteRet = fwrite(&magicNumber, sizeof(unsigned long), 1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        struct Human *p2 = A.p;
                        fwriteRet = fwrite(p2, sizeof(struct Human), size1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        
                        fclose(fileDescriptor);
                        
                    }
                    
                    break;
                }
                case 7:
                {
                    FILE *fileDescriptor = NULL;
                    //char path[200] = "~/Documents/";
                    char fullPath[255] = "/Users/";
                    char fileName[55];
                    printf("Введите имя файла /Users/");
                    scanf("%s",fileName);
                    strcat(fullPath, fileName);
                    NSLog(@"%s",fullPath);
                    fileDescriptor = fopen(fullPath, "r");
                    
                    if(fileDescriptor == NULL)
                    {
                        
                        printf("%s",fullPath);
                        perror("Ошибка при открытии ");
                        
                        return EXIT_FAILURE;
                        //NSLog(@"Ошибка открытия файла");
                        //exit(-1);
                    }
                    else
                    {
                        unsigned long magicNumber = 123434567654321, magicTest;
                        unsigned long freadRet;
                        //fread(<#void *restrict#>, <#size_t#>, <#size_t#>, <#FILE *restrict#>)
                        freadRet = fread(&magicTest, sizeof(unsigned long), 1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        if(magicNumber != magicTest)
                        {
                            NSLog(@"Вы выбрали неправильный файл: %s\n",fullPath);
                            break;
                        }
                        int size1; //= [A size];
                        freadRet = fread(&size1, sizeof(size1), 1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        if(size1 < 0)
                        {
                            NSLog(@"Размер данных %i получен неверно", size1);
                        }
                        freadRet = fread(&magicTest, sizeof(unsigned long), 1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        if(magicNumber != magicTest)
                        {
                            NSLog(@"Вы выбрали неправильный файл: %s\n",fullPath);
                            break;
                        }
                        
                        
                        struct Human *p2 = NULL;
                        p2 = malloc(sizeof(struct Human) * size1);
                        if(p2 == NULL)
                        {
                            NSLog(@"Ошибка выделения памяти!");
                            break;
                        }
                        freadRet = fread(p2, sizeof(struct Human), size1, fileDescriptor);
                        if(ferror(fileDescriptor))
                        {
                            perror(__func__);
                            exit(EXIT_FAILURE);
                        }
                        for(int i = 0; i < size1; i++ )
                        {
                            [A addHuman:p2[i]];
                        }
                        free(p2);
                        fclose(fileDescriptor);
                        
                    }
                    
                    break;
                }
                    
                default:
                    break;
            }
        }
        
    }
    return 0;
}
