FROM ghcr.io/ggerganov/llama.cpp:full AS base

#
# builder
#
FROM base AS BUILDER

ARG HUGGINGFACE_TOKEN
ARG MODEL

RUN pip install huggingface_hub
RUN if [ -n "$HUGGINGFACE_TOKEN" ] ; then huggingface-cli login --token "$HUGGINGFACE_TOKEN" ; fi

RUN mkdir /model
COPY download.py /model
RUN python3 /model/download.py
RUN python3 /app/convert.py --outfile /model/ggml-model.bin /model
RUN /app/quantize /model/ggml-model.bin /model/ggml-model-q4_0.bin q4_0

#
# output
#
FROM base

RUN mkdir /model
COPY --from=builder /model/ggml-model-q4_0.bin /model

ENTRYPOINT ["/app/server", "--host", "0.0.0.0", "--port", "80", "-m", "/model/ggml-model-q4_0.bin"]
