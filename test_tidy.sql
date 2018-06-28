CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `date_reg` DATE NOT NULL,
  `login` VARCHAR(30) NOT NULL DEFAULT '',
  `password` VARCHAR(30) NOT NULL DEFAULT '',
  `email` VARCHAR(30) NOT NULL DEFAULT '',
  `username` VARCHAR(30) NOT NULL DEFAULT '',
  `url` TEXT NOT NULL DEFAULT '',
  `location` TEXT NOT NULL DEFAULT '',
  `notes` TEXT NOT NULL DEFAULT '',
  `usr_status` VARCHAR(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
)
  COMMENT = 'users';

CREATE TABLE IF NOT EXISTS `tests` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `date` DATE NOT NULL,
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `url` TEXT NOT NULL DEFAULT '',
  `uid` INT(100) UNSIGNED NOT NULL DEFAULT '0',
  `rating` INT(100) NOT NULL DEFAULT '0',
  `viewing` INT(11)  UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  COMMENT = 'table test';

CREATE TABLE IF NOT EXISTS `tests_result` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `url` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
)
  COMMENT = 'table test results';

CREATE TABLE IF NOT EXISTS `tests_questions` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `description` TEXT NOT NULL DEFAULT '',
  `url` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
)
  COMMENT = 'table test questions';

CREATE TABLE IF NOT EXISTS `tests_answers` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `question_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
)
  COMMENT = 'table test answers';

CREATE TABLE IF NOT EXISTS `tests_answers_value` ( 
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `question_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `result_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `answers_id` SMALLINT(1) UNSIGNED DEFAULT 0,
  `value` SMALLINT(1) UNSIGNED DEFAULT 0,  
  PRIMARY KEY (`id`)
)
  COMMENT = 'tests answers value';

CREATE TABLE IF NOT EXISTS `tests_tags` ( 
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `tag_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  COMMENT = 'tests tags value';

CREATE TABLE IF NOT EXISTS `tags` ( 
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `name` VARCHAR(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
)
  COMMENT = 'tags';

CREATE TABLE IF NOT EXISTS `likes` ( 
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `uid` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `value` SMALLINT(1) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`)
)
  COMMENT = 'likes';

CREATE TABLE IF NOT EXISTS `reports` ( 
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `description` TEXT NOT NULL DEFAULT '',
  `uid` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  COMMENT = 'reports';

CREATE TABLE IF NOT EXISTS `comments` ( 
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
  `test_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `comment` TEXT NOT NULL DEFAULT '',
  `uid` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `datetime` DATETIME NOT NULL,
  `viewed` SMALLINT(1) UNSIGNED DEFAULT '0',
  `user` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  COMMENT = 'comments';

INSERT INTO tests (date, name, description, url, uid) VALUES ('2018-06-02', 'Кто ты?', 'Описание', 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png', 5);
INSERT INTO tests_result (test_id, name, description, url) VALUES (1, 'Ты аскет', 'тру хокаге', '');
INSERT INTO tests_result (test_id, name, description, url) VALUES (1, 'Ты лопух', 'лев толстой', '');
INSERT INTO tests_questions (test_id, name, description, url) VALUES (1, 'Вопрос: Ты аскет', 'тру хокаге', '');
INSERT INTO tests_questions (test_id, name, description, url) VALUES (1, 'Вопрос: Ты лопух', 'лев толстой', '');

INSERT INTO tests (date, name, description, url, uid) VALUES ('2018-06-02', 'Тест на наруто?', 'Наруто', 'https://jut.su/templates/school/images/anime_naruto_chibi.jpg', 5);
INSERT INTO tests_result (test_id, name, description, url) VALUES (2, 'Наруто', '', '');
INSERT INTO tests_result (test_id, name, description, url) VALUES (2, 'Узумаке', '', '');

INSERT INTO tests_answers (question_id, test_id, name) VALUES (1, 2, 'Да я аскет');
INSERT INTO tests_answers (question_id, test_id, name) VALUES (1, 2, 'Нет я не аскет');
INSERT INTO tests_answers_value (answers_id, test_id, value) VALUES (1, 2, 20);
INSERT INTO tests_answers_value (answers_id, test_id, value) VALUES (1, 2, 60);
INSERT INTO tests_answers_value (answers_id, test_id, value) VALUES (2, 2, 40);

ALTER TABLE users ADD `url` TEXT NOT NULL DEFAULT '';
ALTER TABLE users ADD `usr_status` VARCHAR(30) NOT NULL DEFAULT '';
ALTER TABLE tests_answers_value DROP COLUMN date;

INSERT INTO tests_answers_value (id, question_id) VALUES (1, 1);
INSERT INTO tests_answers_value (id, question_id) VALUES (2, 1);

UPDATE tests_answers_value SET question_id = 1 WHERE id = 1;
UPDATE users SET url = 'http://s13.radikal.ru/i186/1109/49/700b2b7d529d.jpg' WHERE id = 5;

ALTER TABLE comments DROP COLUMN check;