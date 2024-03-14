#!/bin/bash

# Parse command line arguments for model value
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --model) model="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Default model value if not provided
if [ -z "$model" ]; then
    echo "No model value provided. Defaulting to mixtral-7b"
    echo "Supported models are mistral-7b, mixtral-8x7b, wizardoder-34b,
    wizardcoder13b, llava-1.5, tinyllama-1.1b, rocket-3b"
    model="mistral-7"
fi

# Define model download URL and filename based on the model argument
case $model in
    mistral-7b)
        MODEL_NAME="Mistral-7B-Instruct"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/Mistral-7B-Instruct-v0.2-llamafile/resolve/main/mistral-7b-instruct-v0.2.Q5_K_M.llamafile?download=true"
        ;;
    mixtral-8x7b)
        MODEL_NAME="Mixtral-8x7B-Instruct	"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/Mixtral-8x7B-Instruct-v0.1-llamafile/resolve/main/mixtral-8x7b-instruct-v0.1.Q5_K_M.llamafile?download=true"
        ;;
    wizardcoder-34b)
        MODEL_NAME="WizardCoder-Python-34B"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/WizardCoder-Python-34B-V1.0-llamafile/resolve/main/wizardcoder-python-34b-v1.0.Q5_K_M.llamafile?download=true"
        ;;
    wizardcoder-13b)
        MODEL_NAME="WizardCoder-Python-13B"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/wizardcoder-13b-python/resolve/main/wizardcoder-python-13b.llamafile?download=true"
        ;;
    llava-1.5)
        MODEL_NAME="LLaVA 1.5"
        MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/llava-v1.5-7B-GGUF/resolve/main/llava-v1.5-7b-q4.llamafile?download=true"
        ;;
     tinyllama-1.1b)
         MODEL_NAME="TinyLlama-1.1B"
         MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile?download=true"
         ;;
     rocket-3b)
         MODEL_NAME="Rocket-3B"
         MODEL_DOWNLOAD_URL="https://huggingface.co/jartine/rocket-3B-llamafile/resolve/main/rocket-3b.Q5_K_M.llamafile?download=true"
         ;;
    *)
        echo "Invalid model value provided. Supported models are 7b, 13b, 70b, code-7b, code-13b, code-34b."
        exit 1
        ;;
esac

echo "Downloading $MODEL_NAME..."
wget -O "/app/${MODEL_NAME}" "${MODEL_DOWNLOAD_URL}" || { echo "Failed to download model."; exit 1; }
echo "Running command with ${MODEL_NAME}..."
/bin/sh -c "/app/${MODEL_NAME}" --host=0.0.0.0
