https://git-scm.com/book/ru/v1/%D0%92%D0%B5%D1%82%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B2-Git-%D0%A7%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%BE%D0%B5-%D0%B2%D0%B5%D1%82%D0%BA%D0%B0%3F

Ветка - подвижный указатель на коммит. Автоматически перемещается с каждым коммитом.
Т.е. это файл, который содержит 40 байт контрольной суммы, .


HEAD - указатель на текущий коммит в локальной ветке.
git checkout - двигает HEAD и восстанавливает рабочие файлы, чтобы они соответствовали этой ветке.
Ну и новый коммит будет накатываться на HEAD.

Получается ветки имеют некий общий коммит.

?? Но могу ли я узнать, что некий коммит принадлежит такой-то ветке??

И допустим, я хочу узнать от какой ветки ответвилась моя ветка.

Получается, мне нужно знать общий коммит. И какой ветке он принадлежит.

?? А вдруг он принадлежит многим веткам.

Вот есть некий коммит, от которого отходит 10 веток.
?? Как узнать первую ветку, которой принадлежал этот коммит ??

?? Что значит detached HEAD ??

?? Если я хочу посмотреть состояние на каком-то коммите, который посреди какой-то ветки,
что произойдет с HEAD и что будет, если я изменю сорцы и попробую сделать коммит ??







"TypeError: path must be a string or Buffer\n    at TypeError (native)\n    at Object.fs.readdirSync (fs.js:952:18)\n    at handleTestDir (/home/alexey/projects/myGithub/node_modules/tia/engine/runner.js:119:18)\n    at next (native)\n    at runTestSuite (/home/alexey/projects/myGithub/node_modules/tia/engine/runner.js:175:24)\n    at next (native)\n    at onFulfilled (/home/alexey/projects/myGithub/node_modules/tia/node_modules/co/index.js:65:19)\n    at /home/alexey/projects/myGithub/node_modules/tia/node_modules/co/index.js:54:5\n    at co (/home/alexey/projects/myGithub/node_modules/tia/node_modules/co/index.js:50:10)\n    at /home/alexey/projects/myGithub/node_modules/tia/engine/runner.js:269:14\n    at tryCatcher (/home/alexey/projects/myGithub/node_modules/tia/node_modules/bluebird/js/release/util.js:16:23)\n    at Promise._settlePromiseFromHandler (/home/alexey/projects/myGithub/node_modules/tia/node_modules/bluebird/js/release/promise.js:512:31)\n    at Promise._settlePromise (/home/alexey/projects/myGithub/node_modules/tia/node_modules/bluebird/js/release/promise.js:569:18)\n    at Promise._settlePromiseCtx (/home/alexey/projects/myGithub/node_modules/tia/node_modules/bluebird/js/release/promise.js:606:10)\n    at Async._drainQueue (/home/alexey/projects/myGithub/node_modules/tia/node_modules/bluebird/js/release/async.js:138:12)\n    at Async._drainQueues (/home/alexey/projects/myGithub/node_modules/tia/node_modules/bluebird/js/release/async.js:143:10)"

