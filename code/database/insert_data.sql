-- Режиссеры
INSERT INTO Producers (p_name, p_surname) VALUES
('Дэвид', 'Бениофф'),
('Пол', 'МакГиган'),
('Чарли', 'Брукер');
-- ('Винс', 'Гиллиган'),
-- ('Тим', 'Милантс');

-- Сериалы
INSERT INTO Serials (s_idProducer, s_img, s_name, s_description, s_year, s_genre, s_rating, s_seasons, s_state, s_duration) VALUES
(1, 'https://avatars.dzeninfra.ru/get-zen_doc/3703431/pub_5f59ee2c55f5fd69c0f2e71e_5f59ef1d55f5fd69c0f47f48/scale_1200', 'Игра Престолов', 'Фэнтезийная драма о борьбе за Железный Трон', 2011, 'Фэнтези', 9.3, 8, 'завершен', '00:00:00'),
(2, 'https://www.coverwhiz.com/uploads/tv/sherlock-series-2.jpg', 'Шерлок', 'Детективные приключения Шерлока Холмса и доктора Ватсона', 2010, 'Детектив', 9.1, 4, 'продолжается', '00:00:00'),
(3, 'https://ru-images.kinorium.com/movie/1080/610681.jpg?1697713271', 'Черное зеркало', 'Научно-фантастический сериал о технологиях будущего', 2011, 'Научная фантастика', 8.8, 6, 'продолжается', '00:00:00');
-- (4, 'Во все тяжкие', 'Драма о учителе химии, который стала наркобароном', 2008, 'Драма', 9.5, 5, 'завершен'),
-- (5, 'Острые козырьки', 'Драма о жизни на улицах Балтимора и наркоторговле', 2017, 'Драма', 8.4, 5, 'продолжается');

-- Сезоны
INSERT INTO Seasons (ss_idSerial, ss_name, ss_num, ss_cntEpisodes, ss_date) VALUES
(1, 'Сезон 1', 1, 10, '17-04-2011'),
(1, 'Сезон 2', 2, 10, '01-04-2012'),
(1, 'Сезон 3', 3, 10, '31-03-2013'),
(1, 'Сезон 4', 4, 10, '06-04-2014'),
(1, 'Сезон 5', 5, 10, '12-04-2015'),
(1, 'Сезон 6', 6, 10, '24-04-2016'),
(1, 'Сезон 7', 7, 7, '16-07-2017'),
(1, 'Сезон 8', 8, 6, '14-04-2019'),
(2, 'Сезон 1', 1, 3, '08-08-2010'),
(2, 'Сезон 2', 2, 3, '15-01-2012'),
(2, 'Сезон 3', 3, 3, '12-01-2014'),
(2, 'Сезон 4', 4, 3, '15-01-2017'),
(3, 'Сезон 1', 1, 3, '04-12-2011'),
(3, 'Сезон 2', 2, 3, '11-02-2013'),
(3, 'Сезон 3', 3, 6, '21-10-2016'),
(3, 'Сезон 4', 4, 6, '29-12-2017'),
(3, 'Сезон 5', 5, 3, '05-06-2019'),
(3, 'Сезон 6', 6, 5, '15-06-2023');

-- Эпизоды
INSERT INTO Episodes (e_idSeason, e_name, e_num, e_duration, e_date) VALUES
(1, 'Зима близко', 1, '01:02:00', '17-04-2011'),
(1, 'Королевский тракт', 2, '00:56:00', '24-04-2011'),
(1, 'Лорд Сноу', 3, '00:58:00', '01-05-2011'),
(1, 'Калеки, бастарды и сломанные вещи', 4, '00:56:00', '08-05-2011'),
(1, 'Волк и Лев', 5, '00:55:00', '15-05-2011'),
(1, 'Золотая корона', 6, '00:53:00', '22-05-2011'),
(1, 'Ты побеждаешь или умираешь', 7, '00:58:00', '29-05-2011'),
(1, 'Острый конец', 8, '00:59:00', '05-06-2011'),
(1, 'Бейелор', 9, '00:57:00', '12-06-2011'),
(1, 'Пламя и кровь', 10, '00:53:00', '19-06-2011'),
(2, 'Север помнит', 1, '00:53:00', '01-04-2012'),
(2, 'Ночные Земли', 2, '00:54:00', '08-04-2012'),
(2, 'То, что мертво, умереть не может', 3, '00:53:00', '15-04-2012'),
(2, 'Костяной Сад', 4, '00:51:00', '22-04-2012'),
(2, 'Призрак Харренхола', 5, '00:55:00', '29-04-2012'),
(2, 'Старые Боги и Новые', 6, '00:54:00', '06-05-2012'),
(2, 'Человек без чести', 7, '00:56:00', '13-05-2012'),
(2, 'Принц Винтерфелла', 8, '00:54:00', '20-05-2012'),
(2, 'Черноводная', 9, '00:55:00', '27-05-2012'),
(2, 'Валар Моргулис', 10, '01:04:00', '03-06-2012'),
(3, 'Валар Дохаэрис', 1, '00:55:00', '31-03-2013'),
(3, 'Чёрные крылья, чёрные вести', 2, '00:56:00', '07-04-2013'),
(3, 'Стезя страданий', 3, '00:56:00', '14-04-2013'),
(3, 'Теперь его дозор окончен', 4, '00:53:00', '21-04-2013'),
(3, 'Поцелованная огнём', 5, '00:57:00', '28-04-2013'),
(3, 'Подъём', 6, '00:53:00', '05-05-2013'),
(3, 'Медведь и прекрасная дева', 7, '00:58:00', '12-05-2013'),
(3, 'Младшие Сыны', 8, '00:56:00', '19-05-2013'),
(3, 'Рейны из Кастамере', 9, '00:51:00', '02-06-2013'),
(3, 'Мать', 10, '01:03:00', '09-06-2013'),
(4, 'Два меча', 1, '00:58:00', '06-04-2014'),
(4, 'Лев и Роза', 2, '00:52:00', '13-04-2014'),
(4, 'Разрушительница оков', 3, '00:57:00', '20-04-2014'),
(4, 'Верный клятве', 4, '00:55:00', '27-04-2014'),
(4, 'Именуемый первым', 5, '00:53:00', '04-05-2014'),
(4, 'Законы богов и людей', 6, '00:51:00', '11-05-2014'),
(4, 'Пересмешник', 7, '00:51:00', '18-05-2014'),
(4, 'Гора и Змей', 8, '00:52:00', '01-06-2014'),
(4, 'Дозорные на Стене', 9, '00:51:00', '08-06-2014'),
(4, 'Дети', 10, '01:05:00', '15-06-2014'),
(5, 'Грядущие войны', 1, '00:53:00', '12-04-2015'),
(5, 'Чёрно-Белый Дом', 2, '00:56:00', '19-04-2015'),
(5, 'Его Воробейшество', 3, '01:00:00', '26-04-2015'),
(5, 'Сыны Гарпии', 4, '00:51:00', '03-05-2015'),
(5, 'Убей мальчишку', 5, '00:57:00', '10-05-2015'),
(5, 'Непокорные, несгибаемые, несломленные', 6, '00:54:00', '17-05-2015'),
(5, 'Дар', 7, '00:59:00', '24-05-2015'),
(5, 'Суровый Дом', 8, '01:01:00', '31-05-2015'),
(5, 'Танец драконов', 9, '00:52:00', '07-06-2015'),
(5, 'Милосердие Матери', 10, '01:00:00', '14-06-2015'),
(6, 'Красная женщина', 1, '00:50:00', '24-04-2016'),
(6, 'Дом', 2, '00:54:00', '01-05-2016'),
(6, 'Клятвопреступник', 3, '00:52:00', '08-05-2016'),
(6, 'Книга Неведомого', 4, '00:59:00', '15-05-2016'),
(6, 'Дверь', 5, '00:57:00', '22-05-2016'),
(6, 'Кровь моей крови', 6, '00:52:00', '29-05-2016'),
(6, 'Сломленный человек', 7, '00:51:00', '05-06-2016'),
(6, 'Никто', 8, '00:59:00', '12-06-2016'),
(6, 'Битва бастардов', 9, '01:00:00', '19-06-2016'),
(6, 'Ветра зимы', 10, '01:08:00', '26-06-2016'),
(7, 'Драконий Камень', 1, '00:59:00', '16-07-2017'),
(7, 'Бурерождённая', 2, '00:59:00', '23-07-2017'),
(7, 'Правосудие королевы', 3, '01:03:00', '30-07-2017'),
(7, 'Трофеи войны', 4, '00:50:00', '06-08-2017'),
(7, 'Восточный Дозор', 5, '00:59:00', '13-08-2017'),
(7, 'За Стеной', 6, '01:10:00', '20-08-2017'),
(7, 'Дракон и Волк', 7, '01:20:00', '27-08-2017'),
(8, 'Винтерфелл', 1, '00:54:00', '14-04-2019'),
(8, 'Рыцарь Семи Королевств', 2, '00:58:00', '21-04-2019'),
(8, 'Долгая Ночь', 3, '01:22:00', '28-04-2019'),
(8, 'Последние из Старков', 4, '01:18:00', '05-05-2019'),
(8, 'Колокола', 5, '01:18:00', '12-05-2019'),
(8, 'Железный Трон', 6, '01:20:00', '19-05-2019'),
(9, 'Этюд в розовых тонах', 1, '01:28:00', '25-07-2010'),
(9, 'Слепой банкир', 2, '01:29:00', '01-08-2010'),
(9, 'Большая игра', 3, '01:29:00', '08-08-2010'),
(10, 'Скандал в Белгравии', 1, '01:29:00', '01-01-2012'),
(10, 'Собаки Баскервиля', 2, '01:28:00', '08-01-2012'),
(10, 'Рейхенбахский водопад', 3, '01:28:00', '15-01-2012'),
(11, 'Пустой катафалк', 1, '01:28:00', '01-01-2014'),
(11, 'Знак трёх', 2, '01:26:00', '05-01-2014'),
(11, 'Его прощальный обет', 3, '01:29:00', '12-01-2014'),
(12, 'Шесть Тэтчер', 1, '01:28:00', '01-01-2017'),
(12, 'Шерлок при смерти', 2, '01:29:00', '08-01-2017'),
(12, 'Последнее дело', 3, '01:29:00', '15-01-2017'),
(13, 'Национальный гимн', 1, '00:44:00', '04-12-2011'),
(13, '15 миллионов заслуг', 2, '01:02:00', '11-12-2011'),
(13, 'История всей твоей жизни', 3, '00:49:00', '18-12-2011'),
(14, 'Я скоро вернусь', 1, '00:48:00', '11-02-2013'),
(14, 'Белый медведь', 2, '00:42:00', '18-02-2013'),
(14, 'Момент Валдо', 3, '00:43:00', '25-02-2013'),
(15, 'Нырок', 1, '01:03:00', '21-10-2016'),
(15, 'Игровой тест', 2, '00:57:00', '21-10-2016'),
(15, 'Заткнись и танцуй', 3, '00:52:00', '21-10-2016'),
(15, 'Сан-Джуниперо', 4, '01:01:00', '21-10-2016'),
(15, 'Люди против огня', 5, '01:00:00', '21-10-2016'),
(15, 'Враг народа', 6, '01:29:00', '21-10-2016'),
(16, 'USS Каллистер', 1, '01:16:00', '29-12-2017'),
(16, 'Аркангел', 2, '00:52:00', '29-12-2017'),
(16, 'Крокодил', 3, '00:59:00', '29-12-2017'),
(16, 'Повесь диджея', 4, '00:51:00', '29-12-2017'),
(16, 'Металлист', 5, '00:41:00', '29-12-2017'),
(16, 'Чёрный музей', 6, '01:09:00', '29-12-2017'),
(17, 'Бросок гадюки', 1, '01:01:00', '05-06-2019'),
(17, 'Осколки', 2, '01:10:00', '05-06-2019'),
(17, 'Рейчел, Джек и Эшли Два', 3, '01:07:00', '05-06-2019'),
(18, 'Ужасная Джоан', 1, '00:58:00', '15-06-2023'),
(18, 'Лох-Генри', 2, '00:56:00', '15-06-2023'),
(18, 'За морем', 3, '01:19:00', '15-06-2023'),
(18, 'Мейзи Дэй', 4, '00:43:00', '15-06-2023'),
(18, 'Демон 79', 5, '01:14:00', '15-06-2023');

-- Актеры
INSERT INTO Actors (a_name, a_surname, a_gender, a_bdate) VALUES
('Питер', 'Динклэйдж', 'мужской', '11-06-1969'),
('Кит', 'Харингтон', 'мужской', '26-12-1986'),
('Эмилия', 'Кларк', 'женский', '23-10-1986'),
('Софи', 'Тернер', 'женский', '21-02-1996'),
('Мейси', 'Уильямс', 'женский', '15-04-1997'),
('Бенедикт', 'Камбербэтч', 'мужской', '19-07-1976'),
('Мартин', 'Фримен', 'мужской', '08-09-1971'),
('Уна', 'Стаббс', 'женский', '01-05-1937'),
('Марк', 'Гэттис', 'мужской', '17-10-1966'),
('Руперт', 'Грейвс', 'мужской', '30-06-1963'),
('Дэниел', 'Калуя', 'мужской', '24-02-1989'),
('Тоби', 'Кеббелл', 'мужской', '09-07-1982'),
('Хейли', 'Этвелл', 'женский', '05-04-1982'),
('Брайс Даллас', 'Ховард', 'женский', '02-03-1981'),
('Уайатт', 'Рассел', 'мужской', '10-07-1986');

-- Актеры в сериале
INSERT INTO Serials_Actors(sa_idSerial, sa_idActor) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15);

update serials
set s_duration = (select calculate_total_duration(1))
where s_id = 1;
update serials
set s_duration = (select calculate_total_duration(2))
where s_id = 2;
update serials
set s_duration = (select calculate_total_duration(3))
where s_id = 3;

-- Избранное
-- INSERT INTO Favourites (f_cntSerials) VALUES
-- (0);

-- -- Пользователи
-- INSERT INTO Users (u_idFavourites, u_login, u_password, u_role, u_name, u_surname, u_gender, u_bdate) VALUES
-- (1, 'user1', '12345', 'admin', 'Alina', 'Zhavoronkova', 'женский', '24-05-2003');