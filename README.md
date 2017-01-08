# CoreNLP Server Docker

In the image, CoreNLP is installed at `/opt/corenlp/src/`.

To get this image:

```sh
docker pull dockervhf/corenlp-server
```

To run the server:

```sh
docker run -p 9000:9000 dockervhf/corenlp-server
```

## additional models and docker compose

You can download models and put them in a volume located at `/models` in the container.

Here is a sample `docker-compose.yml`:

```yml
version: '2'
services:
  thisismyservice:
    image: dockervhf/corenlp-server
    expose:
      - 9000
    volumes:
      - $PWD/models:/models
```

In the directory where it's located, you could:

```sh
mkdir -p models && cd models
wget http://nlp.stanford.edu/software/stanford-spanish-corenlp-2016-10-31-models.jar
cd .. && docker-compose up -d
```

The script `corenlp.sh` will take care of copying all models located at `/models` into the directory where CoreNLP will be able to find them.

If you would like to add a KB to resolve entities (e.g. `wikidict.tab.gz`), place it in `/models` and mount this directory in `/opt/corenlp/src/edu/stanford/nlp/models/kbp/`:

```yml
version: '2'
services:
  thisismyservice:
    image: dockervhf/corenlp-server
    expose:
      - 9000
    volumes:
      - $PWD/models:/models
      - $PWD/models:/opt/corenlp/src/edu/stanford/nlp/models/kbp/
```
