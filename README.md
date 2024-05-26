# dcape-app-woodpecker

> Приложение ядра [dcape](https://github.com/dopos/dcape) для задач CI/CD.

[![GitHub Release][1]][2] [![GitHub code size in bytes][3]]() [![GitHub license][4]][5]

[1]: https://img.shields.io/github/release/dopos/dcape-app-woodpecker.svg
[2]: https://github.com/dopos/dcape-app-woodpecker/releases
[3]: https://img.shields.io/github/languages/code-size/dopos/dcape-app-woodpecker.svg
[4]: https://img.shields.io/github/license/dopos/dcape-app-woodpecker.svg
[5]: LICENSE

 Роль в dcape | Сервис | Docker images
 --- | --- | ---
 cicd | [Woodpecker CI](https://woodpecker-ci.org/) | [woodpecker-server](https://hub.docker.com/r/woodpeckerci/woodpecker-server),
 [woodpecker-agent](https://hub.docker.com/r/woodpeckerci/woodpecker-agent)

## Назначение

Деплой приложений при получении webhook от VCS.

## Причины выбора Woodpecker CI

См. [Step-by-step guide to modern, secure and Open-source CI setup](https://devforth.io/blog/step-by-step-guide-to-modern-secure-ci-setup/), 2022.

---

## Install

Приложение разворачивается в составе [dcape](https://github.com/dopos/dcape).

## License

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2023-2024 Aleksei Kovrizhkin <lekovr+dopos@gmail.com>
