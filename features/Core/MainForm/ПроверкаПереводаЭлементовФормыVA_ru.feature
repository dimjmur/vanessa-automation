﻿# language: ru
# encoding: utf-8
#parent uf:
@UF11_Прочее
#parent ua:
@UA44_Прочая_активность_по_проверке

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnUFSovm82Builds
@IgnoreOnWeb
@IgnoreOn836
@IgnoreOn837
@IgnoreOn838
@IgnoreOn839
@IgnoreOn8310
@IgnoreOn8311
@IgnoreOn8312
@IgnoreOn8313
@IgnoreOn8314
@IgnoreOn8315
@IgnoreOn8316
@tree

Функционал: Проверка перевода элементов формы VA ru и уникальности заголовков элементов
 
Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий


@IgnoreOnServer
Сценарий: Проверка синонимов ru и en во всех формах Vanessa Automation
	И я проверяю, что во всех формах Vanessa Automation для каждого синонима ru или en есть пара

Сценарий: Проверка перевода элементов формы VA ru и уникальности заголовков элементов
	Когда Я открываю VanessaAutomation в режиме TestClient
	И в форме VA синоним элементов неравен заголовку элементов

	И я перехожу к закладке с именем "ГруппаСлужебная"
	И я нажимаю на кнопку с именем 'ПроверкаУникальностиЗаголовков'
	И Пауза 3
	Тогда не появилось окно предупреждения системы
		
	Тогда в логе сообщений TestClient есть строки:
		|'Ok.'|





