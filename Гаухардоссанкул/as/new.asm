 .model tiny
    .code
    org 100h
start:
    cld                ;сброс DF, для прямого хода по строкам
    mov    dx,offset prigl        ;адрес строки приглашения
    mov    ah,09h            ;функция вывода строки
    int    21h
    mov    ah,0Ah            ;функция считывания введеной с клавы строки в буфер
    mov    dx,offset stroka    ;адрес буфера
    int    21h
    mov    dx,offset perevod    ;перевод курсора на следующую строку
    mov    ah,09h
    int    21h
    xor    cx,cx
    mov    cl,stroka[1]        ;для выполнения цикла по строке надо считать кол-во символов
    mov    bx,offset stroka    ;установка на начало введеной строки
    add    bx,2            ;следующие три команды
    add    bx,cx            ;переводят на
    dec    bx            ;конец строки
    mov    di,offset nstroka    ;адрес новой строки
l1:
    xor    ax,ax
    mov    al,[bx]            ;считываем элемент строки
    shl    ax,4    ;сдвигаем на 4 разряда влево, теперь в ah старшие 4 бита, в al младшие, но находятся в разрядах 4-7
    or    al,ah            ;теперь в аl разряды переставлены
    stosb                ;загрузка в новую строку
    dec    bx            ;переход к предыдущему символу
    loop    l1            ;цикл по количеству символов
    mov    al,24h            ;в последний символ новой строки вводим $
    stosb                ;загрузка в новую строку
    mov    dx,offset nstroka    ;вывод результата
    mov    ah,09h
    int    21h
    ret
prigl    db    'Enter simbols:','$'
perevod    db    0Dh,0Ah,'$'
stroka    db    0FEh,0FEh dup(?)
nstroka:
end    start
