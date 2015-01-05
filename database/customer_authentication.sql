-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Сер 20 2014 р., 03:11
-- Версія сервера: 5.5.37
-- Версія PHP: 5.4.4-14+deb7u11

-- --------------------------------------------------------

--
-- Структура таблиці `customer_authentication`
--

CREATE TABLE IF NOT EXISTS `customer_authentication` (
  `customer_authentication_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `provider` varchar(100) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `web_site_url` varchar(255) NOT NULL,
  `profile_url` varchar(255) NOT NULL,
  `photo_url` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  `age` varchar(255) NOT NULL,
  `birth_day` varchar(255) NOT NULL,
  `birth_month` varchar(255) NOT NULL,
  `birth_year` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`customer_authentication_id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;
