﻿Процедура ОбходКаталогаПравил(ФайлПравила,ТекстПравилСобранный, ЭтоОтложенноеДобавление = Ложь)

	//ЭтоКаталог = ФайлПравила.Расширение = Неопределено;
	ЭтоКаталог = ФайлПравила.ЭтоКаталог();
 	Если ЭтоКаталог Тогда

		СтрокаОткрытия = СтрШаблон("#Область %1", ФайлПравила.Имя);
		ТекстПравилСобранный.ДобавитьСтроку(СтрокаОткрытия);

		ПравилаКаталога = НайтиФайлы(ФайлПравила.ПолноеИмя,"*");

		ПравилаДляОтложенногоДобавления = Новый Структура; //Для сохранения очередности??

		Для каждого ПравилоКаталога из ПравилаКаталога Цикл

			Если НЕ ЭтоОтложенноеДобавление
				И (СтрНайти(ПравилоКаталога.Имя, "Алгоритмы") > 0 
					ИЛИ СтрНайти(ПравилоКаталога.Имя, "ОбработчикиКонвертации")) Тогда
				ПравилаДляОтложенногоДобавления.Вставить(ПравилоКаталога.Имя, ПравилоКаталога);
				Продолжить;
			КонецЕсли;
			

			ОбходКаталогаПравил(ПравилоКаталога, ТекстПравилСобранный, ЭтоОтложенноеДобавление);
		КонецЦикла;

		Если ПравилаДляОтложенногоДобавления.Свойство("ОбработчикиКонвертации") Тогда
			ОбходКаталогаПравил(ПравилаДляОтложенногоДобавления.ОбработчикиКонвертации, ТекстПравилСобранный, Истина);
		КонецЕсли;

		Если ПравилаДляОтложенногоДобавления.Свойство("Алгоритмы") Тогда
			ОбходКаталогаПравил(ПравилаДляОтложенногоДобавления.Алгоритмы, ТекстПравилСобранный, Истина);
		КонецЕсли;

		СтрокаЗакрытия = "#КонецОбласти";
		ТекстПравилСобранный.ДобавитьСтроку(СтрокаЗакрытия);

	Иначе

		ЧтениеТекста = Новый ЧтениеТекста(ФайлПравила.ПолноеИмя, "UTF-8");

		Читать = Истина;
		Пока Читать Цикл
			ПрочитаннаяСтрока = ЧтениеТекста.ПрочитатьСтроку();
			Если ПрочитаннаяСтрока = Неопределено Тогда
				Прервать;
			КонецЕсли;

		ТекстПравилСобранный.ДобавитьСтроку(ПрочитаннаяСтрока);
		КонецЦикла;

		Если НЕ ЭтоОтложенноеДобавление Тогда
			ТекстПравилСобранный.ДобавитьСтроку(Символы.ПС); //В типовой лепит их без пробелов
		КонецЕсли;
	КонецЕсли;


КонецПроцедуры

#Область ШаблонЗаголовка

ИмяРепозитория = "";
ВеткаРепозитория = "";
УказательВетки = "";

Если АргументыКоманднойСтроки.Количество() > 2 Тогда//Сборка через получение правил по произвольной ветке (сомнительная реализация)
	ИмяРепозитория = АргументыКоманднойСтроки[2];
	ВеткаРепозитория = АргументыКоманднойСтроки[3];
	УказательВетки = АргументыКоманднойСтроки[4];
КонецЕсли;
ШаблонЗаголовка =
"////////////////////////////////////////////////////////////////////////////////
|// Менеджер обмена через универсальный формат (%1 от %2)
|// %3 %4
|////////////////////////////////////////////////////////////////////////////////";

Заголовок = СтрШаблон(ШаблонЗаголовка, ИмяРепозитория, ТекущаяДата(), ВеткаРепозитория, УказательВетки);
#КонецОбласти

КаталогПравилРазобраные = АргументыКоманднойСтроки[0];
ПутьКФайлуСобранные = АргументыКоманднойСтроки[1]; //Вынести в общие настройки ??

КаталогТекстовПравил = КаталогПравилРазобраные;

КаталогПравил = Новый Файл(КаталогТекстовПравил);
КаталогПравилСуществует = КаталогПравил.Существует();

ФайлыПравил = НайтиФайлы(КаталогТекстовПравил,"*");


ТД = Новый ТекстовыйДокумент();
ТД.ДобавитьСтроку(Заголовок);

ЭлементовВКаталоге = 0;
Для каждого ФайлПравила из ФайлыПравил Цикл
	Если Лев(ФайлПравила.Имя,1) = "." Тогда
		Продолжить;
	КонецЕсли;
	ОбходКаталогаПравил(ФайлПравила, ТД);
КонецЦикла;

ПутьФайлаПравил = ПутьКФайлуСобранные;

ТД.Записать(ПутьФайлаПравил);
ТД = Неопределено;
ФайлыПравил = Неопределено;

Б = 2;