https://snyk.io/blog/10-docker-image-security-best-practices/

Dont copy to images, cause keys will be in cache layers.

Похоже, ключи должны временно использоваться уже при сборке
продукта. Т.е. в тех образах, где они используются.

Причем они должны быть в промежуточных образах и уничтожаться,
когда билд получен.

