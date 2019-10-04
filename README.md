# Collective blog in Ruby on Rail

This is a training application written by me for experimentation.

[reddthis.herokuapp.com](https://reddthis.herokuapp.com/)
* * *
# Коллективный блог на Ruby on Rail

Это тренировочное приложение. На данный момент процесс написания приложения ещё не завершён и продолжается. Список реализованных функций пополняется в процессе их добавления в приложение.

#### Реализовано на данный момент:

Без регистрации пользователям доступны следующие действия:

* просмотр индекса постов на главной странице
* просмотр страниц постов с комментариями к ним
* просмотр профилей пользователей, а также постов и комментариев, написанных конкретным пользователем
* просмотр рейтинга постов, комментариев и пользователей
* возможность зарегистрироваться (добавлена валидация сложности пароля)

Зарегистрированным пользователям (user/1qazXSW@) доступны следующие действия:

* все действия незарегистрированных пользователей
* написание новых постов
* написание новых комментариев
* просмотр индекса всех пользователей с краткой справкой о рейтинге каждого пользователя, количестве постов и комментариев, написанных им
* оценка постов, комментариев и пользователей

Зарегистрированным пользователям с ролью *модератора* (moderator/1qazXSW@) доступны следующие действия:

* все действия зарегистрированных пользователей
* редактирование и удаление любых постов и комментариев
* вход в Active Admin

Зарегистрированным пользователям с ролью *администратора* (admin/1q@W3e$R) доступны следующие действия:

* все действия зарегистрированных пользователей с ролью модератора
* удаление пользователей (блокировка)

#### В приложении использованы следующие gems (перечислены только ключевые):

* Devise – для реализации аутентификации. Произведены следующие настройки:
    * аутентификация по имени пользователя
    * блокировка аккаунтов пользователей, вместо безвозвратного удаления
    * отправка писем для активации новых аккаунтов, восстановления пароля, при изменении почты или пароля (используется SendGrid)
    * блокировка аккаунта при 10 попытках неверно введённого пароля
* СanСanСan – для авторизации.
    * настроено уведомления о необходимости аутентификации в случае неавторизованных действий незарегистрированного пользователя
* ActiveAdmin – для панели администрирования сайта. Произведены следующие настройки:
    * совместная работа с CanCanCan (доступ в панель только модераторам и администраторам)
    * использование существующей таблицы пользователей, без необходимости создания новых пользователей для работы с панелью администратора
* FriendlyId – для использования имени пользователя в URL профиля пользователя
* Bootstrap 4 – для настройки стиля сайта
* RSpec, ShouldaMatchers, FactoryBot и Faker – использованы в тестах
