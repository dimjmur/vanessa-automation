﻿# language: ru
#parent uf:
@UF5_формирование_результатов_выполнения_сценариев
#parent ua:
@UA21_формировать_отчет_jUnit

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb

Функционал: Проверка формирования отчета jUnit

Как разработчик
Я хочу чтобы корректно формировался отчет jUnit
Чтобы я мог видеть результат работы сценариев

Контекст: 
	Когда Я открываю VanessaAutomation в режиме TestClient со стандартной библиотекой
	


//https://github.com/Pr-Mex/vanessa-automation/issues/1508
Сценарий: Прикрепление скриншота. Формируется только jUnit. Весь экран.

	* Подготовка
		Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit8"
		И в открытой форме я перехожу к закладке с заголовком "Сервис"
		И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
		
		И я перехожу к закладке с именем "ГруппаjUnit"
		И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
		И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
		И я запоминаю значение поля с именем 'КаталогВыгрузкиJUnit' как 'КаталогВыгрузкиJUnit'
		И я устанавливаю флаг с именем 'СкриншотыjUnit'
				

		И я перехожу к закладке с именем "СтраницаСкриншоты"
		И я устанавливаю флаг с именем 'ДелатьСкриншотПриВозникновенииОшибки'
		И я перехожу к закладке с именем "СтраницаСервисОсновные"
		И я разворачиваю группу с именем "ГруппаИспользоватьКомпонентуVanessaExt"
		И я устанавливаю флаг с именем 'ИспользоватьКомпонентуVanessaExt'
		И я устанавливаю флаг с именем 'ИспользоватьВнешнююКомпонентуДляСкриншотов'
				
		И в поле каталог скриншотов я указываю путь к относительному каталогу "tools\ScreenShotsTest"
		И я запоминаю значение поля с именем "КаталогВыгрузкиСкриншотов" как "Каталогкриншотов"
				
	* Выполнение сценария	

		И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
		И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	
	* Проверка	
		И в каталоге jUnit появился 1 файл xml	
		И для каждого файла "ТекущийФайл" из каталога "$КаталогВыгрузкиJUnit$"
			И я запоминаю содержимое файла "$_ПолноеИмя$" в переменную "ТекстФайла"
			

		И для каждого файла "ТекущийФайл" из каталога "$Каталогкриншотов$"
			И выражение внутреннего языка 'Найти($ТекстФайла$, $_Имя$) > 0' Истинно
			
		

	
Сценарий: Проверка правильного распознавания исключения в тексте исключения (не ассерт)
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit7"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml	
	
	И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'<error>'|
	
		
	
	
	
	
	
	
Сценарий: Проверка правильного распознавания ассертов в тексте исключения
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit6"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml	
	И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'<failure>'|
				|'<expected>Timeout exceeded</expected>'|
				|'<actual>Internet error'|
	
		
	
	
	
	
	
	
	
	
Сценарий: Проверка формирования секций когда используется assert сервер
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit5"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml	
	Если Версия платформы ">" "8.3.9.0" Тогда	
		И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'<expected>111</expected>'|
				|'<actual>222</actual>'|
	
	
	
Сценарий: Проверка формирования секций когда используется assert клиент
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit4"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml	
	Если Версия платформы ">" "8.3.9.0" Тогда	
		И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'<expected>111</expected>'|
				|'<actual>222</actual>'|
	
	
	
Сценарий: Проверка формирования краткого описания ошибки
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit3"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml	
	Если Версия платформы ">" "8.3.9.0" Тогда	
		И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'Текст исключения 222'|

				
	
Сценарий: Проверка формирования classname, когда указан специальный тег
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit2"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml	
	Если Версия платформы ">" "8.3.9.0" Тогда	
		Если поле с именем "ВерсияПоставки" имеет значение "standart" тогда
			И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'classname="ВнешняяОбработка.Условие.Форма.Форма.Форма'|
		Иначе		
			И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'classname="ВнешняяОбработка.VanessaAutomationsingle.Форма.Тест_Условие.Форма'|
	
	
	
Сценарий: Простая проверка отчета jUnit
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit1"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml



Сценарий: Скриншоты в  jUnit
	Когда В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "jUnit\ФичаДляПроверкиОтчетаjUnit8"
	И в открытой форме я перехожу к закладке с заголовком "Сервис"
	И я перехожу к закладке с именем "СтраницаОтчетыОЗапуске"
	
	И я перехожу к закладке с именем "ГруппаjUnit"
	И я устанавливаю флаг с именем 'ДелатьОтчетВФорматеjUnit'
	И я устанавливаю флаг с именем 'СкриншотыjUnit'
	И в поле каталог отчета jUnit я указываю путь к относительному каталогу "tools\jUnit"
	И я перехожу к закладке с именем "СтраницаСкриншоты"
	И я устанавливаю флаг с именем 'ДелатьСкриншотПриВозникновенииОшибки'
	И я устанавливаю флаг с именем 'СниматьСкриншотКаждогоОкна1С'
	И я перехожу к закладке с именем "СтраницаСервисОсновные"
	И я разворачиваю группу с именем "ГруппаИспользоватьКомпонентуVanessaExt"
	И я устанавливаю флаг с именем 'ИспользоватьКомпонентуVanessaExt'
	И я устанавливаю флаг с именем 'ИспользоватьВнешнююКомпонентуДляСкриншотов'
	И из выпадающего списка с именем "СпособСнятияСкриншотовВнешнейКомпонентой" я выбираю точное значение 'Весь экран'
	И в поле каталог скриншотов я указываю путь к относительному каталогу "tools\ScreenShotsTest"
	И в поле с именем 'КаталогПроекта' я ввожу текст '$КаталогПроекта$'
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
	И Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
	И в каталоге jUnit появился 1 файл xml
	Если Версия платформы ">" "8.3.9.0" Тогда	
		И файл "$НайденноеИмяФайлаxml$" содержит строки
				|'<system-out>[[ATTACHMENT\|/tools/ScreenShotsTest/'|
