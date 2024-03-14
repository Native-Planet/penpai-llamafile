### PenpAI feat. [Llamafile](https://github.com/Mozilla-Ocho/llamafile)

This is a container definition meant to work with [GroundSeg](https://github.com/Native-Planet/GroundSeg)'s [PenpAI](https://github.com/Native-Planet/penpAI) app, which allows you to host and communicate with local LLMs from your urbit ship. 

Llamafiles are monolithic cross-platform executable LLM model files. They support a subset of the OpenAI API, which greatly reduces the complexity of selfhosting.

The start script checks for the `$MODEL_NAME` env var to select which model to use. This currently only works on x86_64.
