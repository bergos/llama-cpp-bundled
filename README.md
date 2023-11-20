# llama-cpp-bundled

This project bundles [llama.cpp](https://github.com/ggerganov/llama.cpp) with a pre-trained large language model in a single docker image.
It comes with the [Mistral](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.1) model by default, but it's easy to build custom images with different models.

## Usage

The following command will pull the image and start the server, which is listening at [http://localhost:8080/](http://localhost:8080/).

```bash
docker run --name=llama-cpp-bundled -p 8080:80 ghcr.io/bergos/llama-cpp-bundled:latest
```

## Customize

It's easy to build a custom image with a different model from Hugging Face.
Checkout the repository and start a docker build.
The model name must be given in the `MODEL` variable.
If a model requires authentication, a token must be given via the `HUGGINGFACE_TOKEN` variable. 
See the example below for Llama 2:

```bash
HUGGINGFACE_TOKEN=...
MODEL=meta-llama/Llama-2-7b-chat-hf

docker buildx build --tag llama-cpp-bundled-customized --load --build-arg HUGGINGFACE_TOKEN=$HUGGINGFACE_TOKEN --build-arg MODEL=$MODEL .
```
