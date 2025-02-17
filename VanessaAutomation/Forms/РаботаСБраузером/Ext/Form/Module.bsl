﻿#Область ОписаниеПеременных

&НаКлиенте
Перем Ванесса;

&НаКлиенте
Перем ПортБраузера Экспорт;

#КонецОбласти

#Область ЭкспортныеПроцедурыИФункции

// Делает первичную инициализацию модуля.
&НаКлиенте
Функция ИнициализацияФормы(ВладелецФормы) Экспорт
	Ванесса = ВладелецФормы;
	ПортБраузера = 9222;
	Возврат Истина;
КонецФункции

// Ищет расположение браузера в файловой системе
&НаКлиенте
Процедура НайтиБраузерChrome(ИспользоватьОтладку) Экспорт
	
	// путь к браузеру можно взять из ветки реестра "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe"
	// значение параметра "Path" - "C:\Program Files\Google\Chrome\Application" или "C:\Program Files (x86)\Google\Chrome\Application"
	// в результате получаем "C:\Program Files\Google\Chrome\Application\crhome.exe" или "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	
	СисИнфо = Новый СистемнаяИнформация;
	Если СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86 ИЛИ СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86_64 Тогда
		RegProv = ПолучитьCOMОбъект("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv");
		ПутьGoogleChromeИзРеестра = Неопределено;
		RegProv.GetStringValue(2147483650,"SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe","Path",ПутьGoogleChromeИзРеестра);
		Если НЕ ПутьGoogleChromeИзРеестра = NULL Тогда
			Файл = Новый файл (ПутьGoogleChromeИзРеестра + "\chrome.exe");
			Если Ванесса.ФайлСуществуетКомандаСистемы(Файл.ПолноеИмя) Тогда
				Ванесса.Объект.КомандаЗапускаБраузера = """" + Файл.ПолноеИмя + """"
					+ ?(ИспользоватьОтладку, " --remote-debugging-port=" + Формат(ПортБраузера, "ЧГ="), "");
			КонецЕсли;
		Иначе
			ВызватьИсключение Ванесса.Локализовать("В реестре windows не обнаружен путь к браузеру Google Chrome. Укажите путь вручную.");
		КонецЕсли;
	КонецЕсли;
	
	Если Ванесса.ЭтоLinux Тогда
		Варианты = Новый Массив;
		Варианты.Добавить("/opt/google/chrome/chrome");
		Варианты.Добавить("/snap/bin/chromium");
		
		ПараметрыПоиска = Новый Структура;
		ПараметрыПоиска.Вставить("Варианты", Варианты);
		ПараметрыПоиска.Вставить("ИспользоватьОтладку", ИспользоватьОтладку);
		
		НайтиИсполняемыйФайлЗапускаБраузера(ПараметрыПоиска);
	КонецЕсли;
	
КонецПроцедуры

// Активизирует окно браузера
&НаКлиенте
Процедура АктивизироватьОкноБраузера(ПолныйЭкран = Ложь) Экспорт
	
	ОкноБраузера = ПолучитьОкноБраузера();
	Если ОкноБраузера <> 0 Тогда
		ВнешняяКомпонента().АктивироватьОкно(ОкноБраузера);
		Если ПолныйЭкран = Истина Тогда
			РаспахнутьПолныйЭкран(ОкноБраузера);
		КонецЕсли;
		Попытка
			ВыполнитьКалибровкуПозицииМыши(ОкноБраузера);
		Исключение
			
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

// Показывает анимацию клика в браузере
&НаКлиенте
Процедура АнимацияКлика(ЭлементФормы = Неопределено) Экспорт
	Если НЕ Ванесса.Объект.ЭмулироватьДвиженияМышкиVanessaExt Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Ванесса.Объект.ПодсвечиватьКликМышкиВБраузереVanessaExt Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Ванесса.Объект.ИспользоватьКомпонентуVanessaExt Тогда
		Возврат;
	КонецЕсли;
	
	ВнешняяКомпонента().ПоказатьВизуализациюНажатияМыши();
	
КонецПроцедуры

// Делает отключение модуля
&НаКлиенте
Функция ОтключениеМодуля() Экспорт

	Ванесса = Неопределено;
	
КонецФункции	 

// Закрывает все вкладки браузера
&НаКлиенте
Процедура ЗакрытьВкладкиБраузера() Экспорт
	
	HTTPЗапрос = Новый HTTPЗапрос("/json");
	HTTPСоединение = Новый HTTPСоединение("localhost", ПортБраузера, , , , 3);
	Попытка
		HTTPОтвет = HTTPСоединение.Получить(HTTPЗапрос);
	Исключение
		ВызватьИсключение НСтр("ru = 'Отсутствует соединение с браузером'");
	КонецПопытки;
	
	ТекстJSON = HTTPОтвет.ПолучитьТелоКакСтроку();
	ДанныеJSON = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
	Для каждого Элемент Из ДанныеJSON Цикл
		Попытка
			HTTPЗапрос = Новый HTTPЗапрос("/json/close/" + Элемент.id);
			HTTPСоединение.Получить(HTTPЗапрос);
		Исключение
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры

// Закрывает вкладку браузера с заголовком
&НаКлиенте
Процедура ЗакрытьВкладкуБраузераСЗаголовком(ЗаголовокВкладки) Экспорт
	
	HTTPЗапрос = Новый HTTPЗапрос("/json");
	HTTPСоединение = Новый HTTPСоединение("localhost", ПортБраузера, , , , 3);
	Попытка
		HTTPОтвет = HTTPСоединение.Получить(HTTPЗапрос);
	Исключение
		ВызватьИсключение НСтр("ru = 'Отсутствует соединение с браузером'");
	КонецПопытки;
	
	ВкладкаНайдена = Ложь;
	
	ТекстJSON = HTTPОтвет.ПолучитьТелоКакСтроку();
	ДанныеJSON = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
	Для каждого Элемент Из ДанныеJSON Цикл
		
		Если НЕ Ванесса.СтрокаСоответствуетШаблону(НРег(Элемент.title), НРег(ЗаголовокВкладки)) Тогда
			Продолжить;
		КонецЕсли;	
		
		Попытка
			HTTPЗапрос = Новый HTTPЗапрос("/json/close/" + Элемент.id);
			HTTPСоединение.Получить(HTTPЗапрос);
			ВкладкаНайдена = Истина;
			Прервать;
		Исключение
		КонецПопытки;
	КонецЦикла;
	
	Если НЕ ВкладкаНайдена Тогда
		ВызватьИсключение Ванесса.ПодставитьПараметрыВСтроку(
			Ванесса.Локализовать("Не найдена вкладка браузера с заголовком <%1>."), ЗаголовокВкладки);
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РаспахнутьПолныйЭкран(ОкноБраузера)
	
	Скрипт = "{
		|let node = document.createElement('div');
		|node.style.position = 'absolute';
		|node.style.height = '100%';
		|node.style.width = '100%';
		|node.style.overflow = 'hidden';
		|node.style.zIndex = 999999;
		|node.addEventListener('click', () => {
		|	document.documentElement.requestFullscreen();
		|	node.remove();
		|});
		|document.body.appendChild(node);
		|}";
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	ВнешняяКомпонента().Пауза(500);
	
	ТекстJSON = ВнешняяКомпонента().ПолучитьРазмерОкна(ОкноБраузера);
	РазмерОкна = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
	X = Окр((РазмерОкна.Left + РазмерОкна.Right) / 2);
	Y = Окр((РазмерОкна.Top + РазмерОкна.Bottom) / 2);
	ВнешняяКомпонента().УстановитьПозициюКурсора(X, Y);
	ВнешняяКомпонента().ЭмуляцияНажатияМыши(0);
	ВнешняяКомпонента().Пауза(500);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКалибровкуПозицииМыши(ОкноБраузера);
	
	Скрипт = "{
		|let node = document.createElement('div');
		|node.style.position = 'absolute';
		|node.style.height = '100%';
		|node.style.width = '100%';
		|node.style.overflow = 'hidden';
		|node.style.zIndex = 999999;
		|node.addEventListener('click', (e) => {
		|	window.VanessaMousePosition = {x: e.pageX, y: e.pageY};
		|	node.remove();
		|});
		|document.body.appendChild(node);
		|}";
	
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	ВнешняяКомпонента().Пауза(500);
	
	ТекстJSON = ВнешняяКомпонента().ПолучитьРазмерОкна(ОкноБраузера);
	РазмерОкна = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
	X = Окр((РазмерОкна.Left + РазмерОкна.Right) / 2);
	Y = Окр((РазмерОкна.Top + РазмерОкна.Bottom) / 2);
	ВнешняяКомпонента().УстановитьПозициюКурсора(X, Y);
	//ВнешняяКомпонента().ЭмуляцияНажатияМыши(0);
	ВнешняяКомпонента().Пауза(500);
	
	Скрипт = "{
		|let result = {
		|	x: window.VanessaMousePosition.x,
		|	y: window.VanessaMousePosition.y,
		|	z: window.devicePixelRatio,
		|	w: window.screenLeft,
		|	h: window.screenTop + window.outerHeight - window.innerHeight,
		|};
		|delete window.VanessaMousePosition;
		|JSON.stringify(result);
		|}";
	
	РезультатJSON = Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	ДанныеJSON = Ванесса.ПрочитатьОбъектJSON(РезультатJSON.result.result.value);
	Ванесса.Объект.СмещениеПоГоризонталиДвиженияМышкиVanessaExt = X - (ДанныеJSON.X + ДанныеJSON.W) * ДанныеJSON.Z;
	Ванесса.Объект.СмещениеПоВертикалиДвиженияМышкиVanessaExt = Y - (ДанныеJSON.Y + ДанныеJSON.H) * ДанныеJSON.Z;
	Ванесса.Объект.КоэффициентМасштабированияЭкрана = ДанныеJSON.Z;
	
КонецПроцедуры

&НаКлиенте
Функция ВнешняяКомпонента()
	Возврат Ванесса.ВнешняяКомпонентаДляСкриншотов;
КонецФункции

&НаКлиенте
Функция ПолучитьОкноБраузера()
	
	СтрокаИдентификатор = Строка(Новый УникальныйИдентификатор);
	Скрипт = "{
		|window.VanessaDocumentTitle = document.title; 
		|document.title = '" + СтрокаИдентификатор + "';
		|}";
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	
	ОкноБраузера = 0;
	ЧислоИтераций = 5;
	Пока ОкноБраузера = 0 И ЧислоИтераций > 0 Цикл
		ВнешняяКомпонента().Пауза(500);
		ЧислоИтераций = ЧислоИтераций - 1;
		ТекстJSON = ВнешняяКомпонента().ПолучитьСписокОкон(0);
		МассивОкон = Ванесса.ПрочитатьОбъектJSON(ТекстJSON);
		Для Каждого Стр Из МассивОкон Цикл
			ЗаголовокОкна = Неопределено;
			Если Стр.Свойство("Title", ЗаголовокОкна) Тогда
				Если Найти(ЗаголовокОкна, СтрокаИдентификатор) > 0 Тогда
					ОкноБраузера = Стр.Window;
					Прервать;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Скрипт = "{
		|document.title = window.VanessaDocumentTitle; 
		|delete window.VanessaDocumentTitle;
		|}";
	Ванесса.ВыполнитьJavaScriptБраузер(Скрипт);
	
	Возврат ОкноБраузера;
	
КонецФункции

&НаКлиенте
// Взято из внешней обработки "Библиотека VanessaExt", форма MainForm.
// Проект: https://github.com/lintest/VanessaExt
//
Процедура НайтиИсполняемыйФайлЗапускаБраузера(ПараметрыПоиска)
	
	Если ПараметрыПоиска.Варианты.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = ПараметрыПоиска.Варианты[0];
	ПараметрыПоиска.Варианты.Удалить(0);
	
	Файл = Новый Файл(ИмяФайла);
	ПараметрыПоиска.Вставить("ПолноеИмя", Файл.ПолноеИмя);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПроверитьСуществованиеФайлаЗапускаБраузера", ЭтотОбъект, ПараметрыПоиска);
	Файл.НачатьПроверкуСуществования(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
// Взято из внешней обработки "Библиотека VanessaExt", форма MainForm.
// Проект: https://github.com/lintest/VanessaExt
//
Процедура ПроверитьСуществованиеФайлаЗапускаБраузера(Существует, ДополнительныеПараметры) Экспорт
	
	Если Существует Тогда
		ПолноеИмяФайлаЗапуска = ДополнительныеПараметры.ПолноеИмя;
		Если ДополнительныеПараметры.ИспользоватьОтладку Тогда
			КлючОтладки = " --remote-debugging-port=" + Формат(ПортБраузера, "ЧГ=");
		Иначе
			КлючОтладки = "";
		КонецЕсли;
		Ванесса.Объект.КомандаЗапускаБраузера = """" + ПолноеИмяФайлаЗапуска + """" + КлючОтладки;
	Иначе
		НайтиИсполняемыйФайлЗапускаБраузера(ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
// Запускает браузер согласно указанным настройкам.
Процедура ЗапуститьБраузер(SilentLaunch = Истина) Экспорт
	ТекстКоманды = "start """" " + Ванесса.Объект.КомандаЗапускаБраузера;
	Если SilentLaunch Тогда
		ТекстКоманды = ТекстКоманды + " --silent-launch ";
	КонецЕсли;	
	Ванесса.ВыполнитьКомандуОСБезПоказаЧерногоОкна(ТекстКоманды, -1);
КонецПроцедуры 

#КонецОбласти
