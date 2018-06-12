﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
Перем Контекст Экспорт;

&НаКлиенте
Перем КонтекстСохраняемый Экспорт;


&НаКлиенте
Функция ДобавитьШагВМассивТестов(МассивТестов,Снипет,ИмяПроцедуры,ПредставлениеТеста = Неопределено,Транзакция = Неопределено,Параметр = Неопределено)
	Структура = Новый Структура;
	Структура.Вставить("Снипет",Снипет);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ПредставлениеТеста",ПредставлениеТеста);
	Структура.Вставить("Транзакция",Транзакция);
	Структура.Вставить("Параметр",Параметр);
	МассивТестов.Добавить(Структура);
КонецФункции

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

//	ДобавитьШагВМассивТестов(ВсеТесты,"ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования()","ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования","я открыл форму VanessaBehavoir в режиме самотестирования"); //уже был в C:\Commons\Rep\vanessa-behavoir\tests\ManagedApplicationTests\Библиотеки\step_definitions\ЗагрузкаФичи.epf
//	ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)","ЯЗагрузилСпециальнуюТестовуюФичу","я загрузил специальную тестовую фичу ""ПростаяФичаДляПроверкиРаботыВыполненияСценария"""); //уже был в C:\Commons\Rep\vanessa-behavoir\tests\ManagedApplicationTests\Библиотеки\step_definitions\ЗагрузкаФичи.epf
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯПрервалВыполнениеШаговВХостСистемеИЯНажалНаКнопку(Парам01Строка)","ЯПрервалВыполнениеШаговВХостСистемеИЯНажалНаКнопку","я прервал выполнение шагов в хост системе и я нажал на кнопку ""ВыполнитьСценарии""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ВТестируемомЭкземпляреВыполнилсяСценарий()","ВТестируемомЭкземпляреВыполнилсяСценарий","в тестируемом экземпляре выполнился сценарий");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯПродолжилВыполнениеШаговВХостСистеме()","ЯПродолжилВыполнениеШаговВХостСистеме","Я продолжил выполнение шагов в хост системе");

	Возврат ВсеТесты;
КонецФункции

&НаСервере
Функция ПолучитьМакетСервер()
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет("Макет");
КонецФункции	

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
	
	//Сообщить("Контекст.Количество()=" + Контекст.Количество());
	//Контекст = Новый Структура;
	
	//Ванесса.ПосмотретьЗначение(Контекст);
	
	//подложим специальную epf, как будто она уже была там
	ПутьКудаПоложитьEPF = Ванесса.Объект.КаталогИнструментов + "\features\Support\Templates\step_definitions\ПростаяФичаДляПроверкиРаботыВыполненияСценария.epf";
	ФайлПроверкаСуществования = Новый Файл(ПутьКудаПоложитьEPF);
	Контекст.Вставить("ПутьКудаПоложитьEPF",ПутьКудаПоложитьEPF);
	Если Ванесса.ФайлСуществуетКомандаСистемы(ФайлПроверкаСуществования.ПолноеИмя) Тогда
		Ванесса.УдалитьФайлыКомандаСистемы(ПутьКудаПоложитьEPF);
	КонецЕсли;	 
	
	
	//ФайлПуть = Новый Файл(ФайлПроверкаСуществования.Путь);
	//Если Не ФайлПуть.Существует() Тогда
	//	СоздатьКаталог(ФайлПуть.ПолноеИмя);
	//КонецЕсли;  
	
	
	Макет = ПолучитьМакетСервер();
	Макет.Записать(ПутьКудаПоложитьEPF);
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
	Ванесса.УдалитьФайлыКомандаСистемы(Контекст.ПутьКудаПоложитьEPF);
	
	//безусловное закрытие формы если она осталась
	Попытка
	    ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
		ОткрытаяФормаVanessaBehavoir.Закрыть();
	Исключение
	
	КонецПопытки;
КонецПроцедуры


//&НаКлиенте
////я открыл форму VanessaBehavoir в режиме самотестирования
////@ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования()
//Процедура ЯОткрылФормуVanessaBehavoirВРежимеСамотестирования() Экспорт
//	ВызватьИсключение "Не реализовано.";
//КонецПроцедуры

//&НаКлиенте
////я загрузил специальную тестовую фичу "ПростаяФичаДляПроверкиРаботыВыполненияСценария"
////@ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка)
//Процедура ЯЗагрузилСпециальнуюТестовуюФичу(Парам01Строка) Экспорт
//	ВызватьИсключение "Не реализовано.";
//КонецПроцедуры

&НаКлиенте
//я прервал выполнение шагов в хост системе и я нажал на кнопку "ВыполнитьСценарии"
//@ЯПрервалВыполнениеШаговВХостСистемеИЯНажалНаКнопку(Парам01Строка)
Процедура ЯПрервалВыполнениеШаговВХостСистемеИЯНажалНаКнопку(ИмяПроцедуры) Экспорт
	ХостФорма = Ванесса;
	ХостФорма.ЗапретитьВыполнениеШагов();
	
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	Выполнить("ОткрытаяФормаVanessaBehavoir." + ИмяПроцедуры +"();");
	
	
КонецПроцедуры


&НаКлиенте
Процедура ПроверитьЧтоШагВыполнился(ДеревоСтроки,БылУспешныйШаг)
	Для каждого СтрокаДерева Из ДеревоСтроки Цикл
		Если СтрокаДерева.Тип = "Шаг" Тогда
			Если СтрокаДерева.Статус = "Success" Тогда
				БылУспешныйШаг = Истина;
			КонецЕсли;	 
		Иначе
			ПроверитьЧтоШагВыполнился(СтрокаДерева.ПолучитьЭлементы(),БылУспешныйШаг);
		КонецЕсли;	 
	КонецЦикла;
	
	Ванесса.ПроверитьРавенство(БылУспешныйШаг,Истина,"Был хотя бы один успешный шаг.");
КонецПроцедуры

&НаКлиенте
//в тестируемом экземпляре выполнился сценарий
//@ВТестируемомЭкземпляреВыполнилсяСценарий()
Процедура ВТестируемомЭкземпляреВыполнилсяСценарий() Экспорт
	БылУспешныйШаг = Ложь;
	//Ванесса.ПосмотретьЗначение(Контекст);
	//Парам.ОткрытаяФормаVanessaBehavoir.Элементы.ДеревоТестов
	ПроверитьЧтоШагВыполнился(Контекст.ОткрытаяФормаVanessaBehavoir.Объект.ДеревоТестов.ПолучитьЭлементы(),БылУспешныйШаг);
КонецПроцедуры

&НаКлиенте
//Я продолжил выполнение шагов в хост системе
//@ЯПродолжилВыполнениеШаговВХостСистеме()
Процедура ЯПродолжилВыполнениеШаговВХостСистеме() Экспорт
	//ВызватьИсключение "Не реализовано.";
КонецПроцедуры

//окончание текста модуля