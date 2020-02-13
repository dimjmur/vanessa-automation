﻿#language: ru
@tree

@IgnoreOnCIMainBuild

Функциональность: ПроверкаИсключенийВшагах01





Сценарий: ПроверкаИсключенийВшагах01 - подготовка.
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

	И В командном интерфейсе я выбираю 'Основная' 'Справочник1'
	Тогда открылось окно 'Справочник1'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Справочник1 (создание)'
	И в поле с именем 'Наименование' я ввожу текст '111'
	И в таблице "ТабличнаяЧасть1" я нажимаю на кнопку с именем 'ТабличнаяЧасть1Добавить'
	И в таблице "ТабличнаяЧасть1" в поле с именем 'ТабличнаяЧасть1РеквизитЧисло' я ввожу текст '111,00'
	И в таблице "ТабличнаяЧасть1" я завершаю редактирование строки
	И в таблице "ТабличнаяЧасть1" я нажимаю на кнопку с именем 'ТабличнаяЧасть1Добавить'
	И в таблице "ТабличнаяЧасть1" в поле с именем 'ТабличнаяЧасть1РеквизитЧисло' я ввожу текст '222,00'
	И в таблице "ТабличнаяЧасть1" я завершаю редактирование строки
	И в таблице "ТабличнаяЧасть1" я нажимаю на кнопку с именем 'ТабличнаяЧасть1Добавить'
	И в таблице "ТабличнаяЧасть1" в поле с именем 'ТабличнаяЧасть1РеквизитЧисло' я ввожу текст '333,00'
	И в таблице "ТабличнаяЧасть1" я завершаю редактирование строки

Сценарий: Исключение переход к строке.
	И в таблице "ТабличнаяЧасть1" я перехожу к строке:
		| 'Реквизит число'    |
		| 'НетТакогоЗначения' |
		
Сценарий: Исключение нет такой таблицы.
	И в таблице "НетТакойТаблицы" в поле с именем 'ТабличнаяЧасть1РеквизитЧисло' я ввожу текст '3,00'
	
Сценарий: Исключение нет такого поля в таблице.
	И в таблице "ТабличнаяЧасть1" в поле с именем 'НетТакогоПоляВТаблице' я ввожу текст '3,00'

	
Сценарий: Исключение не получилось перейти к строке таблицы. Отличается одна колонка.
		
	И в таблице "ТабличнаяЧасть1" я перехожу к строке:
		| 'N'  | 'Реквизит булево' | 'Реквизит число' |
		| '11' | 'Нет'             | '111,00'         |
		
Сценарий: Исключение не найдено поле шапки.

	И в поле с именем 'Наименование1111111111111111' я ввожу текст '222'


Сценарий: Снимаю флаг, которого нет.

	И я снимаю флаг "ФлагКоторогоНет"

Сценарий: Снимаю флагс именем, которого нет.

	И я снимаю флаг с именем "ФлагКоторогоНет"


Сценарий: ВВод текста в поле с неуникальным заголовком.

	И в поле 'Наименование' я ввожу текст '222'

