https://pediaa.com/what-is-the-difference-between-jar-war-and-ear/#:~:text=a%20Java%20application.-,The%20WAR%20file%20is%20a%20file%20that%20contains%20files%20such,on%20to%20an%20application%20server.

JAR: classes, associated metadata, resources (text, images).
Requires only Java installation.
.zip file with .jar extension.
Created by `jar` command.
Runs by `java -jar` command.


WAR: collection of JAR files, JSP, Servlet, XML, HTML, CSS, JS and other resources of web app. Requires Java EE Web Profile-compliant app server.

JSP - HTML with extra syntax.
Servlet - class that handles requests, and creates responses.
Servlet container manages servlets.
Web Server receives request, passes to servlet container, which passes it to
Servlet.

EAR - JAR which represents modules and metadata dir called META-INT.
Requires EE ?


Этапы:

clean
default (build)
site (формирование отчетов?)

mvn compile
Должна появиться папка target

mvn package

Можно добавить публикацию в репозиторий - install.

Команды (goals)
  pre-clean
  clean
  post-clean


Фазы подциклов
* Подготовка ресурсов.
* Валидация
* Компиляция
* Тестирование
* Упаковка
* Установка
* Деплой

========

Build profile.

Три основных профиля:
* pom.xml
* ~/.m2/settings.xml - приоритетней чем pom.xml
* E:/repos/maven/conf/settings.xml

build->plugins
maven-antrun-plugin

Через восклицательный знак (не), можно отменять профили.

==========

https://www.youtube.com/watch?v=MujGedLaLJ4&list=PL1zJrLkuWT67KutVoHZ3EhGswNkMcRIX2&index=5&ab_channel=OnFreeTube

# Репозитории
Хранят библиотеки, архивы, плагины, и любые артефакты, которые можно юзать в проектах.

* local, - ~ - Кэш зависимостей. Путь можно переопределить в ...maven/settings.xml

* central, - maven.org search.maven.org/#browse

* remote - repositories->repository->url.

Плагины.
mvn <plugin-name>:<goal-name>













